<template>
    <div class="container" style="margin-top:50px;">
    <br>
    <h2 style="text-align: center;">트레이너 목록</h2>
    <br>
    <h5 style="text-align: center;">전체 트레이너 수 : {{ trainerCnt }}</h5>
    <br>
    <div v-if="store.trainerList.length">
      <table class="trainer-list">
        
        <thead>
          <tr style="background-color: white;">
            <th>번호</th>
            <th>아이디</th>
            <th>이메일</th>
            <th>닉네임</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(trainer, index) in store.trainerList" :key="index">
            <td>{{ index + 1 }}</td>
            <td>
                <RouterLink class="trainer-link" :to="`/trainers/${trainer.trainerId}`">{{ trainer.trainerId }}</RouterLink>
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

const props = defineProps({
    trainerList: {
        type: Array,
        default: () => [],
    },
}); 


const trainerCnt = computed(() => store.trainerList.length);

</script>
  
<style scoped>
.trainer-list {
  width: 60%; /* 표의 전체 가로길이를 조절합니다. */
  margin: 0 auto; /* 가운데 정렬을 위해 margin을 설정합니다. */
  border-collapse: collapse; /* 테이블 셀 경계를 병합합니다. */
  /* border: 1px black solid; */
  /* background-color: white; */
}

.trainer-list th, .trainer-list td {
  border: 1px solid white; /* 테이블 셀의 테두리 스타일을 설정합니다. */
  padding: 8px; /* 셀 내부의 여백을 설정합니다. */
  text-align: left; /* 텍스트를 왼쪽 정렬합니다. */
}

.trainer-link {
  text-decoration: none; /* 링크의 밑줄을 제거합니다. */
  color: #333; /* 링크 색상을 설정합니다. */
  font-weight: bold; /* 링크 텍스트의 굵기를 설정합니다. */
}

.trainer-link:hover {
  text-decoration: underline;
}

</style>