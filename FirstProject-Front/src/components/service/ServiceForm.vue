<template>
    <div class="form-container">
        <label for="gender">성별:</label>
        <select id="gender" v-model="gender" class="form-control">
            <option value="0">남성</option>
            <option value="1">여성</option>
        </select>
        <label for="age">나이:</label>
        <input type="number" id="age" v-model="age" class="form-control" />

        <label for="height">키 (cm):</label>
        <input type="number" id="height" v-model="height" class="form-control" />

        <label for="currentWeight">현재 몸무게 (kg):</label>
        <input type="number" id="currentWeight" v-model="currentWeight" class="form-control" />

        <label for="targetWeight">목표 몸무게 (kg):</label>
        <input type="number" id="targetWeight" v-model="targetWeight" class="form-control" />

        <label for="comment">코멘트</label>
        <textarea id="comment" v-model="comment" class="form-control" rows="3"></textarea>

        <label for="preferredPlace">선호 운동 장소</label>
        <select id="preferredPlace" v-model="preferredPlace" class="form-control">
            <option value="헬스장">헬스장</option>
            <option value="집">집</option>
        </select>

        <button @click="submitForm" class="btn btn-primary">START MATCHING</button>
    </div>
</template>
  
<script setup>
import { ref } from 'vue';
import { useServiceStore } from '@/stores/service';
import { useUserStore } from '@/stores/user';

const store = useServiceStore();
const userStore = useUserStore();

const gender = ref(0);
const age = ref(0);
const height = ref(0);
const currentWeight = ref(0);
const targetWeight = ref(0);
const comment = ref('');
const preferredPlace = ref('')

const submitForm = () => {
    const userDetail = {
        userId: userStore.idValue,
        userGender: gender.value,
        userAge: age.value,
        userHeight: height.value,
        userCurrentWeight: currentWeight.value,
        userTargetWeight: targetWeight.value,
        userExtra: comment.value,
        userPreferredPlace: preferredPlace.value
    };
    store.registDetail(userDetail);
};

</script>
  
<style scoped>
* {
  font-family: 'Nanum Gothic', sans-serif;
}
.form-container {
    max-width: 400px;
    margin: auto;
    padding: 20px;
}

.form-control {
    margin-bottom: 10px;
}

.btn {
    width: 100%;
}
</style>
  