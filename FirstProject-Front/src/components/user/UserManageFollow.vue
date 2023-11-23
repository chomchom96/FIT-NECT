<template>
    <h1 style="margin-top:50px; text-align: center;">MY FOLLOWING</h1>
    <div class="card-container" style="margin-top : 40px;">
        
        <div class="card" style="width: 600px;">
            <div class="main bg-light p-4" style="text-align: right; padding-left: 5px; padding-right: 100px;">
                <div class="col-6" v-if="store.follower.length > 0">
                    <table class="board-list">
                        <colgroup>
                            <col style="width: 5%" />
                            <col style="width: 15%" />
                        </colgroup>

                        <thead>
                            <tr>
                                <th>No</th>
                                <th>팔로워</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="board-row" v-for="(followerId, index) in store.follower" :key="index">
                                <td>{{ index + 1 }}</td>
                                <td @click="showScheudulePage(followerId)">{{ followerId }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div v-else>
                    <h1 style="text-align: center; color: #555; margin-top: 20px; font-size: 1.5em;">
                        아직 유저를 팔로우하지 않았습니다 😔
                    </h1>
                </div>

                <br>
                <hr class="#f2f2f2"><br>
                <div class="col-6">
                    <table class="board-list" v-show="store.following.length > 0">
                        <colgroup>
                            <col style="width: 5%" />
                            <col style="width: 15%" />
                            <col style="width: 5%" />
                        </colgroup>

                        <thead>
                            <tr>
                                <th>No</th>
                                <th>팔로잉</th>
                                <th>언팔로우</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="board-row" v-for="(followId, index) in store.following" :key="index">
                                <td>{{ index + 1 }}</td>
                                <td @click="showScheudulePage(followId)">{{ followId }}</td>
                                <td><button @click="unFollow(followId)"><i class="bi bi-heartbreak"></i></button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div v-show="store.following.length === 0">
                    <h1 style="text-align: center; color: #555; margin-top: 20px; font-size: 1.5em;">
                        아직 유저를 팔로잉하지 않았습니다 😔
                    </h1>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { onMounted } from 'vue';
import { useUserStore } from '../../stores/user';
import axios from 'axios';
import { useRouter } from 'vue-router';

const router = useRouter();
const store = useUserStore()

onMounted(() => {
    store.getFollower();
    store.getFollowing();
})

const showScheudulePage = (id) => {
    router.push("/users/follow/" + id)
}

const unFollow = (followId) => { // 내가 팔로우한 상대를 해제할 수 있음
    console.log(store.idValue)
    console.log(followId)
    const API_URL = `http://localhost:8080/api/follow/${followId}`;
    axios({
        url: API_URL,
        method: "DELETE",
        data: store.idValue
    })
        .then(() => {
            alert("언팔로우");
            location.reload(true);
        })
        .catch((err) => {
            console.log(err);
        });
}

</script>


<style scoped>

.card-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 50vh; /* Adjust the height as needed */
}

.card {
    width: 80%;
    /* Adjust the width as needed */
    border: 1px solid #ddd;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

.col-6 {
    margin-left: 25%;
}

table {
    align-self: center;
}
.board-list {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

.board-list td button:hover {
    color: red;
}
.board-list tr:nth-child(even) {
    background-color: #f9f9f9; 
}

.board-list tr:hover {
    background-color: #f1f1f1; 
}

.board-list th,
.board-list td {
    padding: 12px;
    text-align: center;
   
}

.board-list th {
    background-color: #f2f2f2;
}

.board-list td.left {
    text-align: left;
    padding-left: 20px;
}

/* Icons for actions */
.board-list td button {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 16px;
}
</style>