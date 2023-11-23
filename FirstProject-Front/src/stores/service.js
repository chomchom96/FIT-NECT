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
      if (err.response.status === 400) {
        alert("등록된 트레이너가 없습니다")
      }
      console.log(err)
    })
  }
  
  const selectTrainer = (userId, trainerId) => {
    console.log(userId + trainerId)
    axios({
      url: "http://localhost:8080/api/product/" + userId,
      method: "POST",
      data: trainerId
    })
    .then(() => {
      alert("트레이너 신청이 완료되었습니다.")
      router.push('/')
    })
    .catch((e) => {
      if (e.response.status === 500) {
        alert("이미 매칭을 신청하셨습니다!")
      }
      console.log(e)
    })
  }
  return {
    registDetail, getDetails, trainerDetailList, selectTrainer
  };

});