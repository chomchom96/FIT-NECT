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
      url: `http://localhost:8080/api/users`,
      method: "PUT", 
      data: {
        userId: user.userId,
        userPassword: user.userPassword,
        userEmail: user.userEmail,
        userNickname: user.userNickname,
      }  
    })
      .then(() => {
        alert("계정 정보 업데이트!")
        router.push('/myinfo/')
      })
      .catch((err) => {
        alert("예전 비밀번호를 잘못 입력했습니다");
        console.log(err);
      });
  };

  const deleteUser = () => {
    axios({
      url: `http://localhost:8080/api/users/${idValue}`,
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

  const kakaoLogin = (kakao_account) => {
    const account = kakao_account.email;
    axios.post({
      url: 'http://localhost:8080/api/login',
      method: "POST",
      data: {
        userId: account,
      }
    })
    .then(() => {
      idValue.value = account;
      getUser.value = true;
      alert("카카오로 로그인 했습니다")
    })
    .catch(() => {
      axios({
        url: 'http://localhost:8080/api/users/signup',
        method: "POST",
        data: {
          userId: account,
          kakao : true,
        },
      })
        .then(() => {
          alert("카카오계정 가입 성공!");
          getUserList();
          router.push("/users");
        })
        .catch((err) => {
          alert("중복된 아이디입니다")
          console.log(err);
        });
    })
  }

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
    sessionStorage.removeItem('access-token'); // Remove access-token from sessionStorage
    idValue.value = '';
    getUser.value = false;
    alert("로그아웃 하셨습니다");
    router.push("/");
  };

  const follower = ref([]);
  const following = ref([]);

  const getFollower = () => {
    axios({
      url: `http://localhost:8080/api/follower/${idValue.value}` ,
      method: "GET",
    })
    .then((res) => {
      follower.value = res.data;
    })
    .catch((err) => {
      console.log(err);
    });
  }
  const getFollowing = () => {
    axios({
      url: `http://localhost:8080/api/following/${idValue.value}` ,
      method: "GET",
    })
    .then((res) => {
      following.value = res.data;
    })
    .catch((err) => {
      console.log(err);
    });
  }

  onMounted(() => {
    
    checkAuthentication();
  })

  const bookmarks = ref([]);

  const getBookmarks = () => {
    axios({
      url: `http://localhost:8080/api/user/bookmark/${idValue.value}`,
      method: "GET",
    })
    .then((res) => {
      bookmarks.value = res.data
    })
    .catch((err) => {
      console.log(err);
    })
  }

  const bookmarkDetails = ref([]);

  const getBookmarkDetail = () => {
    console.log(bookmarks.value)
    const arr = ["1", "2", "3"];
    const queryString = arr.map(id => `bookmark=${id}`).join('&');
    console.log(`http://localhost:8080/api/user/bookmark/detail?${queryString}`)
    axios({
      url: `http://localhost:8080/api/user/bookmark/detail?${queryString}`,
    })
    .then((res) => {
      bookmarkDetails.value = res.data;
    })
    .catch((err) => {
      console.log(err);
    })
  }

  const bookmarkVideo = (videoId) => {
    console.log(videoId);
    console.log(idValue.value);

    axios({
      url: 'http://localhost:8080/api/video/bookmark',
      method: "POST",
      data: {
        userId: idValue.value,
        videoId: videoId,
      },
    })
    .then(() => {
      alert("영상을 찜했습니다!")
      router.push(`/video/${videoId}`)
    })
    .catch((err) => {
      console.log(err);
    })
  }

  const unbookmarkVideo = (videoId) => {
    console.log(idValue.value);
    axios({
      url: 'http://localhost:8080/api/video/bookmark',
      method: "DELETE",
      data: {
        userId: idValue.value,
        videoId: videoId,
      },
    })
    .then(() => {
      alert("영상을 찜해제 했습니다!")
      router.push(`/video/${videoId}`)
    })
    .catch((err) => {
      console.log(err);
    })
  }

  const isBookmark = (videoId) => {
    if (bookmarks.value.includes(videoId)) return true;
    return false;
  }

  return { router, idValue, userList, 
    getUserList, signup, onMounted, 
    loginUser, logout, getUser, kakaoLogin,
    getUserDetail, user, updateUser, deleteUser, 
    userEmail, checkAuthentication,
  getFollower, getFollowing, follower, following,
  getBookmarks, bookmarks, bookmarkVideo, unbookmarkVideo, isBookmark, getBookmarkDetail, bookmarkDetails}

})