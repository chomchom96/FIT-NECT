<template>
  <div class="container">
    <h1 class="text-center mt-5 mb-4">OUR TRAINERS</h1>

    <div class="row">
      <div class="col-md-4">
        <div class="card" data-bs-toggle="modal" data-bs-target="#trainer1Modal">
          <img src="/src/assets/trainer1.png" class="card-img-top" alt="Trainer 1">
          <div class="card-body">
            <h5 class="card-title">성아름</h5>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card" data-bs-toggle="modal" data-bs-target="#trainer2Modal">
          <img src="/src/assets/trainer2.png" class="card-img-top" alt="Trainer 2">
          <div class="card-body">
            <h5 class="card-title">이민아</h5>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card" data-bs-toggle="modal" data-bs-target="#trainer3Modal">
          <img src="/src/assets/trainer3.png" class="card-img-top" alt="Trainer 3">
          <div class="card-body">
            <h5 class="card-title">김민성</h5>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card" data-bs-toggle="modal" data-bs-target="#trainer4Modal">
          <img src="/src/assets/trainer4.png" class="card-img-top" alt="Trainer 4">
          <div class="card-body">
            <h5 class="card-title">박임박</h5>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card" data-bs-toggle="modal" data-bs-target="#trainer5Modal">
          <img src="/src/assets/trainer5.png" class="card-img-top" alt="Trainer 5">
          <div class="card-body">
            <h5 class="card-title">조박살</h5>
          </div>
        </div>
      </div>

    </div>

    <div class="modal fade" id="trainer1Modal" tabindex="-1" aria-labelledby="trainer1ModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center">
          <div class="modal-header">
            <h5 class="modal-title" id="trainer1ModalLabel">성아름</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <img src="/src/assets/trainer1.png" class="img-fluid mb-3" alt="Trainer 1">
            <p><strong> 28세 </strong> </p>
            <p><strong>ㅇㅇ대학교 체육학과 졸업</strong></p>
            <p><strong>건강관리운동 전문</strong></p>
            <p>자기소개글 ~~~ </p>
          </div>
        </div>
      </div>
    </div>

    <div class="modal fade" id="trainer2Modal" tabindex="-1" aria-labelledby="trainer2ModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center">
          <div class="modal-header">
            <h5 class="modal-title" id="trainer2ModalLabel">이민아</h5>
          </div>
          <div class="modal-body">
            <img src="/src/assets/trainer2.png" class="img-fluid mb-3" alt="Trainer 2">
            <p><strong> 25세 </strong> </p>
            <p><strong>역삼 싸피피트니스 수석 트레이너</strong></p>
            <p><strong>원하는 몸, 만들어드립니다</strong></p>
            <p>자기소개글 ~~~ </p>
          </div>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          <br>
        </div>
      </div>
    </div>

    <div class="modal fade" id="trainer3Modal" tabindex="-1" aria-labelledby="trainer2ModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center">
          <div class="modal-header">
            <h5 class="modal-title" id="trainer3ModalLabel">김민성</h5>
          </div>
          <div class="modal-body">
            <img src="/src/assets/trainer3.png" class="img-fluid mb-3" alt="Trainer 2">
            <p><strong> 26세 </strong> </p>
            <p><strong>생활체육관리사</strong></p>
            <p><strong>실생활운동을 가르쳐드립니다</strong></p>
            <p>자기소개글 ~~~ </p>
          </div>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          <br>
        </div>
      </div>
    </div>

    <div class="modal fade" id="trainer4Modal" tabindex="-1" aria-labelledby="trainer2ModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" >
        <div class="modal-content text-center" >
          <div class="modal-header">
            <h5 class="modal-title" id="trainer4ModalLabel">박임박</h5>
          </div>
          <div class="modal-body" >
            <img src="/src/assets/trainer4.png" class="img-fluid mb-3" alt="Trainer 2">
            <p><strong> 32세 </strong> </p>
            <p><strong>강남 자바짐 5년 경력</strong></p>
            <p><strong>바디 프로필 전문</strong></p>
            <p>자기소개글 ~~~ </p>
          </div>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          <br>
        </div>
      </div>
    </div>

    <div class="modal fade" id="trainer5Modal" tabindex="-1" aria-labelledby="trainer2ModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center">
          <div class="modal-header">
            <h5 class="modal-title" id="trainer5ModalLabel">조박살</h5>
          </div>
          <div class="modal-body">
            <img src="/src/assets/trainer5.png" class="img-fluid mb-3" alt="Trainer 2">
            <p><strong> 40세 </strong> </p>
            <p><strong>요가/필라테스 강사 2년</strong></p>
            <p><strong>요가/필라테스 전문</strong></p>
            <p>자기소개글 ~~~ </p>
          </div>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          <br>
        </div>
      </div>
    </div>

  </div>

</template>

<script setup>
</script>

<style scoped>
img {
height: auto;
align-self: center;
max-width: 80%;
padding: 20px;
}

.card {
margin : 20px;
border: 1px solid #ddd;
border-radius: 8px;
transition: box-shadow 0.3s;
align-items: center;
}

.card-body {
margin: 15px;
padding: 5px;
font-weight: bold;
}

.card:hover {
box-shadow: 0 0 15px rgba(33, 33, 33, 0.2);
}


.modal-content {
  align-items: center;
  border-radius: 10px;
  box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
}

.modal-title {
  color: cornflowerblue; 
}

.modal-body {
  padding: 20px;
}

.modal-body img {
  border-radius: 5px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

.modal-body p {
  font-size: 16px;
  line-height: 1.6;
  color: #333;
}

.modal-body strong {
  color: black;
}

.btn-close {
  color: #333; 
}

.modal-content, .btn-close {
  transition: all 0.3s ease-in-out;
}

.btn-close:hover {
  color: #e74c3c; 
  transform: scale(1.2);
}
</style>
