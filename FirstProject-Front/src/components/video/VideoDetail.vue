<template>
  <div class="container mt-4">
    <div class="card">
      <div class="card-body">
        <h2 class="card-title">{{ store.video.videoTitle }}</h2>
        <div class="details">
          <p class="card-text"><strong>파트:</strong> {{ store.video.videoPart }}</p>
          <div class="youtube-video">
            <iframe :src="getYouTubeEmbedUrl(store.video.videoUrl)" width="560" height="315" frameborder="0"
              allowfullscreen></iframe>
          </div>
          <p class="card-text"><strong>등록일:</strong> {{ store.video.videoCreatedAt }}</p>
          <p class="card-text"><strong>조회수:</strong> {{ store.video.videoViewCnt }}</p>
          <div v-show="userStore.isBookmark(route.params.id)">
            <button @click="userStore.unbookmarkVideo(route.params.id)">💔</button>
          </div>
          <div v-show="!userStore.isBookmark(route.params.id)">
            <button @click="userStore.bookmarkVideo(route.params.id)">❤</button>
          </div>
        </div>
      </div>
      <div>
        <h3> Comments </h3>
        <br />
        <div class="details" v-for="review in reviews" :key="review.reviewId">
          <div>
            <div class="card-body">
              <h3 class="card-title">{{ review.title }}</h3>
              <p class="card-text">{{ review.userId }}</p>
              <p class="card-text">{{ review.content }}</p>

              <button v-if="userStore.idValue === 'admin' || userStore.idValue === review.userId"
                @click="deleteReview(review.reviewId)">삭제</button>
            </div>
            <br />
          </div>
        </div>

      </div>
      <div>
        <button v-if="userStore.idValue == 'admin'" @click="updateVideo">수정</button>
        <button v-if="userStore.idValue == 'admin'" @click="deleteVideo">삭제</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUpdated } from 'vue'
import { useVideoStore } from '@/stores/video'
import { useUserStore } from '../../stores/user'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute();
const router = useRouter();
const store = useVideoStore();
const userStore = useUserStore();
const reviews = ref([])

const getYouTubeEmbedUrl = (url) => {
  if (!url) {
    return '';
  }

  const videoIdMatch = url.match(/[?&]v=([^&]+)/);
  if (!videoIdMatch) {
    return '';
  }

  const videoId = videoIdMatch[1];
  return `https://www.youtube.com/embed/${videoId}`;
};

onMounted(async () => {
  store.getVideo(route.params.id);
  increaseViewCnt();
  fetchReviews(route.params.id);
  userStore.isBookmark(route.params.id);
  console.log(userStore.isBookmark(route.params.id));
});

onUpdated(async () => {
  userStore.isBookmark(route.params.id);
});

async function increaseViewCnt() {
  try {
    console.log(route.params.id)
    await axios.post(`http://localhost:8080/api/view/${route.params.id}`);
    console.log('조회수 증가!');
  } catch (error) {
    console.log(error)
  }
};

async function fetchReviews() {
  try {
    const response = await axios.get(`http://localhost:8080/api/review/${route.params.id}`)
    reviews.value = response.data
  } catch (error) {
    console.log(error)
  }
}

const deleteReview = async function (reviewId) {
  try {
    await axios.delete(`http://localhost:8080/api/review/${reviewId}`);
    console.log('리뷰 삭제 완료!')
    await fetchReviews();
  } catch (error) {
    console.log(error);
  }
};

const updateVideo = async function (videoId) {

}


const deleteVideo = async function () {
  try {
    await axios.delete(`http://localhost:8080/api/video/${store.video.videoId}`);
    console.log('삭제 완료!')
    router.push("/video");
  } catch (error) {
    console.log(error);
  }
};
</script>

<style scoped>
.youtube-video {
  position: relative;
  width: 100%;
  padding-bottom: 56.25%;
}

.youtube-video iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
</style>
