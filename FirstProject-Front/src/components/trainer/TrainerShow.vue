<template>
    <div class="container">
      <h1 class="text-center mt-5 mb-4">TRAINERS</h1>
  
      <div class="row">
        <!-- Trainer 1 -->
        <div class="col-md-4">
          <div class="card" data-bs-toggle="modal" data-bs-target="#trainer1Modal">
            <img src="trainer1.jpg" class="card-img-top" alt="Trainer 1">
            <div class="card-body">
              <h5 class="card-title">트레이너 1: 김지원</h5>
            </div>
          </div>
        </div>
  
        <!-- Trainer 2 -->
        <div class="col-md-4">
          <div class="card" data-bs-toggle="modal" data-bs-target="#trainer2Modal">
            <img src="trainer2.jpg" class="card-img-top" alt="Trainer 2">
            <div class="card-body">
              <h5 class="card-title">트레이너 2: 이민호</h5>
            </div>
          </div>
        </div>
  
        <!-- Repeat the structure for other trainers -->
        <!-- Trainer 3 -->
        <!-- <div class="col-md-4">
          <div class="card" data-bs-toggle="modal" data-bs-target="#trainer3Modal">
            <img src="trainer3.jpg" class="card-img-top" alt="Trainer 3">
            <div class="card-body">
              <h5 class="card-title">트레이너 3: 송지은</h5>
            </div>
          </div>
        </div> -->
  
      </div>
  
      <!-- Modals -->
      <!-- Trainer 1 Modal -->
      <div class="modal fade" id="trainer1Modal" tabindex="-1" aria-labelledby="trainer1ModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="trainer1ModalLabel">트레이너 1: 김지원</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <img src="trainer1.jpg" class="img-fluid mb-3" alt="Trainer 1">
              <p><strong>성별:</strong> 여성</p>
              <p><strong>연령:</strong> 28세</p>
              <p><strong>학력:</strong> 체육학과 졸업</p>
              <p><strong>자기소개:</strong> 안녕하세요! 저는 김지원이라고 합니다...</p>
            </div>
          </div>
        </div>
      </div>
  
      <!-- Trainer 2 Modal -->
      <div class="modal fade" id="trainer2Modal" tabindex="-1" aria-labelledby="trainer2ModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="trainer2ModalLabel">트레이너 2: 이민호</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <img src="trainer2.jpg" class="img-fluid mb-3" alt="Trainer 2">
              <p><strong>성별:</strong> 남성</p>
              <p><strong>연령:</strong> 32세</p>
              <p><strong>학력:</strong> 운동생리학 석사</p>
              <p><strong>자기소개:</strong> 안녕하세요, 이민호입니다. 운동과 건강에 대한 학문적인 지식을 바탕으로...</p>
            </div>
          </div>
        </div>
      </div>
  
      <!-- Repeat the structure for other trainers -->
      <!-- Trainer 3 Modal -->
      <!-- <div class="modal fade" id="trainer3Modal" tabindex="-1" aria-labelledby="trainer3ModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="trainer3ModalLabel">트레이너 3: 송지은</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <img src="trainer3.jpg" class="img-fluid mb-3" alt="Trainer 3">
              <p><strong>성별:</strong> 여성</p>
              <p><strong>연령:</strong> 24세</p>
              <p><strong>학력:</strong> 영양학 전공</p>
              <p><strong>자기소개:</strong> 안녕하세요, 송지은입니다. 영양학 전공을 통해...</p>
            </div>
          </div>
        </div>
      </div> -->
  
    </div>

</template>

<script setup>
</script>

<style sccoped>
.card {
    margin: 20px;
}
</style>
