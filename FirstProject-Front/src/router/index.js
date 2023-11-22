import { createRouter, createWebHistory } from "vue-router";
import Home from "../views/HomeView.vue";
import Contact from "@/components/common/contact.vue";
import About from "@/components/common/about.vue";
import LoginForm from "@/components/LoginForm.vue";

import User from "../views/UserView.vue";
import UserList from "@/components/user/UserList.vue";
import UserSignup from "@/components/user/UserSignup.vue";
import UserInfo from "@/components/user/UserInfo.vue";
import UserInfoDetail from "@/components/user/UserInfoDetail.vue";
import UserSchedule from "@/components/user/UserSchedule.vue"
import UserManageFollow from "@/components/user/UserManageFollow.vue"
import ShowFollowUserSchedule from "@/components/user/ShowFollowUserSchedule.vue"
import UserFollow from "@/components/user/UserFollow.vue"

import Video from "../views/VideoView.vue"
import VideoList from "@/components/video/VideoList.vue"
import VideoRegist from "@/components/video/VideoRegist.vue"
import VideoDetail from "@/components/video/VideoDetail.vue"

import Board from "../views/BoardView.vue";
import BoardList from "@/components/board/BoardList.vue";
import BoardModify from "@/components/board/BoardModify.vue";
import BoardWrite from "@/components/board/BoardWrite.vue";
import BoardDetail from "@/components/board/BoardDetail.vue";

import Service from "@/views/ServiceView.vue"
import ChooseTrainer from "@/components/service/ChooseTrainer.vue"
import Trainer from "../views/TrainerView.vue"
import TrainerList from "@/components/trainer/TrainerList.vue"
import TrainerDetail from "@/components/trainer/TrainerDetail.vue"
import TrainerShow from "@/components/trainer/TrainerShow.vue"
import TrainerLoginForm from "@/components/TrainerLoginForm.vue"

import ManageUser from "@/components/trainer/ManageUser.vue"
import ManageUserSchedule from "@/components/trainer/ManageUserSchedule.vue"

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/contact",
    name: "contact",
    component: Contact,
  },
  {
    path: "/about",
    name: "about",
    component: About,
  },
  {
    path: "/login",
    name: "Login",
    component: LoginForm,
  },
  {
    path: "/userfollow",
    name: "UserFollow",
    component: UserFollow,
  },
  {
    path: "/service",
    component: Service,
    children: [
      {
        path: "trainers",
        name: "ChooseTrainer",
        component: ChooseTrainer,
      }
    ],
  },
  {
    path: "/users",
    component: User,
    children: [
      {
        path: "signup",
        name: "UserSignup",
        component: UserSignup,
      },
      {
        path: "",
        name: "UserList",
        component: UserList,
      },
      {
        path: "schedule",
        name: "UserSchedule",
        component : UserSchedule,
      },
      {
        path: "follow",
        name: "UserManageFollow",
        component : UserManageFollow,
      },
      {
        path: "follow/:id",  // Use a dynamic segment ":id" to capture the user ID
        name: "ShowFollowUserSchedule",
        component: ShowFollowUserSchedule,
        props: true,  // Allow the route to receive the ID as a prop
      }
    ],
  },
  {
    path: "/trainers",
    component: Trainer,
    children: [
      {
        path: "list",
        name: "TrainerList",
        component: TrainerList,
      },
      {
        path: "show",
        name: "TrainerShow",
        component: TrainerShow,
      },
      {
        path: ":id",
        name: "TrainerDetail",
        component: TrainerDetail,
      },
      {
        path: "login",
        name: "TrainerLogin",
        component: TrainerLoginForm,
      },
      {
        path: "manage",
        name: "ManageUser",
        component: ManageUser, 
      },
      {
        path: "manage/:id",
        name: "ManageUserSchedule",
        component: ManageUserSchedule,
      }
    ],
  },
  {
    path: "/myinfo",
    name: "UserInfo",
    component: UserInfo,
  },
  {
    path: "/mydetail",
    name: "UserInfoDetail",
    component: UserInfoDetail,
  },
  {
    path: "/board",
    component: Board,
    children: [
      {
        path: "write",
        name: "BoardWrite",
        component: BoardWrite,
      },
      {
        path: "modify/:id",
        name: "BoardModify",
        component: BoardModify,
      },
      {
        path: "",
        name: "BoardList",
        component: BoardList,
      },
      {
        path: ":id",
        name: "BoardDetail",
        component: BoardDetail,
      }
    ],
  },
  {
    path: "/video",
    name: "Video",
    component: Video,
    children: [
      {
        path: "",
        name: "VideoList",
        component: VideoList,
      },
      {
        path: "regist",
        name: "VideoRegist",
        component: VideoRegist,
      },
      {
        path: ":id",
        name: "VideoDetail",
        component: VideoDetail,
      },
     
    ],
  },
  
  
  
];

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

export default router;
