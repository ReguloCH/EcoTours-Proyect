<template>
<div>
    <menu_ADMIN />
    
    
    <Footer_Cliente />

</div>
</template>
<script>
import menu_ADMIN from './components/menu_ADMIN.vue';
import Footer_Cliente from './components/Footer_Cliente.vue';

export default {
    // 2. El nombre del componente
    name: 'proveedoresADMIN',
    
    // 3. Los componentes usados (menú)
    components: {
        menu_ADMIN ,
        Footer_Cliente
    },
    
  
};
</script>

<style>

</style>