<script>
import menuPrincipal1 from './components/menuPrincipal1.vue';
import FooterIni from './components/footerIni.vue';

export default {
  name: "paginaClientes",
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
};
</script>
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
        
        <div class="card" v-for="(oferta, index) in ofertas" :key="index">
          <img :src="oferta.imagen" :alt="oferta.destino" />
          <div class="info">
            <h3>{{ oferta.titulo }}</h3>
            <p>{{ oferta.fecha }}</p>
            <p class="precio">{{ oferta.precio }}</p>
            <!-- BOTÓN: navega a la página de pago -->
            <button class="btn-reservar" @click="irAPago(oferta)">Reservar ahora</button>
          </div>
        </div>
      </div>
    </section>

    <FooterIni />
  </div>
</template>
