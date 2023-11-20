import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { defineStore } from 'pinia'
import axios from "axios";

export const useUserStore = defineStore('user', ()=>{
  const router = useRouter();
  const userList = ref([]);
  const idValue = ref("");
  const getUser = ref(false)
  const user = ref({});
  const userEmail = ref('');
  const userSchedule = ref('');

  const getUserList = () => {
    axios({
      url: "http://localhost:8080/api/users" ,
      method: "GET",
    })
    .then((res) => {
      userList.value = res.data;
    })
    .catch((err) => {
      console.log(err);
    });
  };

  const getUserDetail = (id) => {
    axios({
      url: "http://localhost:8080/api/users/" +id,
      method: "GET",
    })
    .then((res) => {
      user.value = res.data;
      userEmail.value = res.data.userEmail;
    })
    .catch((err) => {
      console.log(err);
    });
  };
  const updateUser = (user) => {
    axios({
      url: `http://localhost:8080/api/users/${user.id}`,
      method: "PUT", 
      data: user.value
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

  const deleteUser = () => {
    axios({
      url: `http://localhost:8080/api/users/${idValue.value}`,
      method: "DELETE", 
    })
      .then(() => {
        alert("계정 삭제 완료")
        router.push('/')
      })
      .catch((err) => {
        console.log(err);
      });
  }

  const signup = (user) => {
    axios({
      url: 'http://localhost:8080/api/users/signup',
      method: "POST",
      data: {
        userId: user.id,
        userPassword: user.password,
      },
    })
      .then(() => {
        alert("회원가입 성공!");
        getUserList();
        router.push("/users");
      })
      .catch((err) => {
        alert("중복된 아이디입니다")
        console.log(err);
      });
  };

  const checkAuthentication = () => {
    const token = sessionStorage.getItem('access-token');
    if (token) {
      const decodedToken = atob(token.split('.')[1]);
      const userData = JSON.parse(decodedToken);
      idValue.value = userData.id;
      getUser.value = true;
    }
  };

  const loginUser = (user) => {
    axios({
      url: 'http://localhost:8080/api/login',
      method: "POST",
      data: {
        userId: user.id,
        userPassword: user.password,
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
      getUser.value = true
      alert("로그인 성공!")
      router.push("/");
    })
    .catch((err) => {
      console.log(err);
      alert("로그인 실패");
    });
  };

  const logout = () => {
    idValue.value = '';
    alert("로그아웃 하셨습니다")
    getUser.value = false
    router.push("/")
  };

  

  onMounted(() => {
    getUserList(); 
    checkAuthentication();
  })

  return { router, idValue, userList, 
    getUserList, signup, onMounted, 
    loginUser, logout, getUser, 
    getUserDetail, user, updateUser, deleteUser, 
    userEmail, checkAuthentication}

})