<template>
  <div class="pagina-viajes">

    <menuPrincipal1 />

    <header class="encabezado">
      <h1>Reserva las mejores ofertas de viaje</h1>
      <p>Encuentra las tarifas más bajas desde tu ciudad</p>
    </header>

    <section class="ofertas">
      <h2>Mejores ofertas desde Venezuela</h2>

      <div class="grid-ofertas">

        <div v-for="(vuelo, index) in vuelos" :key="index" class="card">
          <img :src="vuelo.imagen" :alt="vuelo.destino" />
          <div class="info">
            <h3>{{ vuelo.origen }} a {{ vuelo.destino }}</h3>
            <p>{{ vuelo.fechaInicio }} - {{ vuelo.fechaFin }}</p>
            <p class="precio">USD {{ vuelo.precio }}</p>

            <button class="btn-reservar" @click="irAPago(vuelo)">
              Reservar ahora
            </button>
          </div>
        </div>

      </div>
    </section>

    <FooterIni />
  </div>
</template>

<script>
import menuPrincipal1 from "./components/menuPrincipal1.vue";
import FooterIni from "./components/footerIni.vue";

export default {
  name: "paginaClientes",

  components: { menuPrincipal1, FooterIni },

  data() {
    return {
      vuelos: [
        {
          origen: "Caracas ",
          destino: "Los Roques ",
          fechaInicio: "Ene 22, 2026",
          fechaFin: "Ene 27, 2026",
          precio: 539,
          aerolinea: "Copa Airlines",
          hotel: "El Roques Club",
          imagen: "/img/losROQUES.jpg",
        },
        {
          origen: "Caracas ",
          destino: "Valencia",
          fechaInicio: "Nov 13, 2025",
          fechaFin: "Nov 21, 2025",
          precio: 790,
          aerolinea: "Latam Airlines",
          hotel: "Lidotel Valencia",
          imagen: "/img/valencia.jpg",
        },
        {
          origen: "Caracas ",
          destino: "Maracaibo",
          fechaInicio: "Feb 01, 2026",
          fechaFin: "Feb 17, 2026",
          precio: 750,
          aerolinea: "Avianca",
          hotel: "Hotel Maracaibo",
          imagen: "/img/maracaibo.jpg",
        },
        {
          origen: "Barquisimeto",
          destino: "Caracas ",
          fechaInicio: "Dic 15, 2025",
          fechaFin: "Ene 05, 2026",
          precio: 791,
          aerolinea: "Aeroméxico",
          hotel: "Hotel Eurobuilding",
          imagen: "/img/caracas.webp",
        },
      ],
    };
  },

  methods: {
    irAPago(vuelo) {
      this.$router.push({
        name: "paginaPago",
        query: {
          origen: vuelo.origen,
          destino: vuelo.destino,
          fechaInicio: vuelo.fechaInicio,
          fechaFin: vuelo.fechaFin,
          precio: vuelo.precio,
          aerolinea: vuelo.aerolinea,
          hotel: vuelo.hotel,
        },
      });
    },
  },
};
</script>
