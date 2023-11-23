import { ref, onMounted } from 'vue'
import { defineStore } from 'pinia'
import router from '@/router'
import axios from 'axios'

export const useVideoStore = defineStore('video', ()=> {
  const videoList = ref([])
  const video = ref([]); 

  const searchKey = ref("none");
  const searchWord = ref("");
  const searchOrderBy = ref("none");
  const searchOrderByDir = ref("asc");
  
  const getVideoList= function () {
    axios.get(`http://localhost:8080/api/video/`)
    .then((res) => {
      videoList.value = res.data
      console.log(videoList)
    })
  }

  onMounted(() => {
    getVideoList();
  });

  const getVideo = function(id) {
    axios.get(`http://localhost:8080/api/video/${id}`)
    .then((res) => {
      video.value = res.data
    })
  }

  const getVideoById = function(id) {
    const video = ref({});
    axios.get(`http://localhost:8080/api/video/${id}`)
    .then((res) => {
      video.value = res.data
    })
    return video;
  }


  //영상 검색 기능
  const searchVideoList = (searchParams) => {
    const API_URL = "http://localhost:8080/api/video";
    axios({
      url: API_URL,
      method: "GET",
      params: searchParams
    })
      .then((res) => {
        videoList.value = res.data;
        console.log(videoList)
      })
      .catch((err) => {
        console.log(err);
      });
  };

  const submitSearchForm = () => {
    const searchParams = {
      key: searchKey,
      word: searchWord,
      orderBy: searchOrderBy,
      orderByDir: searchOrderByDir
    }
    searchVideoList(searchParams); 
  }

  const registVideo = function (part, title, url, channelName) {
    video.value.videoPart = part.value;
    video.value.videoTitle = title.value;
    video.value.videoUrl = url.value;
    video.value.videoChannelName = channelName.value;

    axios({
      url: 'http://localhost:8080/api/video',
      method: 'POST',
      headers: {
          "Content-Type": "application/json"
      },
      data: video.value
    })
    .then(() => {
      alert('등록 성공!')
      router.push("/video")
    })
    .catch((err) => {
      console.log(err)
    })
  }

  return {getVideo,submitSearchForm, searchVideoList, getVideoList, videoList, video, registVideo,
  getVideoById}

})