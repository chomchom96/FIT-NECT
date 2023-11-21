<template>
  <h2 class="page-title">마이 페이지</h2>

  <div class="page-container">
    <div class="nav-container">
      <div class="nav-links">
        <router-link :to="`/mypage/info`" class="nav-link">계정 정보</router-link>
        <router-link to="/mypage/detail" class="nav-link">사용자 정보</router-link>
        <a @click="deleteUser" class="nav-link" :class="{ 'active-link': $route.path === '/mypage/delete' }">계정 탈퇴</a>
      </div>
      <router-view></router-view>
    </div>
    <div class="col-md-8 order-md-1">
      <h4 class="mb-3" style="padding-left: 10px;">내 정보</h4>
      <br>
      <form class="needs-validation" novalidate>
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="userId">ID</label>
            <input type="text" class="form-control" id="userId" readonly>
          </div>
        </div>

        <div class="mb-3">
          <label for="userEmail">Email</label>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text">@</span>
            </div>
            <input type="text" class="form-control" id="userEmail" placeholder="email" readonly>
          </div>
        </div>

        <div class="col-md-6 mb-3">
          <label for="userNickname">Nickname</label>
          <input type="userNickname" class="form-control" id="userNickname">
  
        </div>

        <!-- <div class="mb-3">
          <label for="address">Address</label>
          <input type="text" class="form-control" id="address" readonly>
        </div> -->

      </form>
    </div>
  </div>
</template>

<script setup>
import { useUserStore } from '../../stores/user';
import { ref, onMounted } from "vue";
import axios from "axios";
const store = useUserStore()

const user = ref({
  id: "",
  password: "",
  name: "",
  email: "",
});


onMounted(() => {
  console.log(store.idValue)
  const API_URL = `http://localhost:8080/api/users/${store.idValue}`;
  axios({
    url: API_URL,
    method: "GET",
  })
    .then((res) => {
      user.value.id = res.data.userId;
      user.value.password = res.data.userPassword;
      user.value.name = res.data.userNickname;
      user.value.email = res.data.userEmail;
    })
    .catch((err) => {
      console.log(err);
    });
});


const deleteUser = function () {
  if (confirm("회원을 탈퇴하시겠습니까?")) {
    console.log(store.idValue)
    if (confirm("확인하시면 계정이 영구적으로 삭제됩니다.")) {
      if (confirm("정말 삭제하시겠습니까? 이제는 돌이킬 수 없습니다")) {
        store.deleteUser();
        alert("지금까지 SSAFIT을 이용해주셔서 감사드립니다")
      }
    }
  }
}



</script>

<style scoped>
.page-container {
  display: flex;
  align-items: baseline;
}

.nav-container {
  text-align: center;
  padding: 20px;
}

.page-title {
  padding-bottom: 10px;
  margin: 20px;
  text-align: center;
}

.nav-links {
  text-align: left;
  margin-bottom: 20px;
  flex-direction: column;
}

.nav-link {
  width: 150px;
  margin-bottom: 10px;
  color: #333;
  text-decoration: none;
  font-weight: bold;
  text-align: left;
}

.nav-link:hover {
  color: #FFD700;
  /* Yellow color on hover */
}




label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}
</style>
