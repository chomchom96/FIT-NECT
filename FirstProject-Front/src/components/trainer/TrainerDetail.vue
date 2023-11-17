<template>
    <div class="container">
        <br>
        <h2>트레이너 정보</h2>
        <br>

        <fieldset class="text-center">
            <label for="trainerId">아이디</label>
            <input readonly type="text" id="id" v-model="trainer.trainerId" class="view" /><br />
            <label for="password">비밀번호</label>
            <input type="password" id="password" v-model="trainer.trainerPassword" class="view" /><br />
            <label for="name">이름</label>
            <input type="text" id="name" v-model="trainer.trainerNickname" class="view" /><br />
            <label for="email">이메일</label>
            <input type="email" id="email" v-model="trainer.trainerEmail" class="view" /><br />
            <button class="btn" @click="deletetrainer">삭제</button>
        </fieldset>
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useTrainerStore } from "@/stores/trainer"

const trainer = ref({});

const store = useTrainerStore()

onMounted(async () => {
  const pathName = new URL(document.location).pathname.split("/");
  const id = pathName[pathName.length - 1];

  try {
    trainer.value = await store.getTrainerDetail(id);
    console.log(trainer.value);
  } catch (error) {
    console.error("Error fetching trainer details:", error);
  }
});

const deletetrainer = () => {
    alert("삭제하시겠습니까?")
    if (comfirm)
        store.deleteTrainer()
};

</script>
