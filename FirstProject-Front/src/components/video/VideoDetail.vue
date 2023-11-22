<template>
  <div class="card">
    <li style="margin-top: 40px; margin-bottom: 40px ;" class="comment-row">
      <table class="board-list comment-table">
        <colgroup>
          <col style="width: 100%" />
        </colgroup>
        <thead>
          <tr>
            <th style="display: flex; justify-content: space-between; align-items: center;">
              <span style="text-align: center; padding-left: 5px; display: flex; align-items: flex-start;">
                <!-- <span style="margin-left: 5px;">{{ store.video.videoTitle }}</span> -->
                <span style="margin-left: 5px;">{{ store.video.videoTitle }}</span>
              </span>
              <span style="text-align: right; padding-right: 5px;">
                <span> {{ modifiedVideoPart }} </span>
              </span>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td style="display: flex; justify-content: space-between; align-items: center;">
              <span style="text-align: left; padding-left: 5px; display: flex; align-items: flex-start;">
                <!-- <b style="min-width: 100px;">{{ store.video.videoPart}}</b> -->
                <span style="margin-left: 5px;">조회수 {{ store.video.videoViewCnt }}</span>
              </span>
              <span style="text-align: right; padding-right: 5px;">
                <span> {{ store.video.videoCreatedAt }} </span>
              </span>
            </td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <td style="display: flex; justify-content: space-between; align-items: center;">
              <div style="text-align: left; padding-left: 5px; display: flex; align-items: flex-start;">

              </div>
              <div class="youtube-video">
                <iframe :src="getYouTubeEmbedUrl(store.video.videoUrl)" width="560" height="315" frameborder="0"
                  allowfullscreen></iframe>
              </div>

            </td>
          </tr>
        </tfoot>
      </table>
    </li>
  </div>
  <div>
    <br>
    <h3> review </h3>
    <br>
    <div>
      <li v-for="review in reviews" :key="review.reviewId" style="margin-bottom: 75px;" class="comment-row">

        <span v-if="!review.isEditing" @mouseover="setHovered(review.reviewId, true)"
          @mouseleave="setHovered(review.reviewId, false)">
          <table class="board-list comment-table">
            <colgroup>
              <col style="width: 100%" />
            </colgroup>
            <thead>
              <tr>
                <th style="display: flex; justify-content: space-between; align-items: center;">
                  <span style="text-align: center; padding-left: 5px; display: flex; align-items: flex-start;">
                    <!-- <b style="min-width: 100px;">{{ review.userId }}</b> -->
                    <span style="margin-left: 5px;">{{ review.title }}</span>
                    <!-- <span v-if="isHovered(index)" style="cursor: pointer; margin-left: 10px; " @click="removeComment">&times;</span> -->
                    <div v-show="isHovered(review.reviewId)">
                      <span v-if="!review.isEditing">
                        <span title="수정">
                          <button @click="() => updateReviewState(review.reviewId, review.userId)"
                            style="margin-left: 10px; border: none; background: none; cursor: pointer; font-weight: bold; font-size: 16px;">🖍</button>
                        </span>
                      </span>
                      <span title="삭제">
                        <button @click="() => deleteReview(review.reviewId, review.userId)"
                          style="margin-left: 10px; border: none; background: none; cursor: pointer; font-weight: bold; font-size: 16px;">✖</button>
                      </span>

                    </div>
                  </span>
                  <span style="text-align: right; padding-right: 5px;">
                    <span> ⭐🤢⭐⭐⭐ </span>
                  </span>
                </th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td style="display: flex; justify-content: space-between; align-items: center;">
                  <span style="text-align: left; padding-left: 5px; display: flex; align-items: flex-start;">
                    <b style="min-width: 100px;">{{ review.userId }}</b>
                    <span style="margin-left: 5px;">{{ review.content }}</span>

                  </span>
                  <span style="text-align: right; padding-right: 5px;">
                    <span> {{ review.createdAt }} </span>
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
            <thead>
              <tr>
                <!-- <th>{{ review.title }}</th> -->
                <td style="display: flex; justify-content: space-between; align-items: center;">
                  <span style="text-align: left; padding-left: 5px; display: flex; align-items: flex-start;">
                    <b style="min-width: 100px;"> {{ userStore.idValue }}</b>
                    <span style="margin-left: 5px;">
                      <input type="text" v-model="modifyReview.content" id="content" placeholder="리뷰를 수정하세요" required
                        style="width: calc(250px); height: 24px;">
                    </span>
                  </span>
                  <span style="text-align: right; padding-right: 5px;">
                    <button class="commentbtn" @click="updateReview(review.reviewId, review.userId)">수정</button>
                  </span>
                </td>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td style="display: flex; justify-content: space-between; align-items: center;">
                  <span style="text-align: left; padding-left: 5px; display: flex; align-items: flex-start;">
                    <b style="min-width: 100px;"> {{ userStore.idValue }}</b>
                    <span style="margin-left: 5px;">
                      <input type="text" v-model="modifyReview.content" id="content" placeholder="리뷰를 수정하세요" required
                        style="width: calc(250px); height: 24px;">
                    </span>
                  </span>
                  <span style="text-align: right; padding-right: 5px;">
                    <button class="commentbtn" @click="updateReview(review.reviewId, review.userId)">수정</button>
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </li>
    </div>
  </div>

  <!--리뷰작성칸-->
  <div v-if="userStore.getUser">
    <table class="board-list">


      <colgroup>
        <col style="width: 100%" />
      </colgroup>
      <thead>
        <tr>
          <th style="display: flex; justify-content: space-between; align-items: center;">

            <span style="margin-left: 5px;">
              <input type="text" v-model="review.title" id="title" placeholder="제목을 입력하세요" required
                style="width: calc(250px); height: 24px;">
            </span>

            <span style="text-align: right; padding-right: 5px;">
              <span> 🤢🤢🤢🤢🤢 </span>
            </span>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td style="display: flex; justify-content: space-between; align-items: center;">
            <span style="text-align: left; padding-left: 5px; display: flex; align-items: flex-start;">
              <b style="min-width: 100px;"> {{ userStore.idValue }}</b>
              <span style="margin-left: 5px;">
                <input type="text" v-model="review.content" id="content" placeholder="리뷰를 작성하세요" required
                  style="width: calc(250px); height: 24px;">
              </span>
            </span>
            <span style="text-align: right; padding-right: 5px;">
              <button class="commentbtn" @click="createReview()">등록</button>
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

  <!--비디오 게시글 수정/삭제 기능-->
  <div>
    <button v-if="userStore.idValue == 'admin'" @click="updateVideo">수정</button>
    <button v-if="userStore.idValue == 'admin'" @click="deleteVideo">삭제</button>
  </div>
  <!-- </div> -->
  <!-- </div> -->
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useVideoStore } from '@/stores/video'
import { useUserStore } from '../../stores/user'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute();
const router = useRouter();
const store = useVideoStore();
const userStore = useUserStore();
const reviews = ref([])

const review = ref({
  reviewId: "",
  videoId: "",
  userId: "",
  createdAt: "",
  title: "",
  content: "",
  isEditing: false,
  cnt: 1,
})

const modifyReview = ref({
  reviewId: "",
  videoId: "",
  userId: "",
  createdAt: "",
  title: "",
  content: "",
  isEditing: false,
});

const getYouTubeEmbedUrl = (url) => {
  if (!url) {
    return '';
  }

  const videoIdMatch = url.match(/[?&]v=([^&]+)/);
  if (!videoIdMatch) {
    return '';
  }

  const videoId = videoIdMatch[1];
  return `https://www.youtube.com/embed/${videoId}`;
};

onMounted(async () => {
  await store.getVideo(route.params.id)
  await increaseViewCnt();
  await fetchReviews(route.params.id)
})

async function increaseViewCnt() {
  try {
    console.log(route.params.id)
    await axios.post(`http://localhost:8080/api/view/${route.params.id}`);
    console.log('조회수 증가!');
  } catch (error) {
    console.log(error)
  }
};

async function fetchReviews() {
  try {
    const response = await axios.get(`http://localhost:8080/api/review?videoId=${store.video.videoId}`)
    reviews.value = response.data
  } catch (error) {
    console.log(error)
  }
}

const updateReviewState = (reviewId, userId) => {
  // 수정 버튼 클릭 시 해당 리뷰의 수정 상태를 true로 변경
  const index = reviews.value.findIndex((item) => item.reviewId === reviewId && item.userId === userId);
  if (index !== -1) {
    reviews.value[index].isEditing = true;
    modifyReview.value.review = reviews.value[index].review; // 기존 리뷰 내용을 수정 리뷰 입력 필드에 설정
  }
};

//리뷰 작성 기능
const createReview = async function () {
  review.value.userId = userStore.idValue;
  review.value.videoId = store.video.videoId;

  await createReviewPromise(review.value);
  const reviewAPI_URL = `http://localhost:8080/api/review`;

  axios({
    url: reviewAPI_URL,
    method: "GET",
  })
    .then((reviewRes) => {
      reviews.value = [];
      reviewRes.data.forEach((reviewData) => {
        reviews.value.push({
          reviewId: reviewData.reviewId,
          videoId: reviewData.videoId,
          userId: reviewData.userId,
          content: reviewData.content,
          createdAt: reviewData.createdAt,
        });
      });

    })
    .catch((reviewErr) => {
      console.error(reviewErr);
    });

  review.value.content = "";
}

const createReviewPromise = (review) => {
  return new Promise((resolve, reject) => {
    const API_URL = `http://localhost:8080/api/review`;

    axios({
      url: API_URL,
      method: "POST",
      data: {
        videoId: review.videoId,
        reviewId: review.reviewId,
        userId: review.userId,
        createdAt: review.createdAt,
        title: review.title,
        content: review.content,
      },
    })
      .then(() => {
        alert("리뷰 등록 완료");
        resolve();
      })
      .catch((err) => {
        console.log(err);
        reject();
      });
  })
};

// 리뷰 수정 기능

//코멘트 수정
const updateReview = async function (reviewId, userId) {
  modifyReview.value.videoId = store.video.videoId;
  modifyReview.value.userId = store.idValue;
  await modifyReviewPromise(reviewId, modifyReview.value.content);
  modifyReview.value.content = "";
}

const modifyReviewPromise = (reviewId, newContent) => {
  console.log(reviewId)
  return new Promise((resolve, reject) => {
    const API_URL = `http://localhost:8080/api/review/${reviewId}`;
    axios({
      url: API_URL,
      method: "PUT",
      data: {
        reviewId: reviewId,
        videoId: review.videoId,
        userId: review.userId,
        content: newContent,
        createdAt: review.createdAt,
      },
    })
      .then(() => {
        resolve();
      })
      .catch((err) => {
        console.log(err);
        alert("에러발생")
        reject();
      });
  })

};

const deleteReview = async function (reviewId) {
  try {
    await axios.delete(`http://localhost:8080/api/review/${reviewId}`);
    console.log('리뷰 삭제 완료!')
    await fetchReviews();
  } catch (error) {
    console.log(error);
  }
};

const updateVideo = async function (videoId) {

}

const deleteVideo = async function () {
  try {
    await axios.delete(`http://localhost:8080/api/video/${store.video.videoId}`);
    console.log('삭제 완료!')
    router.push("/video");
  } catch (error) {
    console.log(error);
  }
};

const hoverStates = ref([]);

const setHovered = (reviewId, value) => {
  hoverStates.value[reviewId] = value;
  console.log(reviewId)
  console.log(value);

};

const isHovered = (reviewId) => {
  return hoverStates.value[reviewId];
  console.log(hoverStates.value)
};


const modifiedVideoPart = computed(() => {
  if (store.video.videoPart) {
    const modifiedValue = store.video.videoPart.split('(')[0].trim();
    return modifiedValue;
  }
  return "값이 없습니다."
});

</script>

<style scoped>
.youtube-video {
  position: relative;
  width: 100%;
  padding-bottom: 56.25%;
}

.youtube-video iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
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
  background-color: rgb(221, 219, 219);
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

.btn:hover {
  background-color: #555;
  /* 호버 시 어둡게 변하는 배경 */
}

.content-cell {
  padding: 20px;
  /* 내용 주변의 여백을 조절 */
  text-align: left;
  /* 텍스트를 왼쪽 정렬로 변경 */
  white-space: pre-wrap;
  /* 줄 바꿈과 같은 공백 유지 */
  font-size: 16px;
  /* 원하는 폰트 크기로 조절 */
  width: 80%;
  /* 기본으로 내용을 80% 넓이로 설정 */
  margin: 0;
  /* 좌우 여백 제거 */
  overflow-y: auto;
  height: 200px;
}

input[type="text"],
textarea {
  width: calc(100% - 20px);
  /* 테두리 포함하여 꽉 차도록 너비 조절 */
  height: calc(100% - 20px);
  border: 1px solid white;
  /* 테두리를 흰색으로 설정 */
}</style>
