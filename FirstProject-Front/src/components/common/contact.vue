<template>
  <br />
  <h2>🛠 CONTACT 🛠 </h2>

  <div class=contact>
    <br>
    <div class="mb-3">
      <label for="exampleFormControlInput1" class="form-label">메일 주소</label>
      <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="name@example.com"
        v-model="email">
    </div>
    <div class="mb-3">
      <label for="exampleFormControlTextarea1" class="form-label">문의 내용</label>
      <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" v-model="message"></textarea>
    </div>
    <button class="btn" @click="sendEmail">전송</button>
  </div>
</template>

<script setup>
import axios from 'axios';
import { ref } from 'vue';

const email = ref('')
const message = ref('')


const sendEmail = async () => {
  const email = email.value
  const message = message.value

  try {
    await axios.post('http://localhost:3000/send-email', {
      email,
      message,
    });
    alert('발송 성공!');
  } catch (error) {
    console.error(error);
    alert('발송 실패');
  }
};

</script>

<style scoped>
h4 {
  margin-left: 50px;
  text-align: center;
}

.intro {
  text-align: center;
}

.row {
  background-color: #f8f9fa;
  border-radius: 10px;
  padding: 20px;
}

.p-3 {
  color: #666;
  background-color: #ffffff;
  border-radius: 20px;
  padding: 20px;
  margin-bottom: 20px;
  border: 0.5px solid rgba(102, 102, 102, 0.35);


}

.contact {
  text-align: center;
  margin: 50px auto;
  max-width: 700px;
}


.contact {
  text-align: center;
}

.btn {
  padding: 10px;
  background-color: #333;
  /* 무채색 배경 */
  color: #fff;
  /* 흰색 텍스트 */
  border: none;
  cursor: pointer;
  margin-right: 10px;

}

.btn:hover {
  background-color: #555;
  /* 호버 시 어둡게 변하는 배경 */
}

h2,
h4 {
  text-align: center;
  color: #333;
  font-family: Poppins;
  font-size: 32px;
  font-style: normal;
  font-weight: 500;
  line-height: normal;
}

.emailfont {
  color: #666;
  font-family: Poppins;
  font-size: 24px;
  font-style: normal;
  font-weight: 400;
  line-height: normal;
}

.gitfont {
  font-size: 17px;
}

.phonefont {
  font-size: 15px;

}
</style>