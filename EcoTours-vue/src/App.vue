<template>
  <div id="app">
       <router-view></router-view>

  </div>


</template>

<script>

import pagPrincipal1 from './pagPrincipal1.vue'; 
import quienesSomos from './quienesSomos.vue';
export default {
  name: 'App',
  components: {
    pagPrincipal1,
    quienesSomos
  }
}
</script>
