<template>
  <div class="pagina-viajes d-flex flex-column min-vh-100">
    <menuPrincipal1 />

    <!-- Encabezado -->
    <header class="encabezado text-center my-4">
      <div class="container">
        <div class="row">
          <div class="col-12">
            <h1>Reserva las mejores ofertas de viaje</h1>
            <p>Encuentra las tarifas más bajas desde tu ciudad</p>
          </div>
        </div>
      </div>
    </header>

    <!-- Buscador -->
    <section class="buscador mb-5">
      <div class="container">
        <div class="row justify-content-center g-3">
          <div class="col-md-3 col-sm-6 campo">
            <label>Desde</label>
            <input type="text" placeholder="Ingrese ciudad o código de aeropuerto" />
          </div>

          <div class="col-md-3 col-sm-6 campo">
            <label>A</label>
            <input type="text" placeholder="Ingrese ciudad o código de aeropuerto" />
          </div>

          <div class="col-md-4 col-sm-8 campo">
            <label>Presupuesto</label>
            <div class="presupuesto d-flex align-items-center">
              <span class="me-2">USD</span>
              <input type="number" placeholder="Introduce presupuesto máximo" />
            </div>
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
                <button class="btn-reservar" @click="irAPago">Reservar ahora</button>
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
                <button class="btn-reservar" @click="irAPago">Reservar ahora</button>
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
                <button class="btn-reservar" @click="irAPago">Reservar ahora</button>
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
                <button type="button" class="btn-reservar" @click="irAPago">
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

export default {
  name: "paginaClientes",
  components: {
    menuPrincipal1,
    Footer_Cliente,
  },
  methods: {
    irAPago() {
      this.$router.push("/paginaPago");
    },
  },
};
</script>
