<template>
  <div class="container">
    <br>
    <h2>글 보기</h2>
    <!-- <fieldset class="text-center">
      <br>
      <label for="userId">글번호</label>
      <input readonly
        type="text"
        id="id"
        v-model="board.boardId"
        class="view"
      /><br />
      <label for="email">작성자</label>
      <input readonly type="email" id="email" v-model="board.userId" class="view" /><br />
      <label for="password">제목</label>
      <input readonly type="text" id="title" v-model="board.boardTitle" class="view"/><br />
      <label for="name">내용</label>
      <input readonly type="text" id="name" v-model="board.boardContent" class="view" /><br />
      
      <br>

      <button class="btn" @click="handleModifyClick">수정</button>
      <button class="btn" @click="call_confirm()">삭제</button>
    </fieldset> -->



    <table class="board-list">
        <colgroup>
          <col style="width: 100%" />
        </colgroup>
        
        <thead>
          <tr> 
            <th style="text-align: left; padding-left: 15px; font-size: 16px;">{{ board.boardTitle }}</th> 
          </tr>
        </thead>
        <tbody>
        <tr>
            <!-- <td>{{ index + 1 }}</td> -->
            <td style="display: flex; justify-content: space-between; align-items: center;">
              <span style="text-align: left; padding-left: 5px;">
                  {{ board.userId }} | 조회수 {{ board.boardViewCnt }}
              </span>
              <span style="text-align: right; padding-right: 5px;">
                  {{ board.boardCreatedAt }}
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
            <td class = "content-cell">{{ board.boardContent }}</td>
          </tr>
        </tbody>
      </table>
      <br>
      <button class="btn" @click="handleModifyClick">수정</button>
      <button class="btn" @click="call_confirm()">삭제</button>


  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import { useUserStore } from "../../stores/user";
import { useRouter } from "vue-router";

const router = useRouter();

const store = useUserStore()


const emit = defineEmits();

const board = ref({
  boardId: "",
  boardTitle: "",
  userId: "",
  boardContent: "",
  boardViewCnt: "",
  boardCreatedAt: "",
});

const handleModifyClick = () => {
  if (board.value.userId === store.idValue || store.idValue === "admin"){
    router.push(`/board/modify/${board.value.boardId}`);
  }else {
  alert("권한이 없습니다") }
};

// const deleteBoard = () => {
//   if (board.value.userId === store.idValue || store.idValue === "admin")
//     emit("delete-board", board.value);
//   else alert("권한이 없습니다")
// };


const call_confirm = function(){
 
  if(confirm("정말로 삭제하시겠습니까?")){
    
    if (board.value.userId === store.idValue || store.idValue === "admin")
    emit("delete-board", board.value);
    
    else alert("권한이 없습니다")
    console.log(board.value.userId)
    console.log(store.idValue)
  }
  else {
    return
  }
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

.view-textarea {
width: 80%;
height: 150px;
padding: 8px;
margin-bottom: 10px;
}

.btn {
padding: 10px;
background-color: #333; /* 무채색 배경 */
color: #fff; /* 흰색 텍스트 */
border: none;
cursor: pointer;
margin-right: 10px;
}

.btn:hover {
background-color: #555; /* 호버 시 어둡게 변하는 배경 */
}

.board-list {
width: 85%;
border-collapse: collapse;
margin-top: 30px;
}

.board-list th, .board-list td {
padding: 10px;
/* text-align: center; 가운데 정렬로 변경 */
/* border-bottom: 1px solid #ddd;  */
border-left: 1px solid white;
border-right: 1px solid white;
}

.board-list th {
background-color: #f2f2f2;
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

</style>