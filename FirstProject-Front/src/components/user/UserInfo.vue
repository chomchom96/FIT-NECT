<template>
    <div class="container">
    <div class="col-md-8 order-md-1">
      <h4 class="mb-3">내 정보 수정</h4>
      <form class="needs-validation" novalidate>
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="firstName">ID</label>
            <input type="text" class="form-control" id="userId">
          </div>
        </div>

        <div class="mb-3">
          <label for="username">Email</label>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text">@</span>
            </div>
            <input type="text" class="form-control" id="username" placeholder="Username" required>
            <div class="invalid-feedback" style="width: 100%;">
              Your username is required.
            </div>
          </div>
        </div>

        <div class="mb-3">
          <label for="email">Email <span class="text-muted">(Optional)</span></label>
          <input type="email" class="form-control" id="email" placeholder="you@example.com">
          <div class="invalid-feedback">
            Please enter a valid email address for shipping updates.
          </div>
        </div>

        <div class="mb-3">
          <label for="address">Address</label>
          <input type="text" class="form-control" id="address" placeholder="1234 Main St" required>
          <div class="invalid-feedback">
            Please enter your shipping address.
          </div>
        </div>

        <div class="mb-3">
          <label for="address2">Address 2 <span class="text-muted">(Optional)</span></label>
          <input type="text" class="form-control" id="address2" placeholder="Apartment or suite">
        </div>

        <hr class="mb-4">
      </form>
    </div>
    </div>
  </template>

<script setup>
import { useUserStore } from "@/stores/user.js";
import { ref } from 'vue';
import { onMounted, watch } from "vue"; 
import axios from "axios";
import { useRoute, useRouter } from 'vue-router'


const placeholderText1 = ref(""); 
const placeholderText2 = ref(""); 

const router = useRouter();

const store = useUserStore();
// const user = ref({});

console.log(store.idValue);

const user = ref({
  id: "",
  password: "",
  name: "",
  email: "",
});


console.log(user);


//사용자가 입력한 변수들 
const email = ref("");
const nickname = ref("");
const oldPassword = ref("");
const newPassword = ref("");

onMounted(() => {
  const pathName = new URL(document.location).pathname.split("/");
//   console.log(pathName);
  const id = pathName[pathName.length - 1];
//   console.log(id);
  const API_URL = `http://localhost:8080/api/users/${store.idValue}`;
  axios({
    url: API_URL,
    method: "GET"
  })
    .then((res) => {
      user.value.id = res.data.userId;
      user.value.password = res.data.userPassword;
      user.value.name = res.data.userNickname;
      user.value.email = res.data.userEmail;
      placeholderText1.value = `${user.value.email}`;
      placeholderText2.value = `${user.value.name}입니당`;
    })
    .catch((err) => {
        // console.log(res.data) 
        // console.log(id)
        // console.log(user.value.name);
        // console.log(user); 
      console.log(err);
    });
});

watch(() => user.value.email, (newEmail) => {
  placeholderText1.value = `${newEmail}`;
});

watch(() => user.value.name, (newName) => {
  placeholderText2.value = `${newName}`;
});

// console.log(user.value.id)
// console.log(user.userEmail)

const update = async () => {
const password = oldPassword.value;
const userConfirm = {
    userId: store.idValue,
    userPassword: oldPassword.value,
    userEmail: store.user.userEmail
};


//새로운 비밀번호, 닉네임, 이메일을 포함하여 업데이트할 사용자 정보 
const userToUpdate = {
    userId: store.idValue,
    userPassword: newPassword.value,
    userNickname: nickname.value,
    userEmail: email.value
};


try {
    const existingUser = await store.getUserDetail(userConfirm.userId);
console.log(userConfirm.userId)
console.log(userConfirm.userPassword)
console.log(userConfirm.userEmail)

console.log(userToUpdate.userId)
console.log(userToUpdate.userPassword)
console.log(userToUpdate.userNickname)
console.log(userToUpdate.userEmail)

console.log(existingUser)
console.log(store.user.value)
console.log(store.user.password)
console.log(user.value.password)
console.log(user.value.email)


if (userConfirm.userPassword === user.value.password) {
    await store.updateUser(userToUpdate);
    console.log("업데이트 성공");
} else {
    alert("이전 비밀번호가 불일치합니다")
}
  } catch (error) {
    console.log(error);
  }
};


</script>
<style></style>