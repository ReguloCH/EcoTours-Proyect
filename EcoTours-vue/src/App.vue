<template>
  <div id="app">
       <router-view></router-view>
  </div>
</template>

<script>
import Inicio from './Inicio.vue';
import pagPrincipal1 from './pagPrincipal1.vue'; 
import quienesSomos from './quienesSomos.vue';
import contactanos from './contactanos.vue';  
export default {
  name: 'App',
  components: {
    Inicio,
    pagPrincipal1,
    quienesSomos,
    contactanos
  }
}
</script>
