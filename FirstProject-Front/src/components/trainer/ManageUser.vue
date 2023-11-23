<template>
  <div>
    <h2 style="text-align: center; margin-top:70px; margin-bottom:50px;">고객 관리 페이지</h2>
    <table class="manage" v-if="store.userManageList.length > 0">
      <thead >
        <tr>
          <th style=" text-align: center;">User ID</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="userId in store.userManageList" :key="userId">
          <td style=" text-align: center;">
            <router-link class="rlink" :to="{ name: 'ManageUserSchedule', params: { id: userId } }">{{ userId }}</router-link>
          </td>
        </tr>
      </tbody>
    </table>
    <div v-else >
      <h1 style="text-align: center; color: #555; margin-top: 50px; font-size: 1.5em;">
        매칭을 신청한 사용자가 없습니다 😔
      </h1>
    </div>
    <router-view></router-view>
  </div>
</template>
<script setup>
import { useTrainerStore } from "../../stores/trainer";
import { onMounted } from "vue";

const store = useTrainerStore();

onMounted(() => {
  store.getUserManageList();
});

</script>

<style scoped>
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
  
}

th,
td {
  border: 1px solid white;
  text-align: left;
  padding: 8px;
}

th {
  background-color: #f2f2f2;
}

.manage {
  width: 20%; /* 표의 전체 가로길이를 조절합니다. */
  margin: 0 auto; /* 가운데 정렬을 위해 margin을 설정합니다. */
  /* border-collapse: collapse; 테이블 셀 경계를 병합합니다. */
  /* border: 1px black solid; */
  /* background-color: white; */
}

.rlink {
  text-decoration: none; /* 링크의 밑줄을 제거합니다. */
  color: #333; /* 링크 색상을 설정합니다. */
  font-weight: bold; /* 링크 텍스트의 굵기를 설정합니다. */
}

.rlink:hover {
  text-decoration: cornflowerblue wavy underline;
}

</style>
