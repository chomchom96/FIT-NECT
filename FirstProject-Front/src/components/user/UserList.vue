<template>
  <div class="container">
    <br>
    <h2>사용자 목록</h2>
    <h4>전체 사용자 : {{ userCnt }} 명</h4>
    <div v-if="userList.length">
      <table class="user-list">
        
        <thead>
          <tr>
            <th>번호</th>
            <th>아이디</th>
            <th>이메일</th>
            <th>사용자 이름</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(user, index) in userList" :key="index">
            <td>{{ index + 1 }}</td>
            <td>
              <RouterLink class="user-link" :to="`/users/${user.userId}`">{{user.userId }}</RouterLink>
            </td>
            <td>{{ user.userEmail}}</td>
            <td>{{ user.userNickname}}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <div v-else>등록된 사용자가 없습니다.</div>
  </div>
</template>

<script setup>
import { useUserStore } from '@/stores/user'
import { computed } from "vue";

const store = useUserStore()

const props = defineProps({
    userList: {
      type: Array,
      default: () => [],
    },
  });

  const userCnt = computed(() => props.userList.length);

</script>

<style scoped>

/* .container {
 text-align: center;
} */

</style>