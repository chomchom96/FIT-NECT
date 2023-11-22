<template>
  <div>
    <h2>고객 관리 페이지</h2>
    <table v-if="store.userManageList.length > 0">
      <thead>
        <tr>
          <th>User ID</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="userId in store.userManageList" :key="userId">
          <td>
            <router-link :to="{ name: 'ManageUserSchedule', params: { id: userId } }">{{ userId }}</router-link>
          </td>
        </tr>
      </tbody>
    </table>
    <div v-else>
      <h1 style="text-align: center; color: #555; margin-top: 20px; font-size: 1.5em;">
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
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

th {
  background-color: #f2f2f2;
}
</style>
