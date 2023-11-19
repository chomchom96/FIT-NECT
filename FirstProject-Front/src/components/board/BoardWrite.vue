<template>

<div class="container">
  <br>
  <h2>글 작성</h2>
    <div>
      <div v-if="store.getUser">
        <!-- <label for="userId">아이디:</label>
        <input readonly v-model="store.idValue" type="text" id="userId"> -->
          <!-- <input readonly v-model="userId.value" type="text" id="userId" class="view"> -->
      
        <!-- <label>제목:</label>
        <input v-model="boardTitle" type="text" id="boardTitle" required>

        <label for="boardText">내용:</label>
        <input v-model="boardText" type="text" id="boardText" required> -->

       <!-- <button type="submit2" @click="registBoard">등록</button> -->
       

        <div class ="container">
        <table class="board-list">
        <colgroup>
          <col style="width: 100%" />
        </colgroup>
        
        <thead>
          <tr> 
            <th style="text-align: left; padding-left: 15px; font-size: 16px;">
              <input type="text" v-model="boardTitle"  id="boardTitle" placeholder="제목을 입력하세요" required>
            </th> 
          </tr>
        </thead>
        <tbody>
        <tr>
            <!-- <td>{{ index + 1 }}</td> -->
            <td style="display: flex; justify-content: space-between; align-items: center;">
              <span style="text-align: left; padding-left: 5px;">
                {{ store.idValue }} 
              </span>
              <span style="text-align: right; padding-right: 5px;">
                 ✒️
              </span>
            </td>
            <!-- <td class="left">
              <RouterLink class="board-link" :to="`/board/${board.boardId}`">{{     
                board.boardTitle
              }}</RouterLink>
            </td>  -->
            <!-- <td class="left">{{ board.boardTitle}}</td>
            <td>{{ board.userId }}</td>
            <td>{{ board.boardCreatedAt }}</td>
            <td>{{ board.boardViewCnt }}</td> -->
            <!-- <td>{{ board.boardContent }}</td> -->
           
          </tr>
        </tbody>
        <tbody>
          <tr>
            <td class = "content-cell">
              <textarea v-model="boardText" type="text" id="boardText" required placeholder="내용을 입력하세요" />
            </td>

            
          </tr>
        </tbody>
        </table>
        <br>
        <button class="btn" @click="registBoard">등록</button>
        </div>

        </div>
        <div v-else>
        <!-- <p>alert('로그인 해주세요')</p> -->
        <div>SSAFIT 멤버만 글을 작성할 수 있습니다. 로그인하세요</div>
        <RouterLink to="/login">LOGIN</RouterLink>
        </div>

  </div>
  </div>
</template>
  
<script setup>
import { ref, onMounted  } from 'vue';
import axios from 'axios';
import { useRouter } from 'vue-router';
import { useUserStore } from "@/stores/user";
import { RouterLink } from "vue-router";
import { computed } from "vue";

const store = useUserStore();

const getUser = computed(() => store.getUser());

const userId = ref('');
const boardTitle = ref('');
const boardText = ref(''); 
const router = useRouter(); 

const board = ref({
  boardId: "",
  boardTitle: "",
  userId: "",
  boardContent: "",
  boardViewCnt: "",
  boardCreatedAt: "",
});

const alertAlarm = function(){
  alert('로그인 해주세요')
}  


const registBoard = function(){
  axios({
  url: 'http://localhost:8080/api/board',
  method: 'POST',
  headers: {
      "Content-Type": "application/json"
  },
  data: {
      boardTitle : boardTitle.value,
      userId : store.idValue,
      boardContent : boardText.value,
    }
  })
  .then(() => {
    alert('글 등록 성공!')
    router.push( {name: "BoardList"})
  })
  .catch((err) => {
    console.log(err)
  })
}

onMounted(() => {
  const pathName = new URL(document.location).pathname.split("/");
  const id = pathName[pathName.length - 1];
  const API_URL = `http://localhost:8080/api/board/${id}`;
  
  axios({
    url: API_URL,
    method: "GET",
  })
    .then((res) => {
      board.value.boardId = res.data.boardId;
      board.value.boardTitle = res.data.boardTitle;
      board.value.boardContent = res.data.boardContent;
      board.value.userId = res.data.userId;
      board.value.boardViewCnt = res.data.boardViewCnt;
      board.value.boardCreatedAt = res.data.boardCreatedAt;
    })
    .catch((err) => {
      console.log(err);
    });
});

</script>

<style scoped>

.board-list {
  width: 85%;
  border-collapse: collapse;
  margin-top: 30px;
  border-top: white;
  border-left: white;
}

.board-list th, .board-list td {
padding: 10px;
/* text-align: center; 가운데 정렬로 변경 */
/* border-bottom: 1px solid #ddd;  */
border-left: 1px solid white;
border-right: 1px solid white;
}

.btn {
padding: 10px;
background-color: #333; /* 무채색 배경 */
color: #fff; /* 흰색 텍스트 */
border: none;
cursor: pointer;
margin-right: 10px;
}


.container {
text-align: center;
}

.text-center {
text-align: center;
}

.view {
width: 80%;
padding: 8px;
margin-bottom: 10px;
}

.content-cell {
  padding: 20px; /* 내용 주변의 여백을 조절 */
  text-align: left; /* 텍스트를 왼쪽 정렬로 변경 */
  white-space: pre-wrap; /* 줄 바꿈과 같은 공백 유지 */
  font-size: 16px; /* 원하는 폰트 크기로 조절 */
  width: 80%; /* 기본으로 내용을 80% 넓이로 설정 */
  margin: 0; /* 좌우 여백 제거 */
  overflow-y: auto; 
  height: 200px;
}

input[type="text"],
textarea {
  width: calc(100% - 20px); /* 테두리 포함하여 꽉 차도록 너비 조절 */
  height: calc(100% - 20px);
  border: 1px solid white; /* 테두리를 흰색으로 설정 */
}
</style>
