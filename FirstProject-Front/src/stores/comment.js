import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { defineStore } from 'pinia'
import axios from "axios"; 

export const useCommentStore = defineStore('comment', ()=>{
    
    const router = useRouter(); 
    const comment = ref([]); 

    //댓글 등록 
    const createComment = (comment) => {
        const API_URL = `http://localhost:8080/api/comment`;
        axios({
          url: API_URL,
          method: "POST",
          data: {
            coSeq: comment.commentSeq,
            coBoardId: comment.boardId,
            coUserId: comment.userId,
            coComment: comment.comment,
            coCreatedAt: comment.createdAt
          },
        })
          .then(() => {
            alert("등록 완료");
            // router.push("/board");
          })
          .catch((err) => {
            console.log(err);
          });
      };

      //한 게시글에서의 댓글 전부 조회
    const getCommentBoardList = () => {
    const API_URL = "http://localhost:8080/api/comment/user/${userId}";
    axios({
      url: API_URL,
      method: "GET",
    })
      .then((res) => {
        comment.value = res.data;
        console.log(comment)
      })
      .catch((err) => {
        console.log(err);
      });
  };





    return { comment, createComment, getCommentBoardList}



})