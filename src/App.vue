<template>
  <div id="app">
       <router-view></router-view>

  </div>


</template>

<script>

import pagPrincipal1 from './pagPrincipal1.vue'; 
import QuienesSomos from './quienesSomos.vue';
export default {
  name: 'App',
  components: {
    pagPrincipal1
  }
}
</script>
