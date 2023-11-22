<template>
  <main class="content">
    <div class="main bg-light p-4"> <br>
      <h3 class="mb-3" style="padding-left: 40px"><strong>계정 정보 관리</strong></h3>

      <div class="row">
        <div class="col-12 col-md-8 order-md-1">
          <div class="card card-body shadow-sm mb-4">
            <form class="needs-validation" novalidate>
              <div class="row">
                <div class="col-md-6 mb-3">
                  <label for="userId">ID</label>
                  <input
                    type="text"
                    class="form-control"
                    id="userId"
                    :value="user.id"
                    disabled
                  />
                </div>
              </div>

              <div class="mb-3">
                <label for="username">Email</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text">@</span>
                  </div>
                  <input
                    type="text"
                    class="form-control"
                    id="username"
                    :placeholder="placeholderText1"
                    v-model="user.email"
                    required
                  />
                </div>
              </div>

              <div class="mb-3">
                <label for="address">Nickname</label>
                <input
                  type="text"
                  class="form-control"
                  id="nickname"
                  :placeholder="placeholderText2"
                  v-model="user.name"
                  required
                />
                <div class="invalid-feedback">Please enter your nickname.</div>
              </div>

              <hr class="mb-4" />

              <div class="mb-3">
                <label for="oldPassword">Old Password</label>
                <input
                  type="password"
                  class="form-control"
                  id="oldPassword"
                  placeholder="Enter old password"
                  v-model="oldPassword"
                />
              </div>

              <div class="mb-3">
                <label for="newPassword">New Password</label>
                <input
                  type="password"
                  class="form-control"
                  id="newPassword"
                  placeholder="Enter new password"
                  v-model="newPassword"
                />
              </div>

              <hr class="mb-4" />
            </form>
            <container>
              <button class="btn btn-outline-dark" @click.prevent="update">
                계정정보 수정
              </button>

              <button class="btn btn-outline-dark" @click="deleteUser">계정 탈퇴</button>
            </container>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script setup>
import { useUserStore } from "@/stores/user.js";
import { ref } from "vue";
import { onMounted, watch } from "vue";
import axios from "axios";
import { useRoute, useRouter } from "vue-router";

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
  const id = pathName[pathName.length - 1];
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
      placeholderText1.value = res.data.userEmail;
      placeholderText2.value = res.data.name;
    })
    .catch((err) => {
      console.log(err);
    });
});

watch(
  () => user.value.email,
  (newEmail) => {
    placeholderText1.value = `${newEmail}`;
  }
);

watch(
  () => user.value.name,
  (newName) => {
    placeholderText2.value = `${newName}`;
  }
);

const update = async () => {
  const password = oldPassword.value;
  const userConfirm = {
    userId: store.idValue,
    userPassword: oldPassword.value,
    userEmail: store.user.userEmail,
  };
  const userToUpdate = {
    userId: store.idValue,
    userPassword: newPassword.value,
    userNickname: nickname.value,
    userEmail: email.value,
  };

  try {
    const existingUser = await store.getUserDetail(userConfirm.userId);

    if (userConfirm.userPassword === user.value.password) {
      await store.updateUser(userToUpdate);
      console.log("업데이트 성공");
    } else {
      alert("이전 비밀번호가 불일치합니다");
    }
  } catch (error) {
    console.log(error);
  }
};

const deleteUser = function () {
  if (confirm("회원을 탈퇴하시겠습니까?")) {
    console.log(store.idValue);
    if (confirm("확인하시면 계정이 영구적으로 삭제됩니다.")) {
      if (confirm("정말 삭제하시겠습니까? 이제는 돌이킬 수 없습니다")) {
        store.deleteUser();
        alert("지금까지 SSAFIT을 이용해주셔서 감사드립니다");
      }
    }
  }
};
</script>
<style scoped>
button {
  width: max-content;
}
</style>
