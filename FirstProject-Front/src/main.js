import { createApp } from 'vue'
import { createPinia } from 'pinia'
import router from './router'
import axios from "axios";
import App from './App.vue'
import 'vuetify/dist/vuetify.min.css'

import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap/dist/js/bootstrap.js"
import "bootstrap-icons/font/bootstrap-icons.css"
import 'bootstrap-vue/dist/bootstrap-vue.css'

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.config.globalProperties.$axios = axios;

app.mount('#app')

// kakao 로그인
window.Kakao.init("46e60c693adfb731063ad4f459c80b2f");
