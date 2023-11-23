<template>
  <div class="container">
    <br>
    <h2>글 수정</h2>
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
      <input type="text" id="title" v-model="board.boardTitle" class="view"/><br />
      <label for="name">내용</label>
      <input type="text" id="name" v-model="board.boardContent" class="view" /><br />
      
      <br>
      <button class="btn" @click="updateBoard">수정</button>
      <button class="btn" @click="deleteBoard">삭제</button>
    </fieldset> -->

    <table class="board-list">
        <colgroup>
          <col style="width: 100%" />
        </colgroup>
        
        <thead>
          <tr> 
            <th style="text-align: left; padding-left: 15px; font-size: 16px;">
              <input type="text" id="title" v-model="board.boardTitle" />
            </th> 
          </tr>
        </thead>
        <tbody>
        <tr>
            <!-- <td>{{ index + 1 }}</td> -->
            <td style="display: flex; justify-content: space-between; align-items: center; background-color: #eee;">
              <span style="text-align: left; padding-left: 5px;">
                  {{ board.userId }} 
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
            <td class = "content-cell">
              <textarea type="text" id="boardText" v-model="board.boardContent"/>
            </td>
          </tr>
        </tbody>
      </table>
      <br>
      <button class="btn" @click="updateBoard">수정</button>
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
  boardFile: "",
  boardCreatedAt : "",
  boardViewCnt : ""
});


const updateBoard = () => {
  if (board.value.userId === store.idValue || store.idValue === "admin")
    emit("update-board", board.value);
  else alert("권한이 없습니다")
};

//   const deleteBoard = () => {
//     emit("delete-board", board.value);
//   };

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

.board-list {
  width: 85%;
  border-collapse: collapse;
  margin-top: 30px;
  border-top: white;
  border-left: white;

}

.board-list th, .board-list td {
padding: 10px;
border-left: 1px solid white;
border-right: 1px solid white;
background-color: white;
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
background-color: #333;
color: #fff;
border: none;
cursor: pointer;
margin-right: 10px;
}

.btn:hover {
background-color: #555;
}

.content-cell {
  padding: 20px; 
  text-align: left; 
  white-space: pre-wrap;
  font-size: 16px;
  width: 80%;
  margin: 0;
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