import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { defineStore } from 'pinia'
import axios from "axios";

export const useServiceStore = defineStore('service', () => {
  const gender = ref('');
  const age = ref(0);
  const height = ref(0);
  const currentWeight = ref(0);
  const targetWeight = ref(0);
  const preferredPlace = ref('');
  const comment = ref('');

  const updateDetail = (userDetail) => {
    gender.value = userDetail.gender;
    age.value = userDetail.age;
    height.value = userDetail.height;
    currentWeight.value = userDetail.currentWeight;
    targetWeight.value = userDetail.targetWeight;
    preferredPlace.value = userDetail.preferredPlace;
    comment.value = userDetail.comment;
  };

  const submitForm = () => {
    const formData = {
      gender: gender.value,
      age: age.value,
      height: height.value,
      currentWeight: currentWeight.value,
      targetWeight: targetWeight.value,
      preferredPlace: preferredPlace.value,
      comment: comment.value,
    };

    console.log('Submitted form data:', formData);

    gender.value = '';
    age.value = 0;
    height.value = 0;
    currentWeight.value = 0;
    targetWeight.value = 0;
    preferredPlace.value = '';
    comment.value = '';

  };

  return {
    gender,
    age,
    height,
    currentWeight,
    targetWeight,
    preferredPlace,
    comment,
    updateDetail,
    submitForm,
  };
});