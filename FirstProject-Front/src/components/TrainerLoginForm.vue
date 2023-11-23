<template>
    <div class="container">
        <br>
        <h2>Log in</h2>
        <br>
        <div class="withssafyfont">Use your email or other service to continue with SSAFIT</div>
        <br>
        <fieldset class="text-center">
            <span>
                <label for="id" class="textfont">Your email</label>
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
            <div>
                <br>
                <button class="btn" @click="login">
                    <div class="buttonfont">Log in</div>
                </button>
            </div>
        </fieldset>
    </div>
    <br>
</template>
  
<script setup>
import { ref } from "vue";
import { useTrainerStore } from "../stores/trainer";

const store = useTrainerStore();

const id = ref("");
const password = ref("");

const login = async () => {
    let trainer = {
        id: id.value,
        password: password.value,
    };
    store.loginTrainer(trainer);
};

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
  background-color: rgb(129, 129, 129)
  /* 호버 시 어둡게 변하는 배경 */
}

.socialLogin:hover .font {
  color: white;
  /* 호버 시 글자색을 하얗게 설정 */
}

.font {
  padding-left: 10px;
  color: #333;
  font-size: 22px;
  font-style: normal;
  font-weight: 400;
  line-height: normal;
}

.or {
  color: #666;
  font-size: 24px;
  font-style: normal;
  font-weight: 400;
  line-height: normal;
  text-align: center;
}

.loginStyle {
  color: #666;
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
  width: 528px;
  height: 64px;
  padding: 15px 0px 16px 0px;
  justify-content: center;
  border-radius: 40px;
  opacity: 0.25;
  background: #111;
}

.btn:hover {
  background-color: #555;
}
.buttonfont {
  color: #FFF;
  text-align: center;
  font-size: 22px;
  font-style: normal;
  font-weight: 500;
  line-height: normal;
}

.textfont {
  text-align: center;
  color: #666;
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: normal;
  padding: 10px;
}

.withssafyfont {
  text-align: center;
  color: #666;
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: normal;
}
</style>
