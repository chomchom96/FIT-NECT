import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { defineStore } from 'pinia'
import axios from "axios"; 

export const useCommentStore = defineStore('comment', ()=>{
    
    const router = useRouter(); 
    const comment = ref([]); 

    //댓글 리스트 전체 조회
    const getCommentList = () => {
      const API_URL = "http://localhost:8080/api/comment";
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


    //댓글 등록 
    const createComment = (comment) => {
      // console.log(comment.boardId)
        const API_URL = `http://localhost:8080/api/comment`;
        axios({
          url: API_URL,
          method: "POST",
          data: {
            boardId: comment.boardId,
            userId: comment.userId,
            comment: comment.comment,
            createdAt: comment.createAt,
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

      const createCommentPromise = (comment) => {

        return new Promise((resolve, reject)=>{
           // console.log(comment.boardId)
           const API_URL = `http://localhost:8080/api/comment`;
           axios({
             url: API_URL,
             method: "POST",
             data: {
               boardId: comment.boardId,
               userId: comment.userId,
               comment: comment.comment,
               createdAt: comment.creatAt,
             },
           })
             .then(() => {
               resolve();
               // router.push("/board");
             })
             .catch((err) => {
               console.log(err);
               reject();
             });
        })




       
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

  //댓글 수정
  const modifyCommentPromise = (commentSeq, newContent) => {

    return new Promise((resolve, reject)=>{
       // console.log(comment.boardId)
       const API_URL = `http://localhost:8080/api/comment`;
       axios({
         url: API_URL,
         method: "PUT",
         data: {
           commentSeq: commentSeq,
           boardId: comment.boardId,
           userId: comment.userId,
           comment: newContent,
           createdAt: comment.createAt,
         },
       })
         .then(() => {
           resolve();
           // router.push("/board");
         })
         .catch((err) => {
           console.log(err);
           reject();
         });
    })




   
};

    //댓글 삭제 
  const deleteComment = (commentSeq) => {

    const API_URL = `http://localhost:8080/api/comment/${commentSeq}`;
    // axios 요청 (Spring Boot Rest API 참고)
    axios({
      url: API_URL,
      method: "DELETE",
    })
      .then(() => {
        alert("삭제 완료");
        // getBoardList();
        // router.push("/board");
      })
      .catch((err) => {
        console.log(err);
      });
  };

  const deleteCommentPromise = (commentSeq) => {
  return new Promise((resolve, reject)=>{
    const API_URL = `http://localhost:8080/api/comment/${commentSeq}`;
    
    // axios 요청 (Spring Boot Rest API 참고)
    axios({
      url: API_URL,
      method: "DELETE",
    })
      .then(() => {
        resolve(); 
        // getBoardList();
        // router.push("/board");
      })
      .catch((err) => {
        reject(); 
        console.log(err);
      });
    })
  };

  

  onMounted(() => {
    getCommentList();
  });



    return { comment, getCommentList, modifyCommentPromise, deleteCommentPromise, deleteComment, createComment, createCommentPromise, getCommentBoardList}



})