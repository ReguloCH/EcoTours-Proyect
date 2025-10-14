<template>
    <div class="pag-principal">
<!-- meti -->

    <menuPrincipal1 />
    <!-- a partir de aqui, vas a comenzar-->
     <p>QUIENES SOMOS VA AQUI</p>












    <!-- aqui se va a mostrar en la vista el footer entonces esta es la ultima parte del codigo-->
    <FooterIni />
    </div>
    

</template>



<script>
//ESTE SCRIPT TIENE COMO FIN definir y controlar la lógica central dE ESTA VISTA, EXPLICA QUE OTROS COMPONENTES ESTAN INCLUIDOS
// 1. Los imports van primero
import menuPrincipal1 from './components/menuPrincipal1.vue';
import FooterIni from './components/footerIni.vue';

export default {
    // 2. El nombre del componente
    name: 'quienesSomos',
    
    // 3. Los componentes usados (menú)
    components: {
        menuPrincipal1 ,
        FooterIni
    },
    
  
};
</script>