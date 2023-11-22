<template>
  <main class="content">
    <div class="main bg-light p-4">
      <h4 class="mb-3" style="padding-left: 30px">내 개인 정보</h4>

      <div class="row">
        <div class="col-12 col-xl-8">
          <div class="card card-body shadow-sm mb-4">
            <form>
              <div class="row mt-3">
                <div class="col-md-3 mb-3">
                  <div>
                    <label for="userGender">성별</label>
                    <select class="form-control" id="userGender" v-model="userGender">
                      <option value="0">남성</option>
                      <option value="1">여성</option>
                    </select>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-3 mb-3">
                  <div class="form-group">
                    <label for="userAge">나이</label>
                    <input
                      class="form-control"
                      id="userAge"
                      type="number"
                      v-model="userAge"
                    />
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-3 mb-3">
                  <div class="form-group">
                    <label for="userHeight">키(cm)</label>
                    <input
                      class="form-control"
                      id="userHeight"
                      type="number"
                      v-model="userHeight"
                    />
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-sm-3 mb-3">
                  <div class="form-group">
                    <label for="userCurrentWeight">현재 몸무게</label>
                    <input
                      class="form-control"
                      id="userCurrentWeight"
                      type="number"
                      v-model="userCurrentWeight"
                    />
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-sm-3 mb-3">
                  <div class="form-group">
                    <label for="userTargetWeight">목표 몸무게</label>
                    <input
                      class="form-control"
                      id="userTargetWeight"
                      type="number"
                      v-model="userTargetWeight"
                    />
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-sm-3 mb-6">
                  <div class="form-group">
                    <label for="userPreferredPlace">평소 운동 장소</label>
                    <select
                      class="form-control"
                      id="userPreferredPlace"
                      v-model="userPreferredPlace"
                    >
                      <option value="헬스장">헬스장</option>
                      <option value="집">집</option>
                    </select>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-sm-12 mb-12">
                  <div class="form-group">
                    <label for="userTargetWeight" style="width: 200%; margin-top: 10px"
                      >트레이너에게 하고 싶은 말 :
                    </label>
                    <textarea
                      class="form-control"
                      id="userExtra"
                      v-model="userExtra"
                    ></textarea>
                  </div>
                </div>
              </div>

              <div class="row mb-3 mt-3" v-show="ifExistsDetail">
                <div class="col">
                  <div class="form-group">
                    <div class="btn-group" style="float: right">
                      <button
                        type="submit"
                        id="successAlert"
                        class="btn btn-outline-dark"
                        @click="modifyDetail"
                      >
                        수정
                      </button>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row mb-3 mt-3" v-show="!ifExistsDetail">
                <div class="col">
                  <div class="form-group">
                    <div class="btn-group" style="float: right">
                      <button
                        type="submit"
                        id="successAlert"
                        class="btn btn-outline-dark"
                        @click="registDetail"
                      >
                        제출
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import { useUserStore } from "../../stores/user";
import { useRouter } from "vue-router";
const router = useRouter();

const store = useUserStore();
const ifExistsDetail = ref(true);

const userGender = ref(0);
const userAge = ref("");
const userProfilePic = ref("");
const userHeight = ref("");
const userCurrentWeight = ref("");
const userTargetWeight = ref("");
const userPreferredPlace = ref("");
const userExtra = ref("");

onMounted(() => {
  const API_URL = `http://localhost:8080/api/product/${store.idValue}`;
  axios({
    url: API_URL,
    method: "GET",
  })
    .then((response) => {
      console.log(response.status);
      if (response.status === 404) {
        ifExistsDetail.value = false;
      } else if (response.status === 200) {
        userGender.value = response.data.userGender? 0:1;
        userProfilePic.value = response.data.userProfilePic;
        userAge.value = response.data.userAge;
        userHeight.value = response.data.userHeight;
        userCurrentWeight.value = response.data.userCurrentWeight;
        userTargetWeight.value = response.data.userTargetWeight;
        userPreferredPlace.value = response.data.userPreferredPlace;
        userExtra.value = response.data.userExtra;
      } else {
        console.log(error);
      }
    })
    .catch((err) => {
      if (err.response.status === 404) {
        ifExistsDetail.value = false;
      } else {
        console.log(err);
        alert("Internal Server Error!");
      }
    });
});

const registDetail = () => {
  const API_URL = `http://localhost:8080/api/product/`;
  console.log(userDetail.value);
  const requestData = {
    userId : store.idValue,
    userGender: userGender.value === 0? true: false,
    userProfilePic: userProfilePic.value,
    userAge: userAge.value,
    userHeight: userHeight.value,
    userCurrentWeight: userCurrentWeight.value,
    userTargetWeight: userTargetWeight.value,
    userPreferredPlace: userPreferredPlace.value,
    userExtra: userExtra.value,
  };

  console.log(requestData);
  axios({
    url: API_URL,
    method: "POST",
    data: requestData
  })
    .then(() => {
      alert("등록 완료!");
    })
    .catch((err) => {
      console.log(err);
    });
};

const modifyDetail = () => {
  const API_URL = `http://localhost:8080/api/product/${store.idValue}`;
  axios({
    url: API_URL,
    method: "PUT",
    data: {
    userId : store.idValue,
    userGender: userGender.value === 0? true: false,
    userProfilePic: userProfilePic.value,
    userAge: userAge.value,
    userHeight: userHeight.value,
    userCurrentWeight: userCurrentWeight.value,
    userTargetWeight: userTargetWeight.value,
    userPreferredPlace: userPreferredPlace.value,
    userExtra: userExtra.value,
    }
  })
    .then(() => {
      alert("수정 완료!");
    })
    .catch((err) => {
      console.log(err);
    });
};
</script>
<style></style>
