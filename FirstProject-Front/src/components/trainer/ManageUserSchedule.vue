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
    <form @submit.prevent="addNewSchedule">
      <h4 class="mt-4 mb-3 text-dark op-8 font-weight-bold">Add New Schedule</h4>

      <label for="newDay">날짜 </label>
      <input type="text" id="newDay" v-model="newDay" required />

      <label for="newTime">시간 </label>
      <input type="text" id="newTime" v-model="newTime" required />

      <label for="newTitle">운동명 </label>
      <input type="text" id="newTitle" v-model="newTitle" required />

      <label for="newPart">부위 </label>
      <select v-model="newPart" id="newPart" required>
        <option v-for="partOption in partOptions" :key="partOption" :value="partOption">
          {{ partOption }}
        </option>
      </select>

      <button type="submit" class="btn btn-primary mt-2">스케줄 추가</button>
    </form>
    <form @submit.prevent="submitSchedule">
      <button type="submit" class="btn btn-primary mt-4">스케줄 전송</button>
    </form>
    <form @submit.prevent="modifySchedule">
      <button type="submit" class="btn btn-primary mt-4">스케줄 수정</button>
    </form>
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
  trainerStore.modifySchedule(id, jsonString)
};


const modifySchedule = () => {
  const jsonString = JSON.stringify(schedule.value);
  trainerStore.modifySchedule(id, jsonString)
}


</script>

<style scoped>
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

.list-timeline.list-timeline-primary-dark .list-timeline-item:before {
  border-color: #33635c;
}

.list-timeline.list-timeline-primary-faded .list-timeline-item.active:before,
.list-timeline.list-timeline-primary-faded .list-timeline-item.show:before,
.list-timeline.list-timeline-primary-faded:before {
  background: rgba(85, 167, 154, 0.3);
}

.list-timeline.list-timeline-primary-faded .list-timeline-item:before {
  border-color: rgba(85, 167, 154, 0.3);
}

.list-timeline.list-timeline-info .list-timeline-item.active:before,
.list-timeline.list-timeline-info .list-timeline-item.show:before,
.list-timeline.list-timeline-info:before {
  background: #17a2b8;
}

.list-timeline.list-timeline-info .list-timeline-item:before {
  border-color: #17a2b8;
}

.list-timeline.list-timeline-success .list-timeline-item.active:before,
.list-timeline.list-timeline-success .list-timeline-item.show:before,
.list-timeline.list-timeline-success:before {
  background: #28a745;
}

.list-timeline.list-timeline-success .list-timeline-item:before {
  border-color: #28a745;
}

.list-timeline.list-timeline-warning .list-timeline-item.active:before,
.list-timeline.list-timeline-warning .list-timeline-item.show:before,
.list-timeline.list-timeline-warning:before {
  background: #ffc107;
}

.list-timeline.list-timeline-warning .list-timeline-item:before {
  border-color: #ffc107;
}

.list-timeline.list-timeline-danger .list-timeline-item.active:before,
.list-timeline.list-timeline-danger .list-timeline-item.show:before,
.list-timeline.list-timeline-danger:before {
  background: #dc3545;
}

.list-timeline.list-timeline-danger .list-timeline-item:before {
  border-color: #dc3545;
}

.list-timeline.list-timeline-dark .list-timeline-item.active:before,
.list-timeline.list-timeline-dark .list-timeline-item.show:before,
.list-timeline.list-timeline-dark:before {
  background: #343a40;
}

.list-timeline.list-timeline-dark .list-timeline-item:before {
  border-color: #343a40;
}

.list-timeline.list-timeline-secondary .list-timeline-item.active:before,
.list-timeline.list-timeline-secondary .list-timeline-item.show:before,
.list-timeline.list-timeline-secondary:before {
  background: #6c757d;
}

.list-timeline.list-timeline-secondary .list-timeline-item:before {
  border-color: #6c757d;
}

.list-timeline.list-timeline-black .list-timeline-item.active:before,
.list-timeline.list-timeline-black .list-timeline-item.show:before,
.list-timeline.list-timeline-black:before {
  background: #000;
}

.list-timeline.list-timeline-black .list-timeline-item:before {
  border-color: #000;
}

.list-timeline.list-timeline-white .list-timeline-item.active:before,
.list-timeline.list-timeline-white .list-timeline-item.show:before,
.list-timeline.list-timeline-white:before {
  background: #fff;
}

.list-timeline.list-timeline-white .list-timeline-item:before {
  border-color: #fff;
}

.list-timeline.list-timeline-green .list-timeline-item.active:before,
.list-timeline.list-timeline-green .list-timeline-item.show:before,
.list-timeline.list-timeline-green:before {
  background: #55a79a;
}

.list-timeline.list-timeline-green .list-timeline-item:before {
  border-color: #55a79a;
}

.list-timeline.list-timeline-red .list-timeline-item.active:before,
.list-timeline.list-timeline-red .list-timeline-item.show:before,
.list-timeline.list-timeline-red:before {
  background: #be3e1d;
}

.list-timeline.list-timeline-red .list-timeline-item:before {
  border-color: #be3e1d;
}

.list-timeline.list-timeline-blue .list-timeline-item.active:before,
.list-timeline.list-timeline-blue .list-timeline-item.show:before,
.list-timeline.list-timeline-blue:before {
  background: #00adbb;
}

.list-timeline.list-timeline-blue .list-timeline-item:before {
  border-color: #00adbb;
}

.list-timeline.list-timeline-purple .list-timeline-item.active:before,
.list-timeline.list-timeline-purple .list-timeline-item.show:before,
.list-timeline.list-timeline-purple:before {
  background: #b771b0;
}

.list-timeline.list-timeline-purple .list-timeline-item:before {
  border-color: #b771b0;
}

.list-timeline.list-timeline-pink .list-timeline-item.active:before,
.list-timeline.list-timeline-pink .list-timeline-item.show:before,
.list-timeline.list-timeline-pink:before {
  background: #cc164d;
}

.list-timeline.list-timeline-pink .list-timeline-item:before {
  border-color: #cc164d;
}

.list-timeline.list-timeline-orange .list-timeline-item.active:before,
.list-timeline.list-timeline-orange .list-timeline-item.show:before,
.list-timeline.list-timeline-orange:before {
  background: #e67e22;
}

.list-timeline.list-timeline-orange .list-timeline-item:before {
  border-color: #e67e22;
}

.list-timeline.list-timeline-lime .list-timeline-item.active:before,
.list-timeline.list-timeline-lime .list-timeline-item.show:before,
.list-timeline.list-timeline-lime:before {
  background: #b1dc44;
}

.list-timeline.list-timeline-lime .list-timeline-item:before {
  border-color: #b1dc44;
}

.list-timeline.list-timeline-blue-dark .list-timeline-item.active:before,
.list-timeline.list-timeline-blue-dark .list-timeline-item.show:before,
.list-timeline.list-timeline-blue-dark:before {
  background: #34495e;
}

.list-timeline.list-timeline-blue-dark .list-timeline-item:before {
  border-color: #34495e;
}

.list-timeline.list-timeline-red-dark .list-timeline-item.active:before,
.list-timeline.list-timeline-red-dark .list-timeline-item.show:before,
.list-timeline.list-timeline-red-dark:before {
  background: #a10f2b;
}

.list-timeline.list-timeline-red-dark .list-timeline-item:before {
  border-color: #a10f2b;
}

.list-timeline.list-timeline-brown .list-timeline-item.active:before,
.list-timeline.list-timeline-brown .list-timeline-item.show:before,
.list-timeline.list-timeline-brown:before {
  background: #91633c;
}

.list-timeline.list-timeline-brown .list-timeline-item:before {
  border-color: #91633c;
}

.list-timeline.list-timeline-cyan-dark .list-timeline-item.active:before,
.list-timeline.list-timeline-cyan-dark .list-timeline-item.show:before,
.list-timeline.list-timeline-cyan-dark:before {
  background: #008b8b;
}

.list-timeline.list-timeline-cyan-dark .list-timeline-item:before {
  border-color: #008b8b;
}

.list-timeline.list-timeline-yellow .list-timeline-item.active:before,
.list-timeline.list-timeline-yellow .list-timeline-item.show:before,
.list-timeline.list-timeline-yellow:before {
  background: #d4ac0d;
}

.list-timeline.list-timeline-yellow .list-timeline-item:before {
  border-color: #d4ac0d;
}

.list-timeline.list-timeline-slate .list-timeline-item.active:before,
.list-timeline.list-timeline-slate .list-timeline-item.show:before,
.list-timeline.list-timeline-slate:before {
  background: #5d6d7e;
}

.list-timeline.list-timeline-slate .list-timeline-item:before {
  border-color: #5d6d7e;
}

.list-timeline.list-timeline-olive .list-timeline-item.active:before,
.list-timeline.list-timeline-olive .list-timeline-item.show:before,
.list-timeline.list-timeline-olive:before {
  background: olive;
}

.list-timeline.list-timeline-olive .list-timeline-item:before {
  border-color: olive;
}

.list-timeline.list-timeline-teal .list-timeline-item.active:before,
.list-timeline.list-timeline-teal .list-timeline-item.show:before,
.list-timeline.list-timeline-teal:before {
  background: teal;
}

.list-timeline.list-timeline-teal .list-timeline-item:before {
  border-color: teal;
}

.list-timeline.list-timeline-green-bright .list-timeline-item.active:before,
.list-timeline.list-timeline-green-bright .list-timeline-item.show:before,
.list-timeline.list-timeline-green-bright:before {
  background: #2ecc71;
}

.list-timeline.list-timeline-green-bright .list-timeline-item:before {
  border-color: #2ecc71;
}
</style>
