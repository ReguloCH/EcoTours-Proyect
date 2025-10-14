<template>
  <!-- div para que todo el contenido de la vista quede con un margen -->
  <div class="pag-principal">

  <!-- Incluimos el primer componente, es el header, menu principal del modulo PUBLICO -->

<menuPrincipal1 />

<!-- luego, viene la imagen abajo del menu, con algo de texto -->


    
<section class="hero-section">
      <div class="hero-content">
        <h1 class="hero-title">Agencia de viajes EcoTours</h1>
        <p class="hero-subtitle">
¿Buscas una experiencia diferente para tu próximo destino? <br>
En EcoTours te ofrecemos paquetes turísticos completos que combinan aventura, confort y mucha diversion. <br>

¡Planifica tu próxima aventura con nosotros y vive el turismo de forma ecológica y responsable!        </p>
        </div>
    </section>

    
    <section class="other-section">
      <h2>Vuelos internacionales</h2>
      <p>Ya sea que busques aventura, relajación, historia o naturaleza, hay un vuelo internacional perfecto para ti. ¡Aprovecha esta oportunidad y reserva ya tu boleto al mejor precio!</p>
    </section>
  </div>
<div> 
  <!-- ahora, vienen los paquetes de viaje, son tarjetas con imagenes, algo de texto y un link para mas informacion-->

  

    <section class="packages-section">
      <h2 class="section-title">Nuestros Mejores Paquetes de Viaje</h2>
      <div class="cards-grid">
        <!-- PRIMERA COLUMNA-->

        
        <div class="package-card">
          <img src="/img/paquete1.jpg" alt="20 Mejores Lugares de España" class="card-image">
          <div class="card-info">
            <h3 class="card-title">DESCUBRE LOS 20 DESTINOS IMPERDIBLES DE ESPAÑA</h3>
            <p class="card-description">20 mejores lugares de España que debes visitar: desde las playas de Mallorca hasta la cultura de Bilbao. ¡Descubre tu próximo destino!</p>
            <a href="#" class="card-link">Leer más</a>
          </div>
        </div>

        <div class="package-card">
          <img src="/img/paquete2.jpg" alt="Mejores Playas de Alicante" class="card-image">
          <div class="card-info">
            <h3 class="card-title">DESCUBRE LAS PLAYAS MÁS BELLAS DE ALICANTE PARA 2025</h3>
            <p class="card-description">Explora las 10 mejores playas de Alicante en 2024. Ideales para relajarte, practicar deportes acuáticos y disfrutar de la gastronomía local.</p>
            <a href="#" class="card-link">Leer más</a>
          </div>
        </div>

        <div class="package-card">
          <img src="/img/paquete3.jpg" alt="Encantos de Ibiza" class="card-image">
          <div class="card-info">
            <h3 class="card-title">EXPLORA LOS ENCANTOS DE IBIZA: MÁS QUE SOLO FIESTA</h3>
            <p class="card-description">Ibiza, la joya del Mediterráneo, tiene para ofrecer: playas paradisíacas, deliciosa gastronomía y una rica cultura. ¡No te lo pierdas!</p>
            <a href="#" class="card-link">Leer más</a>
          </div>
        </div>
<!-- SEGUNDA COLUMNA, 3 PAQUETES MAS-->

        <div class="package-card">
          <img src="/img/paquete4.jpg" alt="Paquete 4" class="card-image">
          <div class="card-info">
            <h3 class="card-title">AVENTURA EN LOS ALPES SUIZOS: 7 DÍAS</h3>
            <p class="card-description">Vive la adrenalina en los picos nevados. Incluye alojamiento, comidas y guía de senderismo experto.</p>
            <a href="#" class="card-link">Leer más</a>
          </div>
        </div>
        <div class="package-card">
          <img src="/img/paquete5.jpg" alt="Paquete 5" class="card-image">
          <div class="card-info">
            <h3 class="card-title">RUTA CULTURAL POR ROMA Y FLORENCIA</h3>
            <p class="card-description">Un viaje inolvidable por el corazón de Italia. Visita el Coliseo, el Vaticano y la Galería Uffizi.</p>
            <a href="#" class="card-link">Leer más</a>
          </div>
        </div>
        <div class="package-card">
          <img src="/img/paquete6.jpg" alt="Paquete 6" class="card-image">
          <div class="card-info">
            <h3 class="card-title">ESCAPADA ROMÁNTICA AL CARIBE</h3>
            <p class="card-description">Playas de arena blanca y aguas turquesas. Paquete todo incluido con cenas románticas y actividades de buceo.</p>
            <a href="#" class="card-link">Leer más</a>
          </div>
        </div>
        <!-- TERCERA COLUMNA-->

        <div class="package-card">
          <img src="/img/paquete7.jpg" alt="Paquete 7" class="card-image">
          <div class="card-info">
            <h3 class="card-title">SAFARI EN KENIA: VIDA SALVAJE</h3>
            <p class="card-description">Observa los "Cinco Grandes" en su hábitat natural. Alojamiento en tiendas de lujo y traslados privados.</p>
            <a href="#" class="card-link">Leer más</a>
          </div>
        </div>
        <div class="package-card">
          <img src="/img/paquete8.jpg" alt="Paquete 8" class="card-image">
          <div class="card-info">
            <h3 class="card-title">MARAVILLAS DEL PERÚ: MACHU PICCHU</h3>
            <p class="card-description">Recorrido por Cuzco y la Ciudad Perdida de los Incas. Incluye tren de lujo y guía especializado.</p>
            <a href="#" class="card-link">Leer más</a>
          </div>
        </div>
        <div class="package-card">
          <img src="/img/paquete9.jpg" alt="Paquete 9" class="card-image">
          <div class="card-info">
            <h3 class="card-title">RELAJACIÓN EN LOS FIORDOS NORUEGOS</h3>
            <p class="card-description">Descubre la belleza natural de Noruega. Incluye crucero por los fiordos y tour por Bergen.</p>
            <a href="#" class="card-link">Leer más</a>
          </div>
        </div>
      </div>
    </section>
    <!-- IMAGEN CON LOGO -->

    <section class="other-section">
      </section>
      </div>
      <section class="hero-section" style="background-image: url('/img/playaIni.jpg');">
    <div class="hero-content">
      <img src="/img/EcoToursLOGO.png" alt="EcoTours Logo" class="hero-logo">
      <h1 class="hero-title">Agencia de Viajes</h1>
      <p class="hero-subtitle">Descubre el mundo con nosotros</p>
      <a href="#" class="hero-button">Explora Destinos</a>
    </div>
  </section>
  <!-- COMPRA TU BOLETO EN 4 SENCILLOS PASOS, CON LOGO-->


  <section class="offers-carousel-section">
      </section>

  <section class="steps-section">
      </section>
      <section class="steps-section">
    <h2 class="section-title">Compra tu boleto en 4 sencillos pasos</h2>
    
    <div class="steps-container">
        
        <div class="step-card">
            <span class="step-icon step-icon-search">🔎</span>
            <h3 class="step-title">1. Busca tu Destino</h3>
            <p class="step-description">Usa nuestro buscador avanzado para encontrar las mejores ofertas de vuelos y hoteles.</p>
        </div>
        
        <div class="step-card">
            <span class="step-icon step-icon-book">📝</span>
            <h3 class="step-title">2. Reserva y Personaliza</h3>
            <p class="step-description">Selecciona tus fechas, asientos y servicios adicionales que deseas incluir en tu viaje.</p>
        </div>
        
        <div class="step-card">
            <span class="step-icon step-icon-pay">💳</span>
            <h3 class="step-title">3. Realiza el Pago</h3>
            <p class="step-description">Completa tu compra de forma rápida y segura con tu método de pago preferido.</p>
        </div>
        
        <div class="step-card">
            <span class="step-icon step-icon-fly">✈️</span>
            <h3 class="step-title">4. ¡A Disfrutar!</h3>
            <p class="step-description">Recibe tus boletos electrónicos y prepárate para vivir una experiencia inolvidable.</p>
        </div>
        
    </div>
</section> 
<!-- CARRUSEL DE IMAGENES-->
  <section class="offers-carousel-section">
    <h2 class="section-title">Pasajes en Oferta</h2>
    <p class="section-subtitle">¡Los mejores pasajes en oferta que tenemos son para ti! Podrás elegir entre destinos exóticos, culturales, históricos o naturales y disfrutar de una experiencia única e inolvidable. No esperes más y reserva tu pasaje hoy mismo.</p>
    
    <div class="carousel-container">
        
        
        
        <div class="carousel-slide" 
             v-if="currentSlide === 1" 
             style="background-image: url('/img/oferta1.jpg');">
            
        </div>
        
        <div class="carousel-slide" 
             v-if="currentSlide === 2" 
             style="background-image: url('/img/oferta2.jpg');">
             
        </div>
        
        <div class="carousel-slide" 
             v-if="currentSlide === 3" 
             style="background-image: url('/img/oferta3.jpg');">
             
        </div>

        <div class="carousel-slide" 
             v-if="currentSlide === 4" 
             style="background-image: url('/img/oferta4.jpg');">
             
        </div>

        <div class="carousel-slide" 
             v-if="currentSlide === 5" 
             style="background-image: url('/img/oferta5.jpg');">
             
        </div>

        <div class="carousel-slide" 
             v-if="currentSlide === 6" 
             style="background-image: url('/img/oferta6.jpg');">
             
        </div>
        
        <div class="carousel-dots">
            <span class="dot" :class="{ active: currentSlide === 1 }" @click="goToSlide(1)"></span>
            <span class="dot" :class="{ active: currentSlide === 2 }" @click="goToSlide(2)"></span>
            <span class="dot" :class="{ active: currentSlide === 3 }" @click="goToSlide(3)"></span>
            <span class="dot" :class="{ active: currentSlide === 4 }" @click="goToSlide(4)"></span>
            <span class="dot" :class="{ active: currentSlide === 5 }" @click="goToSlide(5)"></span>
            <span class="dot" :class="{ active: currentSlide === 6 }" @click="goToSlide(6)"></span>
        </div>

        <button class="carousel-nav-btn prev-btn" @click="prevSlide">
            &lt;
        </button>
        <button class="carousel-nav-btn next-btn" @click="nextSlide">
            &gt;
        </button>
    </div>
</section>
<!-- LLAMANDO AL OTRO COMPONENTE, EL FOOTERINI-->


<FooterIni />

</template>

<script>
//ESTE SCRIPT TIENE COMO FIN definir y controlar la lógica central dE ESTA VISTA, EXPLICA QUE OTROS COMPONENTES ESTAN INCLUIDOS, CONTIENE TAMBIEN LOGICA DEL CARRUSEL DE FOTOS
// 1. Los imports van primero
import menuPrincipal1 from './components/menuPrincipal1.vue';
import FooterIni from './components/footerIni.vue';

export default {
    // 2. El nombre del componente
    name: 'pagPrincipal1',
    
    // 3. Los componentes usados (menú)
    components: {
        menuPrincipal1 ,
        FooterIni
    },
    
    // 4. Los datos (la variable del carrusel)
    data() {
        return {
            currentSlide: 1, 
        };
    },
    
    // 5. Los métodos (la lógica del carrusel)
    methods: {
        prevSlide() {
            this.currentSlide = this.currentSlide === 1 ? 6 : this.currentSlide - 1;
        },
        nextSlide() {
            this.currentSlide = this.currentSlide === 6 ? 1 : this.currentSlide + 1;
        },
        goToSlide(index) {
            this.currentSlide = index;
        }
    }
};
</script>