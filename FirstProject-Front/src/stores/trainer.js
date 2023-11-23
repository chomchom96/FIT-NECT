import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { defineStore } from 'pinia'
import axios from "axios";

export const useTrainerStore = defineStore('trainer', () => {
  const router = useRouter();
  const trainerList = ref([]);
  const getTrainer = ref(false)
  const trainer = ref({});
  const idValue = ref('')
  const userManageList = ref([])

  const getTrainerList = () => {
    axios({
      url: "http://localhost:8080/api/trainers",
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

  const registSchedule = (userId, schedule) => {
    console.log(userId);
    axios({
      url: `http://localhost:8080/api/product/schedule/${userId}`,
      method: "POST",
      data: {
        schedule
      }
    })
      .then(() => {
        alert("스케줄 등록 완료")
      })
      .catch((err) => {
        console.log(err);
      })
  }

  const modifySchedule = (userId, schedule) => {
    console.log(userId);
    axios({
      url: `http://localhost:8080/api/product/schedule/${userId}`,
      method: "PUT",
      data: {
        schedule
      }
    })
      .then(() => {
        alert("스케줄 수정 완료")
      })
      .catch((err) => {
        console.log(err);
      })
  }

  const deleteSchedule = (userId) => {
    axios({
      url: `http://localhost:8080/api/product/schedule/${userId}`,
      method: "DELETE",
    })
      .then(() => {
        alert("스케줄 삭제 완료")
        router.push("/trainers/manage")
      })
      .catch((err) => {
        console.log(err);
      })
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
      url: 'http://localhost:8080/api/trainers/login',
      method: "POST",
      data: {
        trainerId: trainer.id,
        trainerPassword: trainer.password,
      },
    })
      .then((res) => {
        console.log(res);
        sessionStorage.setItem('trainer-access-token', res.data["access-token"])
        const token = res.data['access-token'].split('.')
        let id = token[1]
        id = atob(id)
        id = JSON.parse(id)
        console.log(id.id)
        idValue.value = id.id
        getTrainer.value = true
        alert("로그인 성공!")
        router.push("/");
      })
      .catch((err) => {
        console.log(err);
        alert("로그인 실패");
      });
  };

  const checkAuthentication = () => {
    const token = sessionStorage.getItem('trainer-access-token');
    if (token) {
      const decodedToken = atob(token.split('.')[1]);
      const userData = JSON.parse(decodedToken);
      idValue.value = userData.id;
      getTrainer.value = true;
    }
  };

  const trainerLogout = () => {
    sessionStorage.removeItem('trainer-access-token'); // Remove access-token from sessionStorage
    idValue.value = '';
    alert("로그아웃 하셨습니다")
    getTrainer.value = false
    router.push("/")
  };

  onMounted(() =>
    getTrainerList(),
    checkAuthentication()
  )

  const getUserManageList = () => {
    console.log(`http://localhost:8080/api/trainers/userlist/${idValue.value}`)
    axios({
      url: `http://localhost:8080/api/trainers/userlist/${idValue.value}`,
      method: "GET"
    })
      .then((res) => {
        userManageList.value = res.data;
      })
      .catch((err) => {
        console.log(err);
      })
  }

  return {
    router, idValue, trainerList, checkAuthentication,
    getTrainerList, trainerSignup, onMounted,
    loginTrainer, trainerLogout, getTrainer,
    getTrainerDetail, Trainer: trainer,
    updateTrainer, deleteTrainer,
    getUserManageList, userManageList, registSchedule, modifySchedule, deleteSchedule
  }

})