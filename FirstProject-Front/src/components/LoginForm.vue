<template>
  <div class="container">
    <br>
    <h2>Log in</h2>
    <br>
    <div class="withssafyfont">Use your Id or other service to continue with SSAFIT</div>
    <br>
    <fieldset class="text-center">
      <span>
        <label for="id" class="textfont">Your Id</label>
      </span>
      <div>
        <input v-model="id" type="text" id="id" required />
      </div>
      <br>
      <span>
        <label for="password" class="textfont">Your password</label>
      </span>
      <div>
        <input v-model="password" type="password" id="password" required />
      </div>
      <br>
      <br>
      <div>
        <br>
        <button class="btn" @click="login">
          <div class="buttonfont">Log in</div>
        </button>
      </div>
    </fieldset>
  </div>

  <br>

  <div
    style="width: 100%; height: 100%; justify-content: flex-start; align-items: center; gap: 23px; display: inline-flex">
    <div style="flex: 1 1 0; height: 2px; background: rgba(102, 102, 102, 0.25)"></div>
    <div style="color: #666666; font-size: 24px; font-weight: 400; word-wrap: break-word">OR</div>
    <div style="flex: 1 1 0; height: 2px; background: rgba(102, 102, 102, 0.25)"></div>
  </div>
  <br>
  <br>

  <div class="socialLogin" @click="kakaoLogin()">
    <img src="@/assets/kakao.png" width="33" height="33" viewBox="0 0 33 33" fill="none" />
    <div class="font">카카오 로그인</div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useUserStore } from "../stores/user";

const store = useUserStore();

const id = ref("");
const password = ref("");

const login = async () => {
  let user = {
    id: id.value,
    password: password.value,
  };
  store.loginUser(user);
};


const kakaoLogin = () => {
  window.Kakao.Auth.login({
    scope: "account_email",
    success: getKakaoAccount(),
  })
}

const getKakaoAccount = () => {
  window.Kakao.API.request({
    url: "/v2/user/me",
    success: (res) => {
      const kakao_account = res.kakao_account;
      const email = kakao_account.email;
      console.log("email", email);
      alert("로그인 성공!");
    },
    fail: (error) => {
      console.log(error);
    },
  });
}

const kakaoLogout = () => {
  window.Kakao.Auth.logout((res) => {
    console.log(res)
  })
}

</script>

<style scoped>
* {
  font-family: 'Nanum Gothic', sans-serif;
}

h2 {
  text-align: center;
  color: #333;
  font-size: 32px;
  font-style: normal;
  font-weight: 500;
  line-height: normal;
}

.socialLogin {
  display: flex;
  width: 528px;
  height: 72px;
  padding: 20.5px 148.5px 21.5px 149.5px;
  justify-content: center;
  align-items: center;

  border-radius: 10px;
  border: 1px solid rgb(104, 103, 103);
  background: #ffffff;

  margin: auto;
  /* 추가: 중앙 정렬 */


}

.socialLogin:hover {
  background-color: rgb(194, 194, 194);
  /* 호버 시 어둡게 변하는 배경 */
}

.socialLogin:hover .font {
  color: white;
  /* 호버 시 글자색을 하얗게 설정 */
}

.font {
  padding-left: 10px;
  color: #333;
  font-family: Avenir;
  font-size: 22px;
  font-style: normal;
  font-weight: 400;
  line-height: normal;
}

.or {
  color: #666;
  font-family: Avenir;
  font-size: 24px;
  font-style: normal;
  font-weight: 400;
  line-height: normal;
  text-align: center;
}

.loginStyle {
  color: #666;
  font-family: Poppins;
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: normal;
}


input[type=text] {
  height: 56px;
  width: 528px;
  align-self: stretch;
  border-radius: 12px;
  border: 1px solid rgba(102, 102, 102, 0.35);
  text-indent: 15px;
}


input[type=password] {
  height: 56px;
  width: 528px;
  align-self: stretch;
  border-radius: 12px;
  border: 1px solid rgba(102, 102, 102, 0.35);
  text-indent: 15px;
}

.btn {
  /* display: flex; */
  width: 528px;
  height: 64px;
  padding: 15px 0px 16px 0px;
  justify-content: center;
  /* align-items: center; */

  border-radius: 40px;
  opacity: 0.25;
  background: #111;

  /* text-align: center; */

}

.btn:hover {
  background-color: #555;
  /* background-color: white; */
}

/* .btn:hover .buttonfont {
    color:black;
  } */

.buttonfont {
  color: #FFF;
  text-align: center;
  font-family: Poppins;
  font-size: 22px;
  font-style: normal;
  font-weight: 500;
  line-height: normal;
}

.textfont {
  text-align: center;
  color: #666;
  font-family: Poppins;
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: normal;
  padding: 10px;
}

.withssafyfont {
  text-align: center;
  color: #666;
  font-family: Poppins;
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: normal;
}
</style>
