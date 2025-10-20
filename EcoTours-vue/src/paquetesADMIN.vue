<template>
<div>
    <menu_ADMIN />
    
    
    <FooterIni />

</div>
</template>
<script>
import menu_ADMIN from './components/menu_ADMIN.vue';
import FooterIni from './components/footerIni.vue';

export default {
    // 2. El nombre del componente
    name: 'proveedoresADMIN',
    
    // 3. Los componentes usados (menú)
    components: {
        menu_ADMIN ,
        FooterIni
    },
    
  
};
</script>

<style>

</style>