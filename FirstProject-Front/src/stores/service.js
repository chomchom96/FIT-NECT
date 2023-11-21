import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { defineStore } from 'pinia'
import axios from "axios";

export const useServiceStore = defineStore('service', () => {
  const router = useRouter();
  const trainerDetailList = ref([]);

  const registDetail = (userDetail) => {
    console.log(userDetail)
    console.log(userDetail.userId)
    axios({
      url: `http://localhost:8080/api/product`,
      method: "POST",
      data: userDetail
    })
    .then(() => {
      router.push('/service/trainers')
    })
    .catch((e) => {
      console.log(e)
    })
  };

  const getDetails = () => {
    axios({
      url: "http://localhost:8080/api/trainers/detail",
      method: "GET"
    })
    .then((res) => {
      trainerDetailList.value = res.data;
    })
    .catch((err) => {
      console.log(err)
    })
  }
  
  const selectTrainer = (userId, trainerId) => {
    console.log(userId + trainerId)
    axios({
      url: "http://localhost:8080/api/product/" + userId,
      method: "POST",
      data: trainerId.value
    })
    .then(() => {
      alert("트레이너 신청이 완료되었습니다.")
      router.push('/')
    })
    .catch((e) => {
      console.log(e)
    })
  }
  return {
    registDetail, getDetails, trainerDetailList, selectTrainer
  };

});