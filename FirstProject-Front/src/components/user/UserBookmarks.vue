<template>
    <div class="container mt-4">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title">찜한 영상 목록</h4>
            </div>
            <div  v-show="store.bookmarkDetails.length > 0" class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>제목</th>
                                <th>부위</th>
                                <th>조회수</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(video, index) in store.bookmarkDetails" :key="index">
                                <td>
                                    <router-link :to="`/video/${video.videoId}`">
                                        <h5>{{ video.videoTitle }}</h5>
                                    </router-link>
                                </td>
                                <td>{{ video.videoPart }}</td>
                                <td>{{ video.videoViewCnt }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div v-show="store.bookmarkDetails.length <= 0">
                <h4 class="card-title">아직 찜한 영상이 없습니다</h4>
            </div>
        </div>
    </div>
</template>
  
<script setup>
import { useUserStore } from '../../stores/user';
import { useVideoStore } from '../../stores/video';

const store = useUserStore();
store.getBookmarkDetail();
</script>
  
<style scoped>
/* Add your custom styles here */
.card {
    margin: 0 auto;
    max-width: 800px;
}

.card-title {
    margin-bottom: 0;
}

.table th,
.table td {
    text-align: center;
}

.table-responsive {
    overflow-x: auto;
}
</style>
  