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
        <a href="#"> SERVICE </a>
        <div class="dropdown-content">
          <a href="#">START FI-NECT</a>
          <a href="#">MY PLAN</a>
        </div>
      </div>

      <div class="dropdown">
        <a href="#"> COMMUNITY</a>
        <div class="dropdown-content">
          <RouterLink to="/board">자게</RouterLink>
          <a href="#">HOW TO FI-NECT</a>
        </div>
      </div>

      <div class="dropdown">
        <RouterLink to="/contact">CONTACT</RouterLink>
      </div>

      <div>
        <a href="#" v-if="store.getUser">
          <div class="dropdown">
            <div>{{ store.idValue }}님, 환영합니다.</div>
            <div class="dropdown-content">
              <RouterLink to="/mypage">MyPage</RouterLink>
              <a href="#">내 스케줄</a>
              <RouterLink to="/" @click="logout">로그아웃</RouterLink>
            </div>
          </div>
          <RouterLink to="/video">VIDEO</RouterLink>
        </a>
        <p to="/login" v-else>
          <RouterLink to="/login">LOGIN</RouterLink>
          <RouterLink :to="{ name: 'UserSignup' }">SIGN UP</RouterLink>
          <RouterLink to="/users">USER</RouterLink>
          <RouterLink to="/video">VIDEO</RouterLink>
        </p>
      </div>

    </nav>
  </header>
</template>

<script setup>
import { useUserStore } from "@/stores/user";
import { RouterLink } from "vue-router"
import { computed } from "vue";

const store = useUserStore();
let userId = computed(() => store.idValue)

const logout = () => {
  store.logout();
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
