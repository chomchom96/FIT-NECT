<template>
  <div>
    <h2>원하는 트레이너를 선택하세요</h2>

    <div class="row row-cols-1 row-cols-md-3 g-4">
      <div
        v-for="(trainer, index) in store.trainerDetailList"
        :key="trainer.trainerSeq"
        class="col"
      >
        <div class="card" style="cursor: pointer" @click="chooseTrainer(trainer.trainerId)">
          <img
            :src="trainer.trainerProfilePic"
            class="card-img-top"
            alt="Trainer Profile"
          />
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

const store = useServiceStore();
const userStore = useUserStore();
const userId = ref('')

const chooseTrainer = (trainerId) => {
    store.selectTrainer(userStore.idValue, trainerId)
}

onMounted(() => {
  store.getDetails();
});
</script>

<style scoped>
.trainer-image {
  max-width: 100%;
  max-height: 400px;
  display: block;
  margin: auto;
}
</style>
