<template>
    <div class="container">
        <br>
        <h2>Log in</h2>
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
    <div
        style="width: 100%; height: 100%; justify-content: flex-start; align-items: center; gap: 23px; display: inline-flex">
        <div style="flex: 1 1 0; height: 2px; background: rgba(102, 102, 102, 0.25)"></div>
        <div style="color: #666666; font-size: 24px; font-family: Avenir; font-weight: 400; word-wrap: break-word">OR</div>
        <div style="flex: 1 1 0; height: 2px; background: rgba(102, 102, 102, 0.25)"></div>
    </div>
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
    await store.loginTrainer(trainer);
};

const user = ref({
    id: id,
    password: password,
})

const loginUser = () => {
    console.log(user.value)
    emit("login-user", user.value)
}



</script>
  
<style scoped>
h2 {
    text-align: center;
    color: #333;
    font-family: Poppins;
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

    border-radius: 40px;
    border: 1px solid #333;
    background: #FFF;

    margin: auto;
    /* 추가: 중앙 정렬 */


}

.socialLogin:hover {
    background-color: black;
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

.text-center .textfont {
    color: #666;
    font-family: Poppins;
    font-size: 17px;
    font-style: normal;
    font-weight: 400;
    line-height: normal;


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
  