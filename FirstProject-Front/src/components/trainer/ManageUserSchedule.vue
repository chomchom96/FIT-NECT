<template>
  <div class="container py-7">
    <h2 class="text-uppercase text-letter-spacing-xs my-0 text-primary font-weight-bold">
      사용자 스케줄 관리
    </h2>
    <p class="text-sm text-dark mt-0 mb-5">맞춤형 스케줄을 관리하세요!</p>
    <div class="row">
      <div v-for="(day, index) in schedule" :key="index" class="col-lg-4 mb-3" :id="day.id">
        <h4 class="mt-0 mb-3 text-dark op-8 font-weight-bold">
          {{ day.title }}
        </h4>

        <ul class="list-timeline list-timeline-primary">
          <li v-for="(item, itemIndex) in day.items" :key="itemIndex"
            class="list-timeline-item p-0 pb-3 pb-lg-4 d-flex flex-wrap flex-column">
            <p class="my-0 text-dark flex-fw text-sm text-uppercase">
              <span class="text-inverse op-8">{{ item.time }}</span> - {{ item.title }} -
              {{ item.part }}
              <span class="ml-2 cursor-pointer" @click="modifyItem(day.id, itemIndex)">✎</span>
              <span class="ml-2 cursor-pointer" @click="deleteItem(day.id, itemIndex)">❌</span>
            </p>
          </li>
        </ul>
      </div>
    </div>
    <br><br><br>
    <hr>
    <form @submit.prevent="addNewSchedule" id="exercise-form">
      <h4 class="mt-4 mb-3 text-dark op-8 font-weight-bold" >운동을 추가하세요</h4>
      <div class="row">
        <div class="col-md-6">
          <div class="input-group mb-3">
            <label for="newDay">날짜</label>
            <input type="date" id="newDay" v-model="newDay" class="form-control" required />
          </div>
        </div>
      </div>
      <div class="row">

        <div class="col-md-6">
          <div class="input-group mb-3">
            <label for="startTime">시작 시간</label>
            <input type="time" id="startTime" v-model="startTime" class="form-control" required min="2023-11-21" max="9999-12-31"/>

            <label for="endTime">종료 시간</label>
            <input type="time" id="endTime" v-model="endTime" class="form-control" required min="2023-11-21" max="9999-12-31"/>
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-md-6">
          <div class="input-group mb-3">
            <label for="newTitle">운동명</label>
            <input type="text" id="newTitle" v-model="newTitle" class="form-control" required />
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-md-6">
          <div class="input-group mb-3">
            <label for="newPart">부위</label>
            <select v-model="newPart" id="newPart" style="padding: 8px;">
              <option v-for="partOption in partOptions" :key="partOption" :value="partOption">
                {{ partOption }}
              </option>
            </select>
          </div>
        </div>
      </div>
      <button type="submit" class="btn" @click="addNewSchedule">운동 추가</button>
    </form>
    <hr>
    <div class="input-group mb-3">
      <button type="submit" class="btn" @click="submitSchedule">스케줄<br />전송</button>
      &nbsp &nbsp
      <button type="submit" class="btn" @click="modifySchedule">스케줄<br />수정</button>
      &nbsp &nbsp
      <button type="submit" class="btn" @click="deleteSchedule">스케줄<br />삭제</button>
    </div>
  </div>
</template>

<script setup>
import { useTrainerStore } from "../../stores/trainer";
import { ref, onMounted } from "vue";
import axios from "axios";

const trainerStore = useTrainerStore();

const pathName = new URL(document.location).pathname.split("/");
const id = pathName[pathName.length - 1];

onMounted(() => {
  getUserSchedule();
});

const newDay = ref("");
const newTime = ref("");
const newTitle = ref("");
const newPart = ref("");
const startTime = ref("");
const endTime = ref("");

const partOptions = [
  "유산소 운동",
  "가슴 운동(대흉근)",
  "어깨 운동(삼각근)",
  "복부 운동(복직근, 내복사근, 외복사근)",
  "등 운동(광배근, 승모근, 능형근)",
  "윗팔 운동/상완운동(상완이두근,상완삼두근)",
  "아랫팔 운동/전완운동(전완 굴곡근, 전완 신전근)",
  "허벅지 운동(대퇴부,슬굴곡근)",
  "종아리 운동(비복근, 가자미근)",
];

const schedule = ref([]);


const getUserSchedule = async () => {
  try {
    const response = await axios.get(
      `http://localhost:8080/api/product/schedule/${id}`
    );
    console.log(response)
    const jsonString = response.data.userSchedule;
    const parseOnce = JSON.parse(jsonString);
    const parse1Schedule = parseOnce.schedule;
    schedule.value = JSON.parse(parse1Schedule);
    console.log(schedule.value)
  } catch (error) {
    console.error("Error fetching user schedule:", error);
  }
};


const addNewSchedule = () => {
  console.log(startTime.value, " ", endTime.value)
  newTime.value = startTime.value + "~" + endTime.value
  if (newDay.value && newTime.value && newTitle.value) {
    const existingDay = schedule.value.find((day) => day.id === newDay.value);

    if (existingDay) {
      existingDay.items.push({
        time: newTime.value,
        title: newTitle.value,
        part: newPart.value,
      });
    } else {
      const newScheduleItem = {
        id: newDay.value,
        title: newDay.value,
        items: [{ time: newTime.value, title: newTitle.value, part: newPart.value }],
      };

      schedule.value.push(newScheduleItem);
    }

    newDay.value = "";
    newTime.value = "";
    newTitle.value = "";
    newPart.value = "";
  } else {
    alert("값을 전부 입력해주세요!");
  }
};

const modifyItem = (dayId, itemIndex) => {
  const modifiedTime = prompt('수정 시간', schedule.value.find(day => day.id === dayId)?.items[itemIndex].time);
  const modifiedTitle = prompt('수정 운동명', schedule.value.find(day => day.id === dayId)?.items[itemIndex].title);

  if (modifiedTime !== null && modifiedTitle !== null && modifiedTime.trim() !== '' && modifiedTitle.trim() !== '') {
    schedule.value.find(day => day.id === dayId).items[itemIndex].time = modifiedTime;
    schedule.value.find(day => day.id === dayId).items[itemIndex].title = modifiedTitle;
  }
};

const deleteItem = (dayId, itemIndex) => {
  const confirmDelete = confirm('운동을 삭제하시겠습니까? ');
  if (confirmDelete) {
    schedule.value.find(day => day.id === dayId).items.splice(itemIndex, 1);
  }
};

const submitSchedule = () => {
  const jsonString = JSON.stringify(schedule.value);
  trainerStore.registSchedule(id, jsonString)
};


const modifySchedule = () => {
  const jsonString = JSON.stringify(schedule.value);
  trainerStore.modifySchedule(id, jsonString)
}

const deleteSchedule = () => {
  trainerStore.deleteSchedule(id)
}

</script>

<style scoped>
label {
  display: inline-block;
}

.row {
  align-items: flex-start;
}
.btn {
  padding: 10px;
  border-color: solid black;
  background-color: rgb(136, 136, 136);
  /* 무채색 배경 */
  color: #fff;
  /* 흰색 텍스트 */
  border: none;
  cursor: pointer;
  margin-right: 10px;
  font: bold;
}

body {
  background-color: #eee;
  margin-top: 20px;
}

.list-timeline {
  margin: 0;
  padding: 5px 0;
  position: relative;
}

.list-timeline:before {
  width: 1px;
  background: #ccc;
  position: absolute;
  left: 6px;
  top: 0;
  bottom: 0;
  height: 100%;
  content: "";
}

.list-timeline .list-timeline-item {
  margin: 0;
  padding: 0;
  padding-left: 24px !important;
  position: relative;
}

.list-timeline .list-timeline-item:before {
  width: 12px;
  height: 12px;
  background: #fff;
  border: 2px solid #ccc;
  position: absolute;
  left: 0;
  top: 4px;
  content: "";
  border-radius: 100%;
  -webkit-transition: all 0.3 ease-in-out;
  transition: all 0.3 ease-in-out;
}

.list-timeline .list-timeline-item[data-toggle="collapse"] {
  cursor: pointer;
}

.list-timeline .list-timeline-item.active:before,
.list-timeline .list-timeline-item.show:before {
  background: #ccc;
}

.list-timeline.list-timeline-light .list-timeline-item.active:before,
.list-timeline.list-timeline-light .list-timeline-item.show:before,
.list-timeline.list-timeline-light:before {
  background: #f8f9fa;
}

.list-timeline .list-timeline-item.list-timeline-item-marker-middle:before {
  top: 50%;
  margin-top: -6px;
}

.list-timeline.list-timeline-light .list-timeline-item:before {
  border-color: #f8f9fa;
}

.list-timeline.list-timeline-grey .list-timeline-item.active:before,
.list-timeline.list-timeline-grey .list-timeline-item.show:before,
.list-timeline.list-timeline-grey:before {
  background: #e9ecef;
}

.list-timeline.list-timeline-grey .list-timeline-item:before {
  border-color: #e9ecef;
}

.list-timeline.list-timeline-grey-dark .list-timeline-item.active:before,
.list-timeline.list-timeline-grey-dark .list-timeline-item.show:before,
.list-timeline.list-timeline-grey-dark:before {
  background: #495057;
}

.list-timeline.list-timeline-grey-dark .list-timeline-item:before {
  border-color: #495057;
}

.list-timeline.list-timeline-primary .list-timeline-item.active:before,
.list-timeline.list-timeline-primary .list-timeline-item.show:before,
.list-timeline.list-timeline-primary:before {
  background: #55a79a;
}

.list-timeline.list-timeline-primary .list-timeline-item:before {
  border-color: #55a79a;
}

.list-timeline.list-timeline-primary-dark .list-timeline-item.active:before,
.list-timeline.list-timeline-primary-dark .list-timeline-item.show:before,
.list-timeline.list-timeline-primary-dark:before {
  background: #33635c;
}

</style>