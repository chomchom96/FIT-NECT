<template>
  <div class="container text" style="font-size: 40px; text-align: center; margin-top: 110px"><span>FIT-NECT와 함께 새로운 삶을 시작하세요</span></div>
    <br>
    <section>
      <h1>FIT-NECT</h1>
      <p>언제 어디서든 편리한 비대면 개인 트레이닝 서비스</p>
    </section>

    <section>
      <h2>우리의 서비스</h2>
      <p>
        FITNECT는 트레이너와의 실시간 온라인 세션을 통해 전문적인 퍼스널
        트레이닝을 받을 수 있는 서비스입니다. 건강하고 활기찬 삶을 위한 시작!
      </p>
    </section> 
    <section>
        <router-link to="/service/trainers">
                <button class="btn">START WITH FIT-NECT</button>
        </router-link>
    </section> 


  <router-view></router-view>
</template>

<script setup>

</script>

<style scoped>

.container {
    justify-content: center;
}

.btn {
  padding: 10px;
  background-color: #333;
  /* 무채색 배경 */
  color: #fff;
  /* 흰색 텍스트 */
  font-size: 25px;
  font-weight : bold;
  border: none;
  cursor: pointer;
  margin-right: 10px;
  width: 500px;
  height: 65px;
}

.btn:hover {
  background-color: white;
  color: black;
}


.text span:nth-child(1) {animation: txt_blur 0.8s forwards alternate ease-in;}


@keyframes txt_blur {
  0%, 50% {
  filter:blur(7px);
  -moz-filter:blur(7px);
  -webkit-filter:blur(7px);
  opacity: 0;
  }
  100% {
  filter:blur(0);
  -moz-filter:blur(0);
  -webkit-filter:blur(0);
  opacity: 1;
  }
}
</style>
