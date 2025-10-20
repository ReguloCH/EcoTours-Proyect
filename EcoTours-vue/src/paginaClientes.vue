<template>
  <div class="pagina-viajes">
<<<<<<< HEAD

    <menuPrincipal1 />
=======
<<<<<<< HEAD

    <menuPrincipal1 />
=======
    <menuPrincipal1 />

>>>>>>> b8b6183ac643900511c1e32c3c6022570293a287
>>>>>>> a64750d393ad8c7b0c18ade6a3094136a5cd493d
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
<<<<<<< HEAD
        <!-- Card de destino -->
        <div class="card">
          <img src="/img/losROQUES.jpg" alt="Destino 1" />
          <div class="info">
            <h3>Caracas (CCS) a Los Roques </h3>
            <p>oct 19, 2025 - oct 23, 2025</p>
            <p class="precio">USD 500*</p>
=======
<<<<<<< HEAD
        <!-- Card de destino -->
        <div class="card">
          <img src="/img/vueloCaracas-Panama.webp" alt="Destino 1" />
          <div class="info">
            <h3>Caracas (CCS) a Panamá (PTY)</h3>
            <p>ene 22, 2026 - ene 27, 2026</p>
            <p class="precio">USD 539*</p>
>>>>>>> a64750d393ad8c7b0c18ade6a3094136a5cd493d
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
<<<<<<< HEAD
=======
=======
        <div class="card" v-for="(oferta, index) in ofertas" :key="index">
          <img :src="oferta.imagen" :alt="oferta.destino" />
          <div class="info">
            <h3>{{ oferta.titulo }}</h3>
            <p>{{ oferta.fecha }}</p>
            <p class="precio">{{ oferta.precio }}</p>
            <!-- 👇 redirección al hacer clic -->
            <button class="btn-reservar" @click="irAPago(oferta)">Reservar ahora</button>
>>>>>>> b8b6183ac643900511c1e32c3c6022570293a287
>>>>>>> a64750d393ad8c7b0c18ade6a3094136a5cd493d
          </div>
        </div>
      </div>
    </section>
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======

>>>>>>> b8b6183ac643900511c1e32c3c6022570293a287
>>>>>>> a64750d393ad8c7b0c18ade6a3094136a5cd493d
    <FooterIni />
  </div>
</template>

<script>
<<<<<<< HEAD

=======
<<<<<<< HEAD

=======
>>>>>>> b8b6183ac643900511c1e32c3c6022570293a287
>>>>>>> a64750d393ad8c7b0c18ade6a3094136a5cd493d
import menuPrincipal1 from './components/menuPrincipal1.vue';
import FooterIni from './components/footerIni.vue';

export default {
  name: "paginaClientes",
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> a64750d393ad8c7b0c18ade6a3094136a5cd493d

  components: {
        menuPrincipal1 ,
        FooterIni
    },
<<<<<<< HEAD
=======
=======
  components: { menuPrincipal1, FooterIni },

  data() {
    return {
      ofertas: [
        {
          titulo: "Caracas (CCS) a Panamá (PTY)",
          fecha: "Ene 22, 2026 - Ene 27, 2026",
          precio: "USD 539*",
          imagen: "/img/vueloCaracas-Panama.webp",
        },
        {
          titulo: "Caracas (CCS) a Santiago de Chile (SCL)",
          fecha: "Nov 13, 2025 - Nov 21, 2025",
          precio: "USD 790*",
          imagen: "/img/vuelo-Caracas-Santiagoch.webp",
        },
        {
          titulo: "Caracas (CCS) a Lima (LIM)",
          fecha: "Feb 01, 2026 - Feb 17, 2026",
          precio: "USD 750*",
          imagen: "/img/vuelo-Caracas-Lima.jpg",
        },
        {
          titulo: "Caracas (CCS) a México - Ciudad (MEX)",
          fecha: "Dic 15, 2025 - Ene 05, 2026",
          precio: "USD 791*",
          imagen: "/img/vuelo-Caracas-Cdmx.jpg",
        },
      ],
    };
  },

  methods: {
    irAPago(oferta) {
      // Redirige al usuario a la página de pago
      this.$router.push("/pagina-pago");
    },
  },
>>>>>>> b8b6183ac643900511c1e32c3c6022570293a287
>>>>>>> a64750d393ad8c7b0c18ade6a3094136a5cd493d
};
</script>
