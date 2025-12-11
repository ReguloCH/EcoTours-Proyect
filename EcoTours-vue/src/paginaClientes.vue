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


    <!-- Sección de ofertas -->
    <section class="ofertas mb-5">
      <div class="container">
        <div class="row mb-4 text-center">
          <div class="col-12">
            <h2>Mejores ofertas desde Venezuela</h2>
          </div>
        </div>

        <div class="row g-4 justify-content-center">
          <div class="col-lg-3 col-md-4 col-sm-6">
            <div class="card h-100 shadow-sm">
              <img src="/img/losROQUES.jpg" alt="Destino 1" class="card-img-top" />
              <div class="info p-3 text-center">
                <h3>Caracas (CCS) a Los Roques</h3>
                <p>oct 19, 2025 - oct 23, 2025</p>
                <p class="precio">USD 500*</p>
                <button class="btn-reservar" @click="PaginaPago">Reservar ahora</button>
              </div>
            </div>
          </div>

          <div class="col-lg-3 col-md-4 col-sm-6">
           <div class="card h-100 shadow-sm">
              <img src="/img/vuelo-Caracas-Santiagoch.webp" alt="Destino 2" class="card-img-top" />
              <div class="info p-3 text-center">
                <h3>Caracas (CCS) a Santiago de Chile (SCL)</h3>
                <p>nov 13, 2025 - nov 21, 2025</p>
                <p class="precio">USD 790*</p>
                <button class="btn-reservar" @click="PaginaPago">Reservar ahora</button>
              </div>
            </div>
          </div>

          <div class="col-lg-3 col-md-4 col-sm-6">
            <div class="card h-100 shadow-sm">
              <img src="/img/vuelo-Caracas-Lima.jpg" alt="Destino 3" class="card-img-top" />
              <div class="info p-3 text-center">
                <h3>Caracas (CCS) a Lima (LIM)</h3>
                <p>feb 01, 2026 - feb 17, 2026</p>
                <p class="precio">USD 750*</p>
                <button class="btn-reservar" @click="PaginaPago">Reservar ahora</button>
              </div>
            </div>
          </div>

          <div class="col-lg-3 col-md-4 col-sm-6">
            <div class="card h-100 shadow-sm">
              <img src="/img/vuelo-Caracas-Cdmx.jpg" alt="Destino 4" class="card-img-top" />
              <div class="info p-3 text-center">
                <h3>Caracas (CCS) a México - Ciudad (MEX)</h3>
                <p>dic 15, 2025 - ene 05, 2026</p>
                <p class="precio">USD 791*</p>
                <button type="button" class="btn-reservar" @click="PaginaPago">
  Reservar ahora
</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>


    <Footer_Cliente />
  </div>
</template>

<script>
import menuPrincipal1 from "./components/menuPrincipal1.vue";
import Footer_Cliente from "./components/Footer_Cliente.vue";
import PaginaPago from "./paginaPago.vue";
import axios from "axios";

export default {
  name: "paginaClientes",

  components: {
    menuPrincipal1,
    Footer_Cliente,
  },

  data() {
    return {
      vuelos: [],
    };
  },

  mounted() {
    this.cargarPaquetes();
  },

  methods: {
    async cargarPaquetes() {
      try {
        const res = await axios.get("http://localhost:3000/api/paquete-turistico");
        // Mapear respuesta del backend al formato visual
        this.vuelos = res.data.map(p => ({
            id: p.id_paquete,
            origen: "Caracas", // Default
            destino: p.destino_paquete,
            fechaInicio: this.formatDate(new Date()), // Default a hoy
            fechaFin: this.formatDate(new Date(Date.now() + 5 * 86400000)), // +5 dias
            precio: parseFloat(p.total_con_iva),
            aerolinea: "Copa Airlines", // Default o buscar de p.id_tarifa_aerolinea
            hotel: "Hotel Estándar", // Default
            imagen: "/img/losROQUES.jpg" // Default
        }));
      } catch (error) {
        console.error("Error cargando paquetes:", error);
      }
    },

    formatDate(date) {
        return date.toLocaleDateString("es-ES", { day: 'numeric', month: 'short', year: 'numeric' });
    },

    irAPago(vuelo) {
      this.$router.push({
        name: "paginaPago",
        query: {
          idPaquete: vuelo.id,
          origen: vuelo.origen,
          destino: vuelo.destino,
          precio: vuelo.precio,
          // Convertir fechas a YYYY-MM-DD para input type=date
          fechaInicio: new Date().toISOString().split('T')[0], 
          fechaFin: new Date(Date.now() + 5 * 86400000).toISOString().split('T')[0]
        },
      });
    },

    PaginaPago() {
       // Placeholder generico
       this.$router.push({ name: 'paginaPago' });
    },
  },
}
</script>
