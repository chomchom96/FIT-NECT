<template>
  <div>
    <h2>원하는 트레이너를 선택하세요</h2>

    <div class="row row-cols-1 row-cols-md-3 g-4">
      <div v-for="(trainer, index) in store.trainerDetailList" :key="trainer.trainerSeq" class="col">
        <div class="card" style="cursor: pointer" @click="chooseTrainer(trainer.trainerId)">
          <img :src="trainer.trainerProfilePic" class="card-img-top" alt="Trainer Profile" />
          <div class="card-body">
            <h5 class="card-title">{{ trainer.trainerName }} </h5>
            <p class="card-text">{{ trainer.trainerExperience }}</p>
            <p class="card-text">{{ trainer.trainerExtra }}</p>
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
  max-width: 50%;
}
</style>
