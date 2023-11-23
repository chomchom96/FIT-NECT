<template>
  <div>
    <!-- <img src="/src/assets/background_1.png"> -->
    <HeaderNav :user="user" @logout="logout" />
    <RouterView />
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import HeaderNav from "@/components/common/HeaderNav.vue";

const user = ref(null);

onMounted(() => {
  const savedUser = localStorage.getItem("loginUser");
  if (savedUser) {
    user.value = JSON.parse(savedUser);
  }
});

const logout = () => {
  user.value = null;
  localStorage.removeItem("loginUser");
};

</script>
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  list-style: none;
  font-family: Nanum-Gothic, sans-serif;
}
.text-center {
  text-align: center;
}

</style>