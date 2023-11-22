<template>
    <div class="main bg-light p-4" style="text-align: right; padding-left: 5px; padding-right: 100px;">
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
                    <td @click = "showScheudulePage(followerId)">{{ followerId }}</td>
                </tr>
            </tbody>
        </table>
        <br>
        <hr class="#f2f2f2"><br>
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
                    <td @click = "showScheudulePage(followId)">{{ followId }}</td>
                    <td><button @click="unFollow(followId)"><i class="bi bi-heartbreak"></i></button></td>
                </tr>
            </tbody>
        </table>
        <div v-show="store.following.length === 0">
            <h1 style="text-align: center; color: #555; margin-top: 20px; font-size: 1.5em;">
                아직 유저를 팔로잉하지 않았습니다 😔
            </h1>
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
        })
        .catch((err) => {
            console.log(err);
        });
}

</script>


<style scoped>
.board-list {
    /* background-color: antiquewhite; */
    width: 85%;
    border-collapse: collapse;
    margin-top: 5px;
    border-radius: 10px;
}


.board-list tr:hover td {
    background-color: rgb(255, 242, 242);
}

.board-list tbody {
    background-color: white;
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
    background-color: #f7e6e6;
}

.board-list td.left {
    text-align: left;
    padding-left: 20px;
}
</style>
