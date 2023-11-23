<template>
  <div class="container my-5">
    <div class="card">
      <div class="card-body">
        <h2 class="card-title">영상 등록</h2>

        <form @submit.prevent="registVideo">

          <div class="mb-3">
            <label for="part" class="form-label">부위</label>
            <select v-model="part" id="part" class="form-select" required>
              <option v-for="partOption in partOptions" :key="partOption" :value="partOption">
                {{ partOption }}
              </option>
            </select>
          </div>

          <div class="mb-3">
            <label for="url" class="form-label">URL</label>
            <input v-model="url" type="url" id="url" class="form-control" required>
          </div>

          <button type="submit" class="btn btn-primary">등록</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'
import { useVideoStore } from '@/stores/video'
import router from '../../router';

const store = useVideoStore();

const part = ref('')
const url = ref('')
const title = ref('')
const channelName = ref('')

const partOptions = [
  '유산소 운동',
  '가슴 운동(대흉근)',
  '어깨 운동(삼각근)',
  '복부 운동(복직근, 내복사근, 외복사근)',
  '등 운동(광배근, 승모근, 능형근)',
  '윗팔 운동/상완운동(상완이두근,상완삼두근)',
  '아랫팔 운동/전완운동(전완 굴곡근, 전완 신전근)',
  '허벅지 운동(대퇴부,슬굴곡근)',
  '종아리 운동(비복근, 가자미근)'
];

// const API_KEY = import.meta.env.VITE_YOUTUBE_API_KEY
const API_KEY = "AIzaSyClZuKzJiSnKF_ELcnzct9im-pDerHLjAo"

const getVideoTitleAndChannelName = async () => {
  const keyValuePairs = url.value.split('=');
  const videoId = keyValuePairs[1];
  console.log(videoId)
  const apiUrl = `https://www.googleapis.com/youtube/v3/videos?part=snippet&id=${videoId}&key=${API_KEY}`;
  try {
    const response = await axios.get(apiUrl);
    console.log(response);
    title.value = response.data.items[0].snippet.title;
    channelName.value = response.data.items[0].snippet.channelTitle;
    console.log(title.value) 
  } catch (error) {
    console.log(error);
  }
};

const registVideo = async function () {
  await getVideoTitleAndChannelName();
  await store.registVideo(part, title, url, channelName);
}
</script>
