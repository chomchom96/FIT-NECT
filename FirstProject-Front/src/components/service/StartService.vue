<template>
    
    <div class="container" style="font-size: 40px; text-align: center; margin-top: 110px">FIT-NECT와 함께 새로운 삶을 시작하세요</div>
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
        <!-- <RouterLink :to="{ name: 'ChooseTrainer' }"> START WITH FIT-NECT </RouterLink> -->
    </section> 
   
</template>

<script>

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

</style>