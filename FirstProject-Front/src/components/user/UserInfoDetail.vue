<template>
    <main class="content">
      <div class="main bg-light p-4">
        <div class="row">
          <div class="col-12 col-xl-8">
            <div class="card card-body shadow-sm mb-4 ">
              <form>
                <div class="row mt-3">
                  <div class="col-md-12 mb-3">
                    <div>
                      <label for="userName">Name</label>
                      <input
                        class="form-control"
                        id="userName"
                        type="text"
                        placeholder="Enter your name"
                        required
                      />
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-12 mb-3">
                    <div class="form-group">
                      <label for="userEmail">Email</label>
                      <input
                        class="form-control"
                        id="userEmail"
                        type="email"
                        placeholder="ssafy@ssafy.com"
                        readonly
                      />
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-6 mb-3">
                    <div class="form-group">
                      <label for="userPassword">Password</label>
                     
                        <input
                          
                          class="form-control"
                          id="userPassword"
                          type="password"
                          placeholder="********"
                          required>
                      
                    </div>
                  </div>
                </div>
  
                <div class="row">
                  <div class="col-sm-12 mb-3">
                    <div class="form-group">
                      <label for="userMessage">Profile Message</label>
                      <textarea
                                        
                        class="form-control"
                        id="userMessage"
                        row="4"
                        placeholder="프로필 메세지...."
                        required
                      ></textarea>
                    </div>
                  </div>
                </div>
                <div class="row mb-3 mt-3">
                  <div class="col">
                    <div class="form-group">
                      <div class="btn-group" style="float:right;">
                        <button
                          type="submit"
                          id="successAlert"
                          class="btn btn-outline-dark"
                        >
                          <font-awesome-icon :icon="['fas', 'user-edit']" /> 수정
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </form>
            </div>
  
          </div>
          <!-- <div class="col-12 col-xl-4">
            <div class="row">
              <div class="col-12 mb-4">
                <div class="card shadow-sm text-center p-0">
                  <div
                    style="background: linear-gradient(to bottom, #262b40, #FFFFFF)"
                  ></div>
                  
                </div>
              </div>
            </div>
          </div> -->
        </div>
      </div>
    </main>
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