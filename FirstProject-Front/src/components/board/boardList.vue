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
          <!-- <th>글내용</th> -->
          <th>글쓴이</th>
          <th>작성일</th>
          <th>조회수</th>
        </tr>
      </thead>
      <tbody>
        <tr class="board-row" v-for="(board, index) in computedBoard" :key="index" @click="handleRowClick(board.boardId)">
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
    <div class="search-container">
      <form @submit.prevent="submitSearchForm" class="d-flex justify-content-center align-items-center">        <div class="col-2" style="display: inline-block;">
          <select v-model="searchKey" class="form-select">
            <option value="boardTitle">제목</option>
            <option value="boardContent">내용</option>
            <option value="userId">글쓴이</option>
            <option value="boardId">글번호</option>
          </select>
        </div>
        <div class="col-2" style="display: inline-block;">
          <input v-model="searchWord" name="word" class="form-control">
        </div>

        <div class="col-5" style="display: inline-block;">
          <button type="button" class="btn" @click="submitSearchForm">검색</button>
        </div>

      </form>

      <br>
      <nav aria-label="Page navigation">
        <ul class="pagination">
          <li class="page-item" :class="{ disabled: currentPage === 1 }">
            <a class="page-link" @click="changePage(currentPage - 1)" aria-label="Previous">
              <span aria-hidden="true">&laquo;</span>
            </a>
          </li>
          <li v-for="page in pages" :key="page" class="page-item" :class="{ active: page === currentPage }">
            <a class="page-link" @click="changePage(page)">{{ page }}</a>
          </li>
          <li class="page-item" :class="{ disabled: currentPage === totalPages }">
            <a class="page-link" @click="changePage(currentPage + 1)" aria-label="Next">
              <span aria-hidden="true">&raquo;</span>
            </a>
          </li>
        </ul>
      </nav>
    </div>
  </div>
</template>

<script setup>

import { ref, onMounted, computed, watch } from 'vue'
import { useBoardStore } from '@/stores/board'
import { useRouter } from 'vue-router';

const router = useRouter();
const store = useBoardStore()

const itemsPerPage = 10;
const currentPage = ref(1);
const totalPages = computed(() => Math.ceil(store.board.length / itemsPerPage));
const pages = ref([]);

const computedBoard = computed(() => {
  const startIndex = (currentPage.value - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;
  const boards = store.board.slice(startIndex, endIndex)
  return boards;
})

onMounted(() => {
  store.getBoardList();
  searchKey.value = "boardTitle";
  updatePages();
})

watch(currentPage, () => {
  updatePages();
});

const updatePages = () => {
  const startPage = Math.max(1, currentPage.value - 2);
  const endPage = Math.min(totalPages.value, startPage + 4);

  pages.value = Array.from({ length: endPage - startPage + 1 }, (_, i) => startPage + i);
};

const changePage = (page) => {
  if (page >= 1 && page <= totalPages.value) {
    currentPage.value = page;
  }
};


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

/* .search-container {
  display: flex;
  flex-direction: column;
  align-items: center;
} */



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
