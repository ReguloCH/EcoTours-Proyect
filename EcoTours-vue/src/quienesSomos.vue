<template>
    <div class="pag-principal">
<!-- meti -->

    <menuPrincipal1 />
    <!-- a partir de aqui, vas a comenzar-->
     <section class="section-QuienesSomos">
        <h2 class="titulo-quienesSomos">QUIENES SOMOS</h2>
     </section>

    <div class="contenedor-padre">
     <section class="section-SobreNosotros">
        <div class="content-SobreNosotros">
              <h1 class="titulo-SobreNosotros">Sobre Nosotros</h1>
              <p class="parrafo-SobreNosotros">
                Somos una empresa familiar con más de 50 años de trayectoria en Venezuela. 
                Siempre nos hemos distinguido por ser la mejor opción a la hora de planificar un viaje.
                Con nuestro norte en la atención personalizada y en alianzas estratégicas
                para ofrecer el mejor servicio.  
                <br>
                <br>
                Nuestra mejor carta de presentación son nuestros clientes y la confianza que depositan 
                en nosotros. Contamos con personal altamente capacitado y con una sólida infraestructura operativa
                para brindar un servicio integral, que va desde el inicio de una idea, hasta el último 
                detalle del viaje o evento, ya qué nuestra misión gira en torno a la creencia de que viajar 
                debe de ser una experiencia placentera para todos nuestros pasajeros
            </p>
        </div>
        
     </section>

     <div class="content-imggrupo">
            
        </div>
    </div>

<div class="contenedor-padre2">
    <div class="content-imghistoria">
         
    </div>

    <div class="contenido-historia">
        <h1 class="titulo-historia">Nuestra Historia</h1>
        <p class="parrafo-historia">
             Nacida en 1970 de la visión del Sr. José Alberti, Turaser se ha consolidado como el tour
             operador líder en Venezuela con más de cinco décadas de experiencia. Herencia que sus hijos, 
             Alejandro y Eduardo Alberti, han honrado con dedicación, expandiendo la empresa y forjando alianzas 
             estratégicas para ofrecer un servicio de excelencia inigualable. Hoy en día, Turaser expande 
             sus horizontes hacia nuevos mercados en República Dominicana y Estados Unidos, llevando consigo 
             su pasión por los viajes y su compromiso inquebrantable con la satisfacción del cliente.
        </p>
    </div>
</div>



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