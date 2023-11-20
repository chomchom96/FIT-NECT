<template>

   


    <div style="width: 100%; height: 40vh; display: flex; justify-content: center; align-items: center;">
        <div style="width: 878px; height: 555px; position: relative">
            <form style="width: 400px; height: 384px; left: 223.50px; top: 119px; position: absolute">
                <button @click="update"
                    style="width: 127.28px; height: 40px; left: 135px; top: 450px; position: absolute; background: #787cbb; border-radius: 8px; justify-content: center; align-items: center; display: inline-flex">
                    <div
                        style="width: 127.48px; height: 25px; text-align: center; color: white; font-size: 14px; font-family: Helvetica Neue; font-weight: 500; line-height: 20px; word-wrap: break-word">
                        Save change</div>
                </button>

                <div
                    style="width: 400px; height: 400px; padding-top: 12px; padding-bottom: 12px; left: 0px; top: 0px; position: absolute; flex-direction: column; justify-content: center; align-items: flex-start; gap: 32px; display: inline-flex">
                    <div
                        style="align-self: stretch; height: 80px; padding-left: 0.84px; padding-right: 0.66px; flex-direction: column; justify-content: center; align-items: flex-start; gap: 10px; display: inline-flex">
                        <div
                            style="color: #0D0C22; font-size: 16px; font-family: Helvetica Neue; font-weight: 500; line-height: 22px; word-wrap: break-word">
                            프로필 이미지 </div>
                        <div
                            style="align-self: stretch; height: 48px; padding: 15.50px 18px; background: white; border-radius: 8px; border: 2px #E7E7E9 solid; display: flex; align-items: center;">
                            <input type="text" v-model="email" :placeholder="placeholderText1"
                                style="flex: 1; color: #0D0C22; font-size: 14px; font-family: Helvetica Neue; font-weight: 400; word-wrap: break-word; border: none; outline: none;">
                        </div>
                    </div>
                    <div
                        style="align-self: stretch; height: 80px; padding-left: 0.84px; padding-right: 0.66px; flex-direction: column; justify-content: center; align-items: flex-start; gap: 10px; display: inline-flex">
                        <div
                            style="color: #0D0C22; font-size: 16px; font-family: Helvetica Neue; font-weight: 500; line-height: 22px; word-wrap: break-word">
                            성별</div>
                        <div
                            style="align-self: stretch; height: 48px; padding: 15.50px 18px; background: white; border-radius: 8px; border: 2px #E7E7E9 solid; display: flex; align-items: center;">
                            <input type="text" v-model="nickname" :placeholder="placeholderText2"
                                style="flex: 1; color: #0D0C22; font-size: 14px; font-family: Helvetica Neue; font-weight: 400; word-wrap: break-word; border: none; outline: none;">
                        </div>
                    </div>
                    <div
                        style="align-self: stretch; height: 80px; padding-left: 0.84px; padding-right: 0.66px; flex-direction: column; justify-content: center; align-items: flex-start; gap: 10px; display: inline-flex">
                        <div
                            style="color: #0D0C22; font-size: 16px; font-family: Helvetica Neue; font-weight: 500; line-height: 22px; word-wrap: break-word">
                            나이</div>
                        <div
                            style="align-self: stretch; height: 48px; padding: 15.50px 18px; background: white; border-radius: 8px; border: 2px #E7E7E9 solid; display: flex; align-items: center;">
                            <input type="text" v-model="oldPassword"
                                style="flex: 1; color: #0D0C22; font-size: 14px; font-family: Helvetica Neue; font-weight: 400; word-wrap: break-word; border: none; outline: none;">
                        </div>
                    </div>
                    <div
                        style="align-self: stretch; height: 80px; padding-left: 0.84px; padding-right: 0.66px; flex-direction: column; justify-content: center; align-items: flex-start; gap: 10px; display: inline-flex">
                        <div
                            style="color: #0D0C22; font-size: 16px; font-family: Helvetica Neue; font-weight: 500; line-height: 22px; word-wrap: break-word">
                            키</div>
                        <div
                            style="align-self: stretch; height: 48px; padding: 15.50px 18px; background: white; border-radius: 8px; border: 2px #E7E7E9 solid; display: flex; align-items: center;">
                            <input type="text" v-model="newPassword"
                                style="flex: 1; color: #0D0C22; font-size: 14px; font-family: Helvetica Neue; font-weight: 400; word-wrap: break-word; border: none; outline: none;">
                        </div>
                    </div>
                    <div
                        style="align-self: stretch; height: 80px; padding-left: 0.84px; padding-right: 0.66px; flex-direction: column; justify-content: center; align-items: flex-start; gap: 10px; display: inline-flex">
                        <div
                            style="color: #0D0C22; font-size: 16px; font-family: Helvetica Neue; font-weight: 500; line-height: 22px; word-wrap: break-word">
                            몸무게</div>
                        <div
                            style="align-self: stretch; height: 48px; padding: 15.50px 18px; background: white; border-radius: 8px; border: 2px #E7E7E9 solid; display: flex; align-items: center;">
                            <input type="text" v-model="newPassword"
                                style="flex: 1; color: #0D0C22; font-size: 14px; font-family: Helvetica Neue; font-weight: 400; word-wrap: break-word; border: none; outline: none;">
                        </div>
                    </div>
                    <div
                        style="align-self: stretch; height: 80px; padding-left: 0.84px; padding-right: 0.66px; flex-direction: column; justify-content: center; align-items: flex-start; gap: 10px; display: inline-flex">
                        <div
                            style="color: #0D0C22; font-size: 16px; font-family: Helvetica Neue; font-weight: 500; line-height: 22px; word-wrap: break-word">
                            선호 운동장소</div>
                        <div
                            style="align-self: stretch; height: 48px; padding: 15.50px 18px; background: white; border-radius: 8px; border: 2px #E7E7E9 solid; display: flex; align-items: center;">
                            <input type="text" v-model="newPassword"
                                style="flex: 1; color: #0D0C22; font-size: 14px; font-family: Helvetica Neue; font-weight: 400; word-wrap: break-word; border: none; outline: none;">
                        </div>
                    </div>
                    <div
                        style="align-self: stretch; height: 80px; padding-left: 0.84px; padding-right: 0.66px; flex-direction: column; justify-content: center; align-items: flex-start; gap: 10px; display: inline-flex">
                        <div
                            style="color: #0D0C22; font-size: 16px; font-family: Helvetica Neue; font-weight: 500; line-height: 22px; word-wrap: break-word">
                            한마디(user_extra)</div>
                        <div
                            style="align-self: stretch; height: 48px; padding: 15.50px 18px; background: white; border-radius: 8px; border: 2px #E7E7E9 solid; display: flex; align-items: center;">
                            <input type="text" v-model="newPassword"
                                style="flex: 1; color: #0D0C22; font-size: 14px; font-family: Helvetica Neue; font-weight: 400; word-wrap: break-word; border: none; outline: none;">
                        </div>
                    </div>
                    <div
                        style="align-self: stretch; height: 80px; padding-left: 0.84px; padding-right: 0.66px; flex-direction: column; justify-content: center; align-items: flex-start; gap: 10px; display: inline-flex">
                        <div
                            style="color: #0D0C22; font-size: 16px; font-family: Helvetica Neue; font-weight: 500; line-height: 22px; word-wrap: break-word">
                            담당 트레이너</div>
                        <div
                            style="align-self: stretch; height: 48px; padding: 15.50px 18px; background: white; border-radius: 8px; border: 2px #E7E7E9 solid; display: flex; align-items: center;">
                            <input type="text" v-model="newPassword"
                                style="flex: 1; color: #0D0C22; font-size: 14px; font-family: Helvetica Neue; font-weight: 400; word-wrap: break-word; border: none; outline: none;">
                        </div>
                    </div>
                </div>
            </form>

            <div style="width: 879px; height: 62.59px; left: 0px; top: 31px; position: absolute">

                <div
                    style="left: 340px; top: 34px; position: absolute; color: #6E6D7A; font-size: 14px; font-family: Helvetica Neue; font-weight: 400; line-height: 18.20px; word-wrap: break-word">
                    사용자 정보를 업데이트하세요</div>
                <div style="left: 350px; top: 0px; position: absolute"><span
                        style="color: #0D0C22; font-size: 20px; font-family: Helvetica Neue; font-weight: 500; line-height: 29px; word-wrap: break-word">{{ store.idValue}}의 사용자 정보 </span></div>

            </div>
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