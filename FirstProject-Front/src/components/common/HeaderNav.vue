<template>
  <header>
    <nav class="header-nav">
      <div>
        <RouterLink to="/" class="logo">SSAFIT</RouterLink>
      </div>

      <div class="dropdown">
        <a href="#">ABOUT</a>

        <div class="dropdown-content">
          <RouterLink to="/about">ABOUT US</RouterLink>

          <a href="#">ABOUT FI-NECT</a>
        </div>
      </div>

      <div class="dropdown">
        <RouterLink to="/service/"> SERVICE </RouterLink>

        <div class="dropdown-content">
          <RouterLink :to="{ name: 'ServiceForm' }"> START SERVICE </RouterLink>

          <RouterLink to="/trainers/show"> OUR TRIAINERS </RouterLink>
        </div>
      </div>

      <div class="dropdown">
        <a href="#"> COMMUNITY</a>

        <div class="dropdown-content">
          <RouterLink to="/board">자유게시판</RouterLink>

          <a href="#">HOW TO FI-NECT</a>
        </div>
      </div>

      <div class="dropdown">
        <RouterLink to="/contact">CONTACT</RouterLink>
      </div>

      <div class="dropdown" v-if="!userStore.getUser">
        <a>TRAINER</a>

        <div class="dropdown-content">
          <div v-if="!trainerStore.getTrainer & userStore.idValue != 'admin'">
            <RouterLink to="/trainers/login">LOGIN</RouterLink>
          </div>

          <div v-else>
            <RouterLink to="/trainers/list">LIST</RouterLink>
            <RouterLink v-if="trainerStore.getTrainer" to="/trainers/manage"
              >회원 관리</RouterLink
            >
            <RouterLink
              v-if="trainerStore.getTrainer"
              to="/"
              @click="trainerStore.trainerLogout"
              >로그아웃</RouterLink
            >
          </div>
        </div>
      </div>

      <div>
        <a href="#" v-if="userStore.getUser">
          <div class="dropdown">
            <div>{{ userStore.idValue }}님, 환영합니다.</div>

            <div class="dropdown-content">
              <RouterLink to="/myinfo">계정정보관리</RouterLink>

              <RouterLink to="/mydetail">개인정보관리</RouterLink>

              <RouterLink to="/users/follow">팔로우 관리</RouterLink>

              <RouterLink to="/users/schedule">내 스케줄</RouterLink>

              <RouterLink to="/" @click="logout">로그아웃</RouterLink>
            </div>
          </div>
        </a>

        <div v-if="!userStore.getUser & !trainerStore.getTrainer">
          <RouterLink to="/login">LOGIN</RouterLink>
          <RouterLink :to="{ name: 'UserSignup' }">SIGN UP</RouterLink>
        </div>
        <RouterLink to="/video">VIDEO</RouterLink>
        <RouterLink v-show="userStore.idValue == 'admin'" to="/users">USER</RouterLink>
      </div>
    </nav>
  </header>
</template>

<script setup>
import { useUserStore } from "@/stores/user";
import { RouterLink } from "vue-router";
import { computed } from "vue";
import { useTrainerStore } from "../../stores/trainer";

const userStore = useUserStore();
const trainerStore = useTrainerStore();

const logout = () => {
  userStore.logout();
};


</script>

<style>
/*드롭다운 메뉴*/
.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  z-index: 1;
  /*다른 요소들보다 앞에 배치*/
}

.dropdown-content a {
  display: block;
  color: black;
  text-align: center;
}

.dropdown:hover .dropdown-content {
  display: block;
}

header {
  height: 70px;
  background-color: rgb(166, 173, 224);
  line-height: 70px;
  padding: 0px 30px;
}

header a {
  margin: 10px;
  text-decoration: none;
  color: white;
}

.header-nav {
  display: flex;
  justify-content: space-between;
}

.logo {
  display: inline-block;
  font-size: 2rem;
  font-weight: bold;
  color: white;
  margin: 0;
}
</style>
