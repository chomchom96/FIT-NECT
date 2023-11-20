<template>
  <div class="container">
    <br>
    <h2>게시판</h2>
    <div style="text-align: right; padding-left: 5px; padding-right: 100px;">
      <RouterLink to="/board/write">
        <button class="btn"> 글쓰기 </button>
      </RouterLink>
    </div>
    <table class="board-list">

      <colgroup>
        <col style="width: 3%" />
        <col style="width: 10%" />
        <col style="width: 5%" />
        <col style="width: 5%" />
        <col style="width: 5%" />
      </colgroup>

      <thead>
        <tr>
          <th>No</th>
          <th>
            제목
          </th>
          <th>글쓴이</th>
          <th>작성일</th>
          <th>조회수</th>
        </tr>
      </thead>
      <tbody>
        <tr class="board-row" v-for="(board, index) in pagenatedBoard" :key="index"
          @click="handleRowClick(board.boardId)">
          <td>
            {{ board.boardId }}
          </td>
          <td class="left">{{ board.boardTitle }}</td>
          <td>{{ board.userId }}</td>
          <td>{{ board.boardCreatedAt }}</td>
          <td>{{ board.boardViewCnt }}</td>
        </tr>
      </tbody>
    </table>
    <br>
    <nav aria-label="Page navigation">
      <ul class="pagination justify-content-center">
        <li class="page-item" :class="{ 'disabled': currentPage === 1 }">
          <a class="page-link" @click="prevPage" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
          </a>
        </li>
        <li class="page-item" v-for="page in rows" :key="page" :class="{ 'active': currentPage === page }">
          <a class="page-link" @click="setPage(page)" href="#">{{ page }}</a>
        </li>
        <li class="page-item" :class="{ 'disabled': currentPage === rows }">
          <a class="page-link" @click="nextPage" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
          </a>
        </li>
      </ul>
    </nav>
    <div class="text-center mt-3">
      <form @submit.prevent="submitSearchForm" class="d-flex justify-content-center align-items-center">
        <div class="col-2">
          <select v-model="searchKey" class="form-select">
            <option value="boardTitle">제목</option>
            <option value="boardContent">내용</option>
            <option value="userId">글쓴이</option>
            <option value="boardId">글번호</option>
          </select>
        </div>
        <div class="col-5">
          <input v-model="searchWord" name="word" class="form-control">
        </div>
        <div class="form-row float-right">
          <button id="myBtn" class="btn btn-primary btn-md" @click="submitSearchForm">검색</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>

import { ref, onMounted, computed } from 'vue'
import { useBoardStore } from '@/stores/board'
import { useRouter } from 'vue-router';

const router = useRouter();
const store = useBoardStore()
const perPage = 10;
const currentPage = ref(1);
const rows = computed(() => Math.ceil(store.board.length / perPage));


const setPage = (page) => {
  if (page >= 1 && page <= rows.value) {
    currentPage.value = page;
  }
};

const prevPage = () => {
  setPage(currentPage.value - 1);
};

const nextPage = () => {
  setPage(currentPage.value + 1);
};

const pagenatedBoard = computed(() => {
  const start = (currentPage.value - 1) * perPage;
  const end = start + perPage;
  return store.board.slice(start, end);
})


onMounted(() => {
  store.getBoardList();
  searchKey.value = "boardTitle";
})

const searchKey = ref("none");
const searchWord = ref("");
const searchOrderBy = ref("none");
const searchOrderByDir = ref("asc");

const submitSearchForm = () => {
  const searchParams = {
    key: searchKey.value,
    word: searchWord.value,
    orderBy: searchOrderBy.value,
    orderByDir: searchOrderByDir.value,
  };
  store.searchBoardList(searchParams);
};

const props = defineProps({
  board: {
    type: Array,
    default: () => [],
  },
});

const handleRowClick = (boardId) => {
  router.push(`/board/${boardId}`);
};

</script>

<style scoped>
#myBtn {
  width: 100px;
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


.board-list tr:hover td {
  background-color: rgb(249, 247, 247);
}


.board-list th,
.board-list td {
  padding: 10px;
  text-align: center;
  border-bottom: 1px solid #ddd;
  border-left: 1px solid white;
  border-right: 1px solid white;
}

.board-list th {
  background-color: #f2f2f2;
}

.board-link {
  color: darkslategrey;
  text-decoration: none;
}

.board-link:hover {
  text-decoration: underline;
}

.left {
  text-align: left;
  padding-left: 10px;
}

.title {
  text-align: center;
}

.board-list td.left {
  text-align: left;
  padding-left: 20px;
  /* 추가한 여백 */
}

.row {
  text-align: center;
}

.search-container {
  display: flex;
  flex-direction: column;
  align-items: flex-center;
}



.btn {
  padding: 10px;
  background-color: #333;
  /* 무채색 배경 */
  color: #fff;
  /* 흰색 텍스트 */
  border: none;
  cursor: pointer;
  margin-right: 10px;
}
</style>
