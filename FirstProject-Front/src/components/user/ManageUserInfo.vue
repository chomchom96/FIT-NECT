<template>
    <div class="container" style="max-width:40%; margin-top: 40px;">
      <br>
      <h2 style="text-align: center;">회원 정보</h2>
      <br>
  
      <fieldset class="text-center">
        <label for="userId">아이디</label>
        <input readonly
          type="text"
          id="id"
          v-model="user.id"
          class="view"
          style="width:400px;"
        /><br />
        <div v-if="user.password!==null">
        <label for="password">비밀번호</label>
        <input
          type="password"
          id="password"
          v-model="user.password"
          class="view"
          style="width:400px;"
        />
        </div>
        <div v-else>
          <label for="password">비밀번호</label>
          <input
          type="text" readonly
          id="password"
          placeholder="소셜 로그인 회원입니다"
          class="view"
          style="width:400px;"
        />
        </div>
      
        <label for="name">이름</label>
        <input type="text" id="name" v-model="user.name" class="view" style="width:400px;"/><br />
        <label for="email">이메일</label>
        <input type="email" id="email" v-model="user.email" class="view" style="width:400px; margin-bottom:40px;" /><br />
        <button class="btn" @click="deleteUser">회원 삭제</button>
      </fieldset>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from "vue";
  import axios from "axios";
  
  const emit = defineEmits();
  
  const user = ref({
    id: "",
    password: "",
    name: "",
    email: "",
  });
  
  const updateUser = () => {
    emit("update-user", user.value);
  };
  
  const deleteUser = () => {
    emit("delete-user", user.value);
  };
  
  onMounted(() => {
    const pathName = new URL(document.location).pathname.split("/");
    const id = pathName[pathName.length - 1];
    const API_URL = `http://localhost:8080/api/users/${id}`;
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
  </script>

<style scoped>
  .btn {
  padding: 10px;
  background-color: #333;
  /* 무채색 배경 */
  color: #fff;
  /* 흰색 텍스트 */
  border: none;
  cursor: pointer;
  width: 120px;
}

.btn:hover {
  background-color: #555;
  /* 호버 시 어둡게 변하는 배경 */
}
</style>