<template>
  <div class="pagina-viajes">

    <menuPrincipal1 />
    <!-- Encabezado -->
    <header class="encabezado">
      <h1>Reserva las mejores ofertas de viaje</h1>
      <p>Encuentra las tarifas más bajas desde tu ciudad</p>
    </header>

    <!-- Buscador -->
    <section class="buscador">
      <div class="campo">
        <label>Desde</label>
        <input type="text" placeholder="Ingrese ciudad o código de aeropuerto" />
      </div>

      <div class="campo">
        <label>A</label>
        <input type="text" placeholder="Ingrese ciudad o código de aeropuerto" />
      </div>

      <div class="campo">
        <label>Presupuesto</label>
        <div class="presupuesto">
          <span>USD</span>
          <input type="number" placeholder="Introduce presupuesto máximo" />
        </div>
      </div>
    </section>

    <!-- Sección de ofertas -->
    <section class="ofertas">
      <h2>Mejores ofertas desde Venezuela</h2>

      <div class="grid-ofertas">
        <!-- Card de destino -->
        <div class="card">
          <img src="/img/vueloCaracas-Panama.webp" alt="Destino 1" />
          <div class="info">
            <h3>Caracas (CCS) a Panamá (PTY)</h3>
            <p>ene 22, 2026 - ene 27, 2026</p>
            <p class="precio">USD 539*</p>
            <button class="btn-reservar">Reservar ahora</button>
          </div>
        </div>

        <div class="card">
          <img src="/img/vuelo-Caracas-Santiagoch.webp" alt="Destino 2" />
          <div class="info">
            <h3>Caracas (CCS) a Santiago de Chile (SCL)</h3>
            <p>nov 13, 2025 - nov 21, 2025</p>
            <p class="precio">USD 790*</p>
            <button class="btn-reservar">Reservar ahora</button>
          </div>
        </div>

        <div class="card">
          <img src="/img/vuelo-Caracas-Lima.jpg" alt="Destino 3" />
          <div class="info">
            <h3>Caracas (CCS) a Lima (LIM)</h3>
            <p>feb 01, 2026 - feb 17, 2026</p>
            <p class="precio">USD 750*</p>
            <button class="btn-reservar">Reservar ahora</button>
          </div>
        </div>

        <div class="card">
          <img src="/img/vuelo-Caracas-Cdmx.jpg" alt="Destino 4" />
          <div class="info">
            <h3>Caracas (CCS) a México - Ciudad (MEX)</h3>
            <p>dic 15, 2025 - ene 05, 2026</p>
            <p class="precio">USD 791*</p>
            <button class="btn-reservar">Reservar ahora</button>
          </div>
        </div>
      </div>
    </section>
    <FooterIni />
  </div>
</template>

<script>

import menuPrincipal1 from './components/menuPrincipal1.vue';
import FooterIni from './components/footerIni.vue';

export default {
  name: "paginaClientes",

  components: {
        menuPrincipal1 ,
        FooterIni
    },
};
</script>
