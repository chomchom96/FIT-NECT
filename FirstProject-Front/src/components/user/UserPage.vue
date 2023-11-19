<template>
  <h2> 마이페이지 !!! </h2>


  <div class="my-page-container">
    <h2 class="page-title">마이페이지</h2>
    <div class="nav-links">
      <router-link to="/mypage/info" class="nav-link">계정 정보</router-link>
      <router-link to="/mypage/detail" class="nav-link">사용자 정보</router-link>
      <a @click="deleteUser" class="nav-link" :class="{ 'active-link': $route.path === '/mypage/delete' }">계정 탈퇴</a>
    </div>
    <router-view></router-view>
  </div>
</template>

<script setup>
import { useUserStore } from '../../stores/user';
const store = useUserStore()
const deleteUser = function() {
  alert("회원을 탈퇴하시겠습니까?")
  if (confirm("확인하시면 계정이 영구적으로 삭제됩니다.")) {
    if (comfirm("진짜 진짜 삭제하시겠습니까>")) {
      store.deleteUser();
    }
  }
}
</script>

<style scoped>
.my-page-container {
  text-align: center;
  padding: 20px;
}

.page-title {
  display: inline-block;
  border-bottom: 2px solid #FFD700; /* Yellow color */
  padding-bottom: 5px;
  margin-bottom: 20px;
}

.nav-links {
  text-align: left;
  margin-bottom: 20px;
}

.nav-link {
  display: block;
  margin-bottom: 10px;
  color: #333; /* Adjust color as needed */
  text-decoration: none;
  font-weight: bold;
}

.nav-link:hover {
  color: #FFD700; /* Yellow color on hover */
}
</style>
