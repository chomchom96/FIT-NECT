import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { defineStore } from 'pinia'
import axios from "axios";

export const useTrainerStore = defineStore('trainer', ()=>{
  const router = useRouter();
  const trainerList = ref([]);
  const getTrainer = ref(false)
  const trainer = ref({});
  const idValue = ref('')

  const getTrainerList = () => {
    axios({
      url: "http://localhost:8080/api/trainers" ,
      method: "GET",
    })
    .then((res) => {
      trainerList.value = res.data;
    })
    .catch((err) => {
      console.log(err);
    });
  };

  const getTrainerDetail = (id) => {
    return axios({
      url: `http://localhost:8080/api/trainers/${id}`,
      method: "GET",
    })
    .then((res) => {
      trainer.value = res.data;
      return trainer.value;
    })
    .catch((err) => {
      console.log(err);
      throw err;
    });
  };

  const updateTrainer = (trainer) => {
    axios({
      url: `http://localhost:8080/api/trainers/${trainer.id}`,
      method: "PUT", 
      data: trainer.value
    })
      .then(() => {
        alert("계정 정보 업데이트!")
        router.push('/mypage')
      })
      .catch((err) => {
        alert("예전 비밀번호를 잘못 입력했습니다");
        console.log(err);
      });
  };

  const deleteTrainer = () => {
    axios({
      url: `http://localhost:8080/api/trainers/${idValue.value}`,
      method: "DELETE", 
      data: trainer.value
    })
      .then(() => {
        alert("계정 삭제 완료")
        router.push('/')
      })
      .catch((err) => {
        console.log(err);
      });
  }

  const trainerSignup = (trainer) => {
    axios({
      url: 'http://localhost:8080/api/trainers/signup',
      method: "POST",
      data: {
        trainerId: trainer.id,
        trainerPassword: trainer.password,
      },
    })
      .then(() => {
        alert("회원가입 성공!");
        getTrainerList();
        router.push("/Trainers");
      })
      .catch((err) => {
        alert("중복된 아이디입니다")
        console.log(err);
      });
  };

  const loginTrainer = (trainer) => {
    axios({
      url: 'http://localhost:8080/api/login',
      method: "POST",
      data: {
        trainerId: trainer.id,
        trainerPassword: trainer.password,
      },
    })
    .then((res) => {
      sessionStorage.setItem('access-token', res.data["access-token"])
      const token = res.data['access-token'].split('.')
      let id = token[1]
      id = atob(id)
      id = JSON.parse(id)
      console.log(id.id)
      idValue.value = id.id
      getTrainer.value = true
      console.log(idValue.value)
      console.log(getTrainer.value)
      alert("로그인 성공!")
      router.push("/");
    })
    .catch((err) => {
      console.log(err);
      alert("로그인 실패");
    });
  };


  const trainerLogout = () => {
    idValue.value = '';
    alert("로그아웃 하셨습니다")
    getTrainer.value = false
    router.push("/")
  };

  onMounted(() =>
    getTrainerList()
  )

  return { router, idValue, trainerList, getTrainerList, trainerSignup, onMounted, loginTrainer, trainerLogout, getTrainer, getTrainerDetail, Trainer: trainer, updateTrainer, deleteTrainer}

})