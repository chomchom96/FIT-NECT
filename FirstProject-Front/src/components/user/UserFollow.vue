<template>
    <div>
        <div class="container">
            <div style="text-align: center; justify-content:center; margin-top : 70px">
                <div><label for="userId" style="font-size : 25px; width: 200px;">ID를 입력하세요</label></div>
                <div>
                <input type="text" style="display: inline-block;" class="form-control" v-model="searchUserId" id="userId" />
                </div>
                <button class="btn btn-secondary" @click="searchUser">검색</button>
                </div>
                <div>
            </div>

            <!-- <div v-if="isValid" style="text-align: center; margin-top : 30px">
                <h2>사용자 검색 결과</h2>
                <div class="row" style="justify-content: center;">
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
            </div> -->




            <div v-if="isValid" >
                
            <table class="table" style="margin-top :50px">
                <thead>
                    <tr>
                        <th>User ID</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="u in user" :key="u.userSeq" data-bs-toggle="modal" data-bs-target="#detailModal" @mouseover="setHovered(u, true)" @mouseleave="setHovered(u, false)">
                        <td @click="showUserDetails(u)">{{ u.userId }}</td>
                    </tr>
                </tbody>
            </table>
            <div class="modal fade" id="detailModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3>회원 정보</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>ID : {{ selectedUser.userId }}</p>
                            <p>Email : {{ selectedUser.userEmail }}</p>
                            <p>Nickname : {{ selectedUser.userNickname }}</p>
                            <div v-if="isFollowing(selectedUser.userId)" @click="follow(selectedUser.userId)">팔로잉하시겠습니까?</div>
                            <div v-else @click="unFollow(selectedUser.userId)">팔로잉을 취소하시겠습니까?</div>
                            
                            <hr>
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

const hoverStates = ref([]);

const setHovered = (u, value) => {
  hoverStates.value[u] = value;
};



</script>

<style scoped>

.table tr:hover td {
  background-color: rgb(231, 231, 231)
}


.container {
    justify-content: center;
}

table {
    width: 300px;
    margin: 0 auto;
}

input {
    width: 300px;
}

label {
    font-size: medium;
    font-weight: bold;
}
.card {
    margin: 20px;
    width: 150px;
    
}

.modal {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.modal-dialog {
    max-width: 80%;
    width: 20%;
}

.modal-backdrop {
    z-index: 1061 !important;
}
</style>