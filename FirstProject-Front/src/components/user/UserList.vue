<template>
  <div class="container" style="margin-top:50px;">
    <br>
    <h2 style="text-align: center;">회원 목록</h2>
    <br>
    <h5 style="text-align: center;">전체 회원 수 : {{ userCnt }}</h5>
    <br>
    <div v-if="userList.length">
      <table class="user-list">
        
        <thead>
          <tr>
            <th>번호</th>
            <th>아이디</th>
            <th>이메일</th>
            <th>닉네임</th>
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
.user-list {
  width: 60%; /* 표의 전체 가로길이를 조절합니다. */
  margin: 0 auto; /* 가운데 정렬을 위해 margin을 설정합니다. */
  border-collapse: collapse; /* 테이블 셀 경계를 병합합니다. */
}

.user-list th, .user-list td {
  border: 1px solid white; /* 테이블 셀의 테두리 스타일을 설정합니다. */
  padding: 8px; /* 셀 내부의 여백을 설정합니다. */
  text-align: left; /* 텍스트를 왼쪽 정렬합니다. */
}

.user-link {
  text-decoration: none; /* 링크의 밑줄을 제거합니다. */
  color: #333; /* 링크 색상을 설정합니다. */
  font-weight: bold; /* 링크 텍스트의 굵기를 설정합니다. */
}

.user-link:hover {
  text-decoration: underline;
}
</style>