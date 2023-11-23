<template>
  <div class="video-list-page">
    <div>
      <div class="row">
        <div class="card my-2 col-12 col-sm-6 col-md-3" v-for="(video, index) in computedVideos" :key="video.videoId">

          <div class="card-body">
            <img v-if="video.thumbnailUrl" :src="video.thumbnailUrl" class="card-img-top" alt="..." style="padding: 5px;">
            <p style="font-size: 17px;">
              <router-link :to="`/video/${video.videoId}`">{{ video.videoTitle }}</router-link>
            </p>
            <!-- <h5 class="card-title">{{ video.videoTitle }}</h5> -->
            <p class="card-text text-truncate">{{ video.videoChannelName }}</p>
            <ul class="list-group list-group-flush">
              <li class="list-group-item">{{ video.videoPart }}</li>
              <li class="list-group-item">조회수 {{ video.videoViewCnt }}</li>
              <li class="list-group-item">{{ video.videoCreatedAt }}</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <div class="search-container">
      <form @submit.prevent="submitSearchForm" class="d-flex justify-content-center align-items-center">
        <div class="col-2">
          <select v-model="searchKey" class="form-select">
            <option value="videoId">영상번호</option>
            <option value="videoTitle">제목</option>
            <option value="videoPart" selected>부위</option>
            <option value="videoChannelName">채널명</option>
            <option value="videoCreatedAt">등록일</option>
          </select>
        </div>

        <div class="col-8" v-if="searchKey !== 'videoPart'">
          <input v-model="searchWord" name="word" class="form-control">
        </div>

        <div class="col-6" v-if="searchKey === 'videoPart'">
          <select v-model="selectedPart" class="form-select">
            <option value="유산소">유산소</option>
            <option value="어깨 운동">어깨</option>
            <option value="등 운동">등</option>
            <option value="가슴 운동">가슴</option>
            <option value="윗팔 운동">윗팔</option>
            <option value="아랫팔 운동">아랫팔</option>
            <option value="허벅지 운동">허벅지</option>
            <option value="종아리 운동">종아리</option>
          </select>
        </div>

        <button class="btn btn-secondary" type="button" @click="submitSearchForm">검색</button>
      </form>
    </div>
    <div>
      <router-link :to="{ name: 'VideoRegist' }">
        <button type="submit" class="btn btn-primary">Regist</button>
      </router-link>
    </div>
    <nav aria-label="Page navigation">
      <ul class="pagination">
        <li class="page-item" :class="{ disabled: currentPage === 1 }">
          <a class="page-link" @click="changePage(currentPage - 1)" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
          </a>
        </li>
        <li v-for="page in pages" :key="page" class="page-item" :class="{ active: page === currentPage }">
          <a class="page-link" @click="changePage(page)">{{ page }}</a>
        </li>
        <li class="page-item" :class="{ disabled: currentPage === totalPages }">
          <a class="page-link" @click="changePage(currentPage + 1)" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
          </a>
        </li>
      </ul>
    </nav>
  </div>
</template>

<script setup>
import { ref, onMounted, defineProps, computed, watch } from 'vue'
import { useVideoStore } from '@/stores/video'

const store = useVideoStore()

const itemsPerPage = 6;
const currentPage = ref(1);

const computedVideos = computed(() => {
  const startIndex = (currentPage.value - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;
  const videos = store.videoList.slice(startIndex, endIndex);

  videos.forEach(async (video) => {
    video.thumbnailUrl = await getYouTubeThumbnail(video.videoUrl);
  });

  return videos;
});

const totalPages = computed(() => Math.ceil(store.videoList.length / itemsPerPage));
console.log(totalPages)

const pages = computed(() => {
  const startPage = Math.max(1, currentPage.value - 2);
  const endPage = Math.min(totalPages.value, startPage + 4);
  console.log(startPage, endPage)
  return Array.from({ length: endPage - startPage + 1 }, (_, i) => startPage + i);
})

onMounted(() => {
  updatePages();
});


watch(currentPage, () => {
  updatePages();
});

const updatePages = () => {
  const startPage = Math.max(1, currentPage.value - 2);
  const endPage = Math.min(totalPages.value, startPage + 4);

  pages.value = Array.from({ length: endPage - startPage + 1 }, (_, i) => startPage + i);
};

const changePage = (page) => {
  if (page >= 1 && page <= totalPages.value) {
    currentPage.value = page;
  }
};


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
* {
  font-family: 'Nanum Gothic', sans-serif;
}

.video-list-page {
  background-color: rgb(240, 240, 240);
  max-width: 1100px;
  margin: auto;
  padding: 20px;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 15px;
  text-align: center;
}

th,
td {
  background-color: antiquewhite;
  padding: 12px;
  border-bottom: 1px solid #ddd;
  text-align: center;
}

th {
  background-color: #f2f2f2;
}

a {
  color: black;
}

form {
  display: flex;
}

.btn {
  background-color: #424242;
  color: #fff;
  border: none;
  cursor: pointer;
  width: fit-content;
}

nav {
  text-align: center;
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  background-color: #fff;
  border-top: 1px solid #ccc;
}

.pagination {
  display: inline-block;
  margin: 20px 0;
}

.page-item {
  display: inline-block;
  margin: 5px;
}

.page-link {
  color: #333;
  background-color: #fff;
  border: 1px solid #ddd;
}

.page-link:hover {
  background-color: #eee;
}

.page-item.active .page-link {
  color: #000;
  background-color: #f8f8f8;
  border: 1px solid #ccc;
}

.page-item.disabled .page-link {
  pointer-events: none;
}

.form-control {
  width: 60%;
}

.btn {
  background-color: #424242;
  color: #fff;
  border: none;
  cursor: pointer;
  margin-right: 10px;
}


.btn-search {
  margin-top: -5px;
}
</style>
