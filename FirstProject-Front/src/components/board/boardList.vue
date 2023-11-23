<template>
  <div class="container">
    <br><br>
    <h2>질문 게시판</h2>
    <div style="text-align: right; padding-left: 5px; padding-right: 100px;">
      <RouterLink to="/board/write">
        <button class="btn btn-secondary"> 글쓰기 </button>
      </RouterLink>
    </div>
    <table class="board-list">

      <colgroup>
        <col style="width: 2%" />
        <col style="width: 16%" />
        <col style="width: 3%" />
        <col style="width: 10%" />
        <col style="width: 2%" />
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
      <form @submit.prevent="submitSearchForm" class="d-flex justify-content-center align-items-center">
        <div class="col-1" style="display: inline-block; margin-right:8px;">
            <select v-model="searchKey" class="form-select">
              <option value="boardTitle">제목</option>
              <option value="boardContent">내용</option>
              <option value="userId">글쓴이</option>
              <option value="boardId">글번호</option>
            </select>
        </div>
     
          <input v-model="searchWord" name="word" class="form-control">
        

        <span>
          <button type="button" class="btn btn-secondary" @click="submitSearchForm">검색</button>
        </span>

      </form>

      <br>

    </div>
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

const computedBoard = computed(() => {
  const startIndex = (currentPage.value - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;
  const boards = store.board.slice(startIndex, endIndex-1);
  return boards;
})

const pages = computed(()=>{
  const startPage = Math.max(1, currentPage.value - 2);
  const totalPages =  Math.ceil(store.board.length / itemsPerPage);
  const endPage = Math.min(totalPages, startPage + 4);
  return  Array.from({ length: endPage - startPage + 1 }, (_, i) => startPage + i);
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
}


.search-container {
  display: flex;
  flex-direction: column;
  align-items: stretch;
}

.btn {
  background-color: #424242;
  color: #fff;
  border: none;
  cursor: pointer;
  margin-right: 10px;
}

nav {
  text-align: center;
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  background-color: #fff;
  border-top: 1px solid #ccc;
}

.pagination {
  display: inline-block;
  margin: 20px 0;
}

.page-item {
  display: inline-block;
  margin: 5px;
}

.page-link {
  color: #333;
  background-color: #fff;
  border: 1px solid #ddd;
}

.page-link:hover {
  background-color: #eee;
}

.page-item.active .page-link {
  color: #000;
  background-color: #f8f8f8;
  border: 1px solid #ccc;
}

.page-item.disabled .page-link {
  pointer-events: none;
}



.form-control {
  width: 40%;
}

.btn-search {
  margin-top: -5px;
}</style>
