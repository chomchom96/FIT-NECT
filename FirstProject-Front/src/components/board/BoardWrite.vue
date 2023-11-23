<template>

  <div class="container">
    <br>
    <h2>글 작성</h2>
      <div>
        <div v-if="store.getUser">
  
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
              <td style="display: flex; justify-content: space-between; align-items: center; background-color: #eee; ">
                <span style="text-align: left; padding-left: 5px;">
                  {{ store.idValue }} 
                </span>
                <span style="text-align: right; padding-right: 5px;">
                   ✒️
                </span>
              </td>
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
    /* border-top: white;
    border-left: white; */
    background-color: white;
  }
  
  /* .board-list tb {
    background-color: #f2f2f2;
  } */
  
  .board-list th, .board-list td {
  padding: 10px;
  /* text-align: center; 가운데 정렬로 변경 */
  /* border-bottom: 1px solid #ddd;  */
  border-left: 1px solid #eee;
  border-right: 1px solid #eee;
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
    width: calc(100% - 20px); 
    height: calc(100% - 20px);
    border: 1px solid white; 
  }
  </style>
  