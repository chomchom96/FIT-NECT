<template>
    <div>
        <div class="container">
            <div>
                <label for="userId">ID를 입력하세요</label>
                <input type="text" v-model="searchUserId" id="userId" />
                <button @click="searchUser">검색</button>
            </div>

            <div v-if="isValid">
                <h2>사용자 검색 결과</h2>
                <div class="row">
                    <div class="col-md-4">
                        <div class="card" v-for="u in user" :key="u.userSeq" data-bs-toggle="modal"
                            data-bs-target="#detailModal">
                            <p @click="showUserDetails(u)">{{ u.userId }}</p>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="detailModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3>User Detail</h3>
                            </div>
                            <div class="modal-body">
                                <p>User ID: {{ selectedUser.userId }}</p>
                                <p>User Email: {{ selectedUser.userEmail }}</p>
                                <p>User Nickname: {{ selectedUser.userNickname }}</p>
                                <div v-if="isFollowing(selectedUser.userId)" @click="follow(selectedUser.userId)">팔로잉?</div>
                                <div v-else @click="unFollow(selectedUser.userId)">팔로잉하기</div> <hr>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div v-else>
                <h1 style="text-align: center; color: #555; margin-top: 20px; font-size: 1.5em;">
                    올바른 검색값을 입력해주세요 😔
                </h1>
            </div>
        </div>

    </div>
</template>
  

<script setup>
import { ref } from 'vue';
import axios from 'axios';
import { useUserStore } from '../../stores/user';

const store = useUserStore();
const searchUserId = ref('');
const user = ref([]);
const selectedUser = ref({});
const isValid = ref(true);

const showUserDetails = (user) => {
    selectedUser.value = user;
};


const searchUser = () => {
    {
        axios({
            url: `http://localhost:8080/api/users/search/${searchUserId.value}`,
            method: "GET",
        })
            .then((res) => {
                user.value = res.data;
                if (user.value.length == 0) isValid.value = false;
                else isValid.value = true;
            })
            .catch((err) => {
                console.log(err);
            });
    };
    console.log(user.value)
}

const isFollowing = (followId) => {
    axios({
        url: `http://localhost:8080/api/users/${store.idValue}/${followId}`,
        method: "GET",
    })
        .then((res) => {
            return res.data;
        })
        .catch((err) => {
            console.log(err);
        });
}

const follow = (followId) => {
    const API_URL = `http://localhost:8080/api/follow/${followId}`;
    axios({
        url: API_URL,
        method: "POST",
        data: store.idValue
    })
        .then(() => {
            alert("팔로우 완료!");
        })
        .catch((err) => {
            console.log(err);
        });
}

const unFollow = (followId) => {
    console.log(store.idValue)
    console.log(followId)
    const API_URL = `http://localhost:8080/api/follow/${followId}`;
    axios({
        url: API_URL,
        method: "DELETE",
        data: store.idValue
    })
        .then(() => {
            alert("언팔로우 완료!");
        })
        .catch((err) => {
            console.log(err);
        });
}

</script>

<style scoped>
.card {
    margin: 20px;
}

.modal {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.modal-dialog {
    max-width: 80%;
    width: auto;
}

.modal-backdrop {
    z-index: 1061 !important;
}
</style>