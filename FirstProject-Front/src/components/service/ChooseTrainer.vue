<template>
  <div>
    <h2>원하는 트레이너를 선택하세요</h2>

    <div class="row row-cols-1 row-cols-md-3 g-4">
      <div v-for="(trainer, index) in store.trainerDetailList" :key="trainer.trainerSeq" class="col">
        <div class="card" style="cursor: pointer" @click="chooseTrainer(trainer.trainerId)">
          <img :src="trainer.trainerProfilePic" class="card-img-top" alt="Trainer Profile" />
          <div class="card-body">
            <h4 class="card-title" style="font-weight: bolder; text-align: center;">{{ trainer.trainerName }} </h4>
            <p class="card-text">경력 : {{ trainer.trainerExperience }}</p>
            <br>
            <p class="card-text" style="text-align: center;">{{ trainer.trainerExtra }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useServiceStore } from "../../stores/service";
import { useUserStore } from "../../stores/user"
import axios from "axios";
import { useRouter } from "vue-router";

const store = useServiceStore();
const userStore = useUserStore();
const userId = ref('')
const router = useRouter();

const chooseTrainer = (trainerId) => {
  const result = confirm("이 트레이너를 선택하시겠습니까?")
  if (result)
    store.selectTrainer(userStore.idValue, trainerId)
  else
    return;
}

onMounted(() => {
  store.getDetails();
  axios({
    url: "http://localhost:8080/api/users/" + userStore.idValue,
    method: "GET",
  })
    .then(() => {
    })
    .catch((err) => {
      if (err.response.status === 400) {
        alert("서비스 시작을 위한 정보를 먼저 입력해 주세요!")
        router.push("/mydetail");
      }
    });

});
</script>

<style scoped>
img {
  height: auto;
}

.card {
  border: 1px solid #ddd;
  border-radius: 8px;
  transition: box-shadow 0.3s;
}

.card-body {
  margin: 15px;
  padding: 5px;
  font-weight: bold;
}

.card:hover {
  box-shadow: 0 0 15px rgba(33, 33, 33, 0.2);
}
</style>