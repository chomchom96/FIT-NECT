<template>
    <div style="width: 100%; height: 40vh; display: flex; justify-content: center; align-items: center;">
        <div style="width: 878px; height: 555px; position: relative">
            <form style="width: 400px; height: 384px; left: 223.50px; top: 119px; position: absolute">
                <button @click="update"
                    style="width: 127.28px; height: 40px; left: 400px; top: 450px; position: absolute; background: #787cbb; border-radius: 8px; justify-content: center; align-items: center; display: inline-flex">
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
                            Email</div>
                        <div
                            style="align-self: stretch; height: 48px; padding: 15.50px 18px; background: white; border-radius: 8px; border: 2px #E7E7E9 solid; display: flex; align-items: center;">
                            <input type="text" v-model="email"
                                style="flex: 1; color: #0D0C22; font-size: 14px; font-family: Helvetica Neue; font-weight: 400; word-wrap: break-word; border: none; outline: none;">
                        </div>
                    </div>
                    <div
                        style="align-self: stretch; height: 80px; padding-left: 0.84px; padding-right: 0.66px; flex-direction: column; justify-content: center; align-items: flex-start; gap: 10px; display: inline-flex">
                        <div
                            style="color: #0D0C22; font-size: 16px; font-family: Helvetica Neue; font-weight: 500; line-height: 22px; word-wrap: break-word">
                            User name</div>
                        <div
                            style="align-self: stretch; height: 48px; padding: 15.50px 18px; background: white; border-radius: 8px; border: 2px #E7E7E9 solid; display: flex; align-items: center;">
                            <input type="text" v-model="nickname"
                                style="flex: 1; color: #0D0C22; font-size: 14px; font-family: Helvetica Neue; font-weight: 400; word-wrap: break-word; border: none; outline: none;">
                        </div>
                    </div>
                    <div
                        style="align-self: stretch; height: 80px; padding-left: 0.84px; padding-right: 0.66px; flex-direction: column; justify-content: center; align-items: flex-start; gap: 10px; display: inline-flex">
                        <div
                            style="color: #0D0C22; font-size: 16px; font-family: Helvetica Neue; font-weight: 500; line-height: 22px; word-wrap: break-word">
                            Previous Password</div>
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
                            New Password</div>
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
                    계정정보를 업데이트하세요</div>
                <div style="left: 350px; top: 0px; position: absolute"><span
                        style="color: #0D0C22; font-size: 20px; font-family: Helvetica Neue; font-weight: 500; line-height: 29px; word-wrap: break-word">{{ store.idValue}}의 계정정보 </span></div>

            </div>
        </div>
    </div>
</template>

<script setup>
import { useUserStore } from "@/stores/user.js";
import { ref } from 'vue';

const store = useUserStore();
const user = ref({});

user.value = store.user.value;
console.log(user);

const email = ref("");
const nickname = ref("");
const oldPassword = ref("");
const newPassword = ref("");

const update = async () => {
const password = oldPassword.value;
const userConfirm = {
    userId: store.idValue,
    userPassword: oldPassword.value
};

const userToUpdate = {
    userId: store.idValue,
    userPassword: newPassword.value,
    userNickname: nickname.value,
    userEmail: email.value
};

try {
const existingUser = await store.getUser(userConfirm);

if (existingUser !== null) {
    await store.updateUser(userToUpdate, password);
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