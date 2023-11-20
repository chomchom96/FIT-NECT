<template>
  <h2> 마이페이지 !!! </h2>


  <div class="my-page-container">
    <h2 class="page-title">마이페이지</h2>
    <div class="nav-links">
      <router-link :to="`/mypage/info`" class="nav-link">계정 정보</router-link>
      <router-link to="/mypage/detail" class="nav-link">사용자 정보</router-link>
      <a @click="deleteUser" class="nav-link" :class="{ 'active-link': $route.path === '/mypage/delete' }">계정 탈퇴</a>
    </div>
    <router-view></router-view>
  </div>
</template>

<script setup>
import { useUserStore } from '../../stores/user';
import { ref } from 'vue'; 

const store = useUserStore()

const id = ref(store.idValue);

const deleteUser = function() {
  if(confirm("회원을 탈퇴하시겠습니까?")){
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
