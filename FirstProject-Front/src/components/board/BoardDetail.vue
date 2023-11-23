<template>
  <div class="container" style="margin-top:40px;">
    <br> <br>
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
          <td class="example" style="display: flex; justify-content: space-between; align-items: center;">
            <span style="text-align: left; padding-left: 5px;">
              {{ board.userId }} | 조회수 {{ board.boardViewCnt }}
            </span>
            <span style="text-align: right; padding-right: 5px;">
              {{ board.boardCreatedAt }}
            </span>
          </td>

        </tr>
      </tbody>
      <tbody>
        <tr>
          <td class="content-cell example" style="text-align: left;">{{ board.boardContent }}</td>
        </tr>
      </tbody>
    </table>
    <br>
    <button class="btn" @click="handleModifyClick">수정</button>
    <button class="btn" @click="call_confirm()">삭제</button>

    
    <div>
      <br>
      <h3> comment </h3>

      <div>
        <!-- comments 배열을 순회하며 각 comment의 comment 속성을 출력 -->
        <li v-for="(commentItem, index) in comments" :key="index" style="margin-bottom: 0px;" class="comment-row"
          @mouseover="setHovered(index, true)" @mouseleave="setHovered(index, false)">

          <span v-if="!commentItem.isEditing">
            <table class="board-list comment-table">
              <colgroup>
                <col style="width: 100%" />
              </colgroup>
              <tbody>
                <tr>
                  <td style="display: flex; justify-content: space-between; align-items: center;">
                    <span style="text-align: left; padding-left: 5px; display: flex; align-items: flex-start;">
                      <b style="min-width: 100px;">{{ commentItem.userId }}</b>
                      <span style="margin-left: 5px;">{{ commentItem.comment }}</span>
                      <!-- <span v-if="isHovered(index)" style="cursor: pointer; margin-left: 10px; " @click="removeComment">&times;</span> -->
                      <div v-show="isHovered(index)">
                        <span v-if="!commentItem.isEditing">
                          <span title="수정">
                            <button @click="() => updateCommentState(commentItem.commentSeq, commentItem.userId)"
                              style="margin-left: 10px; border: none; background: none; cursor: pointer; font-weight: bold; font-size: 16px;">🖍</button>
                          </span>
                        </span>
                        <span title="삭제">
                          <button @click="() => removeComment(commentItem.commentSeq, commentItem.userId)"
                            style="margin-left: 10px; border: none; background: none; cursor: pointer; font-weight: bold; font-size: 16px;">✖</button>
                        </span>

                      </div>
                    </span>
                    <span style="text-align: right; padding-right: 5px;">
                      <span> {{ commentItem.createdAt }} </span>
                    </span>
                  </td>
                </tr>
              </tbody>
            </table>
          </span>
          <div v-else>
            <table class="board-list">
              <colgroup>
                <col style="width: 100%" />
              </colgroup>

              <tbody>
                <tr>
                  <td style="display: flex; justify-content: space-between; align-items: center;">
                    <span style="text-align: left; padding-left: 5px; display: flex; align-items: flex-start;">
                      <b style="min-width: 100px;"> {{ store.idValue }}</b>
                      <span style="margin-left: 5px;">
                        <input type="text" v-model="modifyComment.comment" id="comment" placeholder="댓글을 수정하세요" required
                          style="width: calc(250px); height: 24px;">
                      </span>
                    </span>
                    <span style="text-align: right; padding-right: 5px;">
                      <button class="commentbtn"
                        @click="updateComment(commentItem.commentSeq, commentItem.userId)">수정</button>
                    </span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </li>
      </div>
    </div>
    <br>

    <!-- 댓글 작성칸 -->


    <div v-if="store.getUser">
      <table class="board-list">


        <colgroup>
          <col style="width: 100%" />
        </colgroup>

        <tbody>
          <tr>
            <td style="display: flex; justify-content: space-between; align-items: center;">
              <span style="text-align: left; padding-left: 5px; display: flex; align-items: flex-start;">
                <b style="min-width: 100px;"> {{ store.idValue }}</b>
                <span style="margin-left: 5px;">
                  <input type="text" v-model="comment.comment" id="comment" placeholder="댓글을 작성하세요" required
                    style="width: calc(250px); height: 24px;">
                </span>
              </span>
              <span style="text-align: right; padding-right: 5px;">
                <button class="commentbtn" @click="createComment()">등록</button>
              </span>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div v-else>
      <br>
      로그인한 회원만 댓글을 작성할 수 있습니다.
    </div>


    <br>
    <br>
    <br>
    <br>
    <br>





  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import { useUserStore } from "../../stores/user";
import { useRouter } from "vue-router";
import { useCommentStore } from "../../stores/comment";

const commentStore = useCommentStore();

const router = useRouter();

const store = useUserStore()

const comments = ref([]);

const comment = ref({
  commentSeq: "",
  boardId: "",
  userId: "",
  comment: "",
  createdAt: "",
  isEditing: false,
});

const modifyComment = ref({
  commentSeq: "",
  boardId: "",
  userId: "",
  comment: "",
  createdAt: "",
  isEditing: false,
});

const emit = defineEmits();

const board = ref({
  boardId: "",
  boardTitle: "",
  userId: "",
  boardContent: "",
  boardViewCnt: "",
  boardCreatedAt: "",
});

const updateCommentState = (commentSeq, userId) => {
  if (userId === store.idValue || store.idValue === "admin") {
    const index = comments.value.findIndex((item) => item.commentSeq === commentSeq && item.userId === userId);
    if (index !== -1) {
      comments.value[index].isEditing = true;
      modifyComment.value.comment = comments.value[index].comment; // 기존 댓글 내용을 수정 댓글 입력 필드에 설정
    }
  } else {
    alert("권한이 없습니다");
  }
};

const createComment = async function () {
  comment.value.boardId = board.value.boardId;
  comment.value.userId = store.idValue;
  console.log(comment)
  console.log(comment.value.comment)
  await commentStore.createCommentPromise(comment.value);


  const commentAPI_URL = `http://localhost:8080/api/comment/board/${board.value.boardId}`;

  axios({
    url: commentAPI_URL,
    method: "GET",
  })
    .then((commentRes) => {

      comments.value = [];

      commentRes.data.forEach((commentData) => {
        comments.value.push({
          commentSeq: commentData.commentSeq,
          boardId: commentData.boardId,
          userId: commentData.userId,
          comment: commentData.comment,
          createdAt: commentData.createdAt,
        });
      });

    })
    .catch((commentErr) => {
      console.error(commentErr);
    });





  comment.value.comment = "";
}


//코멘트 수정
const updateComment = async function (commentSeq, userId) {
  console.log("프론트에서확인")
  console.log(commentSeq)
  console.log(userId)
  modifyComment.value.boardId = board.value.boardId;
  modifyComment.value.userId = store.idValue;
  console.log(commentSeq);

  console.log(comment)
  console.log(comment.value.comment)
  await commentStore.modifyCommentPromise(commentSeq, modifyComment.value.comment);

  const commentAPI_URL = `http://localhost:8080/api/comment/board/${board.value.boardId}`;

  axios({
    url: commentAPI_URL,
    method: "GET",
  })
    .then((commentRes) => {

      comments.value = [];

      commentRes.data.forEach((commentData) => {
        comments.value.push({
          commentSeq: commentData.commentSeq,
          boardId: commentData.boardId,
          userId: commentData.userId,
          comment: commentData.comment,
          createdAt: commentData.createdAt,
        });
      });
    })
    .catch((commentErr) => {
      console.error(commentErr);
    });





  modifyComment.value.comment = "";
}


const removeComment = async function (commentSeq, userId) {

  if (userId === store.idValue || store.idValue === "admin") {
    await commentStore.deleteCommentPromise(commentSeq);


    const commentAPI_URL = `http://localhost:8080/api/comment/board/${board.value.boardId}`;

    axios({
      url: commentAPI_URL,
      method: "GET",
    })
      .then((commentRes) => {

        comments.value = [];

        commentRes.data.forEach((commentData) => {
          comments.value.push({
            commentSeq: commentData.commentSeq,
            boardId: commentData.boardId,
            userId: commentData.userId,
            comment: commentData.comment,
            createdAt: commentData.createdAt,
          });
        });
      })
      .catch((commentErr) => {
        console.error(commentErr);
      });

  } else {
    alert("권한이 없습니다")
  }

}

const handleModifyClick = () => {
  if (board.value.userId === store.idValue || store.idValue === "admin") {
    router.push(`/board/modify/${board.value.boardId}`);
  } else {
    alert("권한이 없습니다")
  }
};


const call_confirm = function () {

  if (confirm("정말로 삭제하시겠습니까?")) {

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
      const commentAPI_URL = `http://localhost:8080/api/comment/board/${board.value.boardId}`;

      axios({
        url: commentAPI_URL,
        method: "GET",
      })
        .then((commentRes) => {

          comments.value = [];

          commentRes.data.forEach((commentData) => {
            comments.value.push({
              commentSeq: commentData.commentSeq,
              boardId: commentData.boardId,
              userId: commentData.userId,
              comment: commentData.comment,
              createdAt: commentData.createdAt,
            });
          });

        })
        .catch((commentErr) => {
          console.error(commentErr);
        });

    })
    .catch((err) => {
      console.log(err);
    });

  commentStore.getCommentList();
  console.log(comment);
});

const hoverStates = ref([]);

const setHovered = (index, value) => {
  hoverStates.value[index] = value;
};

const isHovered = (index) => {
  return hoverStates.value[index];
};



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
  background-color: #333;
  color: #fff;
  border: none;
  cursor: pointer;
  margin-right: 10px;
  width: 75px;
}

.btn:hover {
  background-color: #555;
}
.container {
  text-align: center;
  flex-direction: column;
  align-items: center;
}

.board-list {
  width: 85%;
  border-collapse: collapse;
  margin-top: 5px;
}


.board-list tr:hover td:not(.example) {
  background-color: #eee;
}

button {
  width: max-content;
}

.board-list th,
.board-list td {
  padding: 10px;
  background-color: white;
  text-align: center;
  border-bottom: 1px solid #ddd;
  border-left: 1px solid white;
  border-right: 1px solid white;
}

.board-list th {
  background-color: #f2f2f2;
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