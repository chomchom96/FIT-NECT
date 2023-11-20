<template>
  <div class="video-list-page">
    <!-- <div class="video-list-page">
    <h2>영상 목록</h2>
    <div class="video-list-card">
      <table>
        <thead>
          <tr>
            <th>제목</th>
            <th>URL</th>
            <th>부위</th>
            <th>조회수</th>
            <th>채널명</th>
            <th>등록일</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="video in store.videoList" :key="video.videoId">
            <td>
              <router-link :to="`/video/${video.videoId}`">{{ video.videoTitle }}</router-link>
            </td>
            <td>{{ video.videoUrl }}</td>
            <td>{{ video.videoPart }}</td>
            <td>{{ video.videoViewCnt }}</td>
            <td>{{ video.videoChannelName }}</td>
            <td>{{ video.videoCreatedAt }}</td>
          </tr>
        </tbody>
      </table>
  </div> -->


    <div>
      <div class="row">
        <div class="card my-2 col-12 col-sm-6 col-md-3" v-for="(video, index) in store.videoList" :key="video.videoId">
          <img v-if="video.thumbnailUrl" :src="video.thumbnailUrl" class="card-img-top" alt="...">

          <div class="card-body">
            <h5>
              <router-link :to="`/video/${video.videoId}`">{{ video.videoTitle }}</router-link>
            </h5>
            <!-- <h5 class="card-title">{{ video.videoTitle }}</h5> -->
            <p class="card-text text-truncate">{{ video.videoChannelName }}</p>
            <ul class="list-group list-group-flush">
              <li class="list-group-item">파트 : {{ video.videoPart }}</li>
              <li class="list-group-item">조회수 : {{ video.videoViewCnt }}</li>
              <li class="list-group-item">등록일 : {{ video.videoCreatedAt }}</li>
            </ul>
          </div>
        </div>
      </div>
    </div>










    <form @submit.prevent="submitSearchForm" class="row">
      <div class="col-2" style="display: inline-block;">
        <select v-model="searchKey" class="form-select">
          <option value="videoId">영상번호</option>
          <option value="videoTitle">제목</option>
          <option value="videoPart">부위</option>
          <option value="videoChannelName">채널명</option>
          <option value="videoCreatedAt">등록일</option>
          <option value="videoViewCnt">조회수</option>
          <option value="videoUrl">영상Url</option>
        </select>
      </div>
      <div class="col-5" style="display: inline-block;">
        <input v-model="searchWord" name="word" class="form-control">
      </div>

      <!--정렬기준 일단 주석처리/검색과 동시에 안됨-->
      <!-- <div class="col-2">
					<label>정렬 기준 :</label>
					<select v-model="searchOrderBy" class="form-select">
						<option value="none">없음</option>
						<option value="videoId">영상번호</option>
						<option value="videoPart">부위</option>
						<option value="videoChannelName">채널명</option>
            <option value="videoCreatedAt">등록일</option>
            <option value="videoViewCnt">조회수</option>
					</select>
				</div>
				<div class="col-2">
					<label>정렬 방향 :</label>
					<select v-model="searchOrderByDir" class="form-select">
						<option value="asc">오름차순</option>
						<option value="desc">내림차순</option>
					</select>
				</div> -->


      <div class="col-1">
        <input type="submit" value="검색">
      </div>


    </form>

    <router-link :to="{ name: 'VideoRegist' }">
      <button>Regist</button>
    </router-link>







  </div>
</template>

<script setup>
import { ref, onMounted, defineProps } from 'vue'
import { useVideoStore } from '@/stores/video'
import { useUserStore } from '../../stores/user'
import videoImage from '@/assets/coder.png';
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter();
const route = useRoute();

const store = useVideoStore()
const userStore = useUserStore();

// onMounted(() => {
//   store.getVideoList();
// })

onMounted(async () => {
  for (const video of store.videoList) {
    video.thumbnailUrl = await getYouTubeThumbnail(video.videoUrl);
  }

  searchKey.value = "videoTitle";
});

const searchKey = ref("none");
const searchWord = ref("");
const searchOrderBy = ref("none");
const searchOrderByDir = ref("asc");

const thumbnailUrl = ref("");


const submitSearchForm = () => {
  const searchParams = {
    key: searchKey.value,
    word: searchWord.value,
    orderBy: searchOrderBy.value,
    orderByDir: searchOrderByDir.value,
  };
  store.searchVideoList(searchParams);
};

const props = defineProps({
  video: {
    type: Array,
    default: () => [],
  },
});


const getYouTubeThumbnail = async (videoUrl) => {
  const videoId = videoUrl.split('v=')[1];
  const apiUrl = `https://www.googleapis.com/youtube/v3/videos?id=${videoId}&key=AIzaSyANdyu5u5Z_7a4R670KJKAA8wD8bNWVe2Y&part=snippet`;

  try {
    const response = await fetch(apiUrl);
    const data = await response.json();
    const thumbnailUrl = data.items[0]?.snippet?.thumbnails?.medium?.url || '';
    console.log('Thumbnail URL:', thumbnailUrl);
    return thumbnailUrl;

  } catch (error) {
    console.error('Error fetching YouTube API:', error);
    return '';
  }
};
</script>

<style scoped>
.video-list-page {
  max-width: 1100px;
  margin: auto;
  padding: 20px;
}

.video-list-card {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  overflow: hidden;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 15px;
  text-align: center;
}

th,
td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #ddd;
  text-align: center;

}

th {
  background-color: #f2f2f2;
}
</style>