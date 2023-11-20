<template>
  <div>
    <h2>FIT-NECT</h2>
    <RouterView />
  </div>
</template>

<script setup>
import { RouterView } from "vue-router";
</script>

<style scoped>

h1 {
  font-size: 2.5rem;
  text-align: center;
  margin-bottom: 30px;
}
</style>
    <div>
        <h2>Service View</h2>
        <router-view />
    </div>
</template>

<script setup></script>

<style scoped>
.video-management-page {
    max-width: 800px;
    margin: auto;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    background-color: #fff;
}

h1 {
    font-size: 2.5rem;
    text-align: center;
    margin-bottom: 30px;
}
</style>
  
