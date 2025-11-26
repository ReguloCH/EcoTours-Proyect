<template>
  <div class="pagina-pago d-flex flex-column min-vh-100">
    <!-- Menú principal -->
    <menuPrincipal1 />

    <!-- Contenedor principal -->
    <div class="container flex-grow-1 my-5">
      <div class="row justify-content-center">
        <div class="col-12 col-md-10 col-lg-8">
          <div class="pago-box p-4 rounded-4 shadow-lg">
            <h1 class="text-center mb-4">Página de Pago</h1>

            <div class="row mb-4">
              <div class="col-12 text-center">
                <p class="descripcion-pago">
                  Verifica tus datos y completa el pago de tu reserva
                </p>
              </div>
            </div>

            <!-- Formulario de pago -->
            <form @submit.prevent="procesarPago">
              <div class="row">
                <div class="col-md-6 mb-3 campo">
                  <label>Nombre del titular</label>
                  <input
                    v-model="pago.nombre"
                    type="text"
                    required
                    placeholder="Nombre completo"
                  />
                </div>

                <div class="col-md-6 mb-3 campo">
                  <label>Número de tarjeta</label>
                  <input
                    v-model="pago.tarjeta"
                    type="text"
                    required
                    maxlength="16"
                    placeholder="0000 0000 0000 0000"
                  />
                </div>

                <div class="col-md-4 mb-3 campo">
                  <label>Fecha de expiración</label>
                  <input
                    v-model="pago.expiracion"
                    type="text"
                    required
                    placeholder="MM/AA"
                  />
                </div>

                <div class="col-md-4 mb-3 campo">
                  <label>CVV</label>
                  <input
                    v-model="pago.cvv"
                    type="password"
                    required
                    maxlength="3"
                    placeholder="•••"
                  />
                </div>

                <div class="col-md-4 mb-3 campo">
                  <label>Monto a pagar</label>
                  <input
                    v-model="pago.monto"
                    type="number"
                    required
                    placeholder="$"
                  />
                </div>

                <div class="col-12 d-grid mt-4">
                  <button type="submit" class="btn-pagar">
                    Pagar ahora
                  </button>
                </div>

                <div class="col-12 text-center mt-3">
                  <button @click="cancelarPago" class="btn-cancelar">
                    Cancelar
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Footer -->
    <footerIni />
  </div>
</template>


<script>
import menuPrincipal1 from "./components/menuPrincipal1.vue";
import Footer_Cliente from "./components/Footer_Cliente.vue";


export default {
  name: "paginaPago",
  components: { menuPrincipal1, Footer_Cliente },

  data() {
    return {
      vuelos: [
        {
          origen: "Caracas (CCS)",
          destino: "Panamá (PTY)",
          fechaInicio: "Ene 22, 2026",
          fechaFin: "Ene 27, 2026",
          precio: 539,
          aerolinea: "Copa Airlines",
          hotel: "Hotel Panamá City",
          imagen: "/img/vueloCaracas-Panama.webp",
        },
        {
          origen: "Caracas (CCS)",
          destino: "Santiago de Chile (SCL)",
          fechaInicio: "Nov 13, 2025",
          fechaFin: "Nov 21, 2025",
          precio: 790,
          aerolinea: "Latam Airlines",
          hotel: "Hotel Andes Plaza",
          imagen: "/img/vuelo-Caracas-Santiagoch.webp",
        },
        {
          origen: "Caracas (CCS)",
          destino: "Lima (LIM)",
          fechaInicio: "Feb 01, 2026",
          fechaFin: "Feb 17, 2026",
          precio: 750,
          aerolinea: "Avianca",
          hotel: "Hotel Miraflores",
          imagen: "/img/vuelo-Caracas-Lima.jpg",
        },
        {
          origen: "Caracas (CCS)",
          destino: "México - Ciudad (MEX)",
          fechaInicio: "Dic 15, 2025",
          fechaFin: "Ene 05, 2026",
          precio: 791,
          aerolinea: "Aeroméxico",
          hotel: "Hotel Reforma Palace",
          imagen: "/img/vuelo-Caracas-Cdmx.jpg",
        },
      ],
      vueloSeleccionado: null,
      form: {
        cedula: "",
        nombre: "",
        apellido: "",
        direccion: "",
        destino: "",
        aerolinea: "",
        hotel: "",
        fechaInicio: "",
        fechaFin: "",
        personas: 1,
        metodoPago: "",
      },
    };
  },

  computed: {
    totalPagar() {
      return (this.vueloSeleccionado?.precio || 0) * (this.form.personas || 1);
    },
  },

  methods: {
    seleccionarVuelo(vuelo) {
      this.vueloSeleccionado = vuelo;
      this.form.destino = vuelo.destino;
      this.form.aerolinea = vuelo.aerolinea;
      this.form.hotel = vuelo.hotel;
      this.form.fechaInicio = vuelo.fechaInicio;
      this.form.fechaFin = vuelo.fechaFin;
    },
    enviarFormulario() {
      alert(`✅ Reserva confirmada para ${this.form.nombre} hacia ${this.form.destino}.
Total pagado: USD ${this.totalPagar}`);
    },
  },
};
</script>
