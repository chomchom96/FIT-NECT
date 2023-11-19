<template>
    <div class="container">
        <br>
        <h2>트레이너 목록</h2>
        <h4>전체 트레이너 : {{ trainerCnt }} 명</h4>
        <div v-if="store.trainerList.length">
            <table class="trainer-list">
                <thead>
                    <tr>
                        <th>NO</th>
                        <th>아이디</th>
                        <th>이메일</th>
                        <th>사용자 이름</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(trainer, index) in store.trainerList" :key="index">
                        <td>{{ index + 1 }}</td>
                        <td>
                            <RouterLink :to="`/trainers/${trainer.trainerId}`">{{ trainer.trainerId }}</RouterLink>
                        </td>
                        <td>{{ trainer.trainerEmail }}</td>
                        <td>{{ trainer.trainerNickname }}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div v-else>등록된 트레이너가 없습니다.</div>
    </div>
</template>
  
<script setup>
import { useTrainerStore } from '@/stores/trainer'
import { ref, computed } from "vue";

const store = useTrainerStore()
const trainerList = ref([]);


const trainerCnt = computed(() => store.trainerList.length);

</script>
  
<style scoped></style>