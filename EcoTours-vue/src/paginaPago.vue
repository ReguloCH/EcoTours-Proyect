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
        <div
          v-for="(vuelo, index) in vuelos"
          :key="index"
          class="card"
        >
          <img :src="vuelo.imagen" :alt="vuelo.destino" />
          <div class="info">
            <h3>{{ vuelo.origen }} a {{ vuelo.destino }}</h3>
            <p>{{ vuelo.fechaInicio }} - {{ vuelo.fechaFin }}</p>
            <p class="precio">USD {{ vuelo.precio }}</p>
            <button class="btn-reservar" @click="seleccionarVuelo(vuelo)">
              Reservar ahora
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- este es el formulario del registro de pago -->
    <section v-if="vueloSeleccionado" class="formulario-pago">
      <h2>Registro de Pago</h2>

      <!-- DATOS PERSONALES -->
      <div class="form-section">
        <h3>Datos Personales</h3>
        <label>Cédula:</label>
        <input v-model="form.cedula" type="text" placeholder="Ej: V-12345678" />

        <label>Nombre:</label>
        <input v-model="form.nombre" type="text" placeholder="Nombre" />

        <label>Apellido:</label>
        <input v-model="form.apellido" type="text" placeholder="Apellido" />

        <label>Dirección:</label>
        <input v-model="form.direccion" type="text" placeholder="Dirección completa" />
      </div>

      <!-- datos del paquete de viajes -->
      <div class="form-section">
        <h3>Datos del Paquete</h3>
        <label>Destino:</label>
        <input type="text" v-model="form.destino" readonly />

        <label>Aerolínea:</label>
        <input type="text" v-model="form.aerolinea" readonly />

        <label>Hotel/Posada:</label>
        <input type="text" v-model="form.hotel" readonly />

        <label>Fecha inicio:</label>
        <input type="text" v-model="form.fechaInicio" readonly />

        <label>Fecha fin:</label>
        <input type="text" v-model="form.fechaFin" readonly />
      </div>

      <!-- aca van los datos del pago -->
      <div class="form-section">
        <h3>Datos del Pago</h3>
        <label>Precio del paquete:</label>
        <input type="text" :value="'USD ' + vueloSeleccionado.precio" readonly />

        <label>Cantidad de personas:</label>
        <input v-model.number="form.personas" type="number" min="1" />

        <label>Total a pagar:</label>
        <input type="text" :value="'USD ' + totalPagar" readonly />

        <label>Método de pago:</label>
        <select v-model="form.metodoPago">
          <option disabled value="">Seleccione un método</option>
          <option>Transferencia Bancaria</option>
          <option>Pago Móvil</option>
          <option>Tarjeta de Crédito</option>
          <option>PayPal</option>
        </select>
      </div>

      <button class="btn-enviar" @click="enviarFormulario">Confirmar Reserva</button>
    </section>

    <FooterIni />
  </div>
</template>

<script>
import menuPrincipal1 from "./components/menuPrincipal1.vue";
import FooterIni from "./components/footerIni.vue";


export default {
  name: "paginaPago",
  components: { menuPrincipal1, FooterIni },

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
