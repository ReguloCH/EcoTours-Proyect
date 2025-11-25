<template>
  <div class="pagina-viajes">
    <menuPrincipal1 />

    <section class="formulario-pago">

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

      <!-- DATOS DEL PAQUETE -->
      <div class="form-section">
        <h3>Datos del Paquete</h3>

        <label>Origen:</label>
        <input type="text" v-model="form.origen" readonly />

        <label>Destino:</label>
        <input type="text" v-model="form.destino" readonly />

        <label>Aerolínea:</label>
        <input type="text" v-model="form.aerolinea" readonly />

        <label>Hotel:</label>
        <input type="text" v-model="form.hotel" readonly />

        <label>Fecha inicio:</label>
        <input type="text" v-model="form.fechaInicio" readonly />

        <label>Fecha fin:</label>
        <input type="text" v-model="form.fechaFin" readonly />
      </div>

      <!-- DATOS DEL PAGO -->
      <div class="form-section">
        <h3>Datos del Pago</h3>

        <label>Precio del paquete:</label>
        <input type="text" :value="'USD ' + form.precio" readonly />

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
      form: {
        cedula: "",
        nombre: "",
        apellido: "",
        direccion: "",
        origen: "",
        destino: "",
        aerolinea: "",
        hotel: "",
        fechaInicio: "",
        fechaFin: "",
        precio: 0,
        personas: 1,
        metodoPago: "",
      },
    };
  },

  computed: {
    totalPagar() {
      return this.form.precio * this.form.personas;
    },
  },

  created() {
    const q = this.$route.query;

    this.form.origen = q.origen;
    this.form.destino = q.destino;
    this.form.aerolinea = q.aerolinea;
    this.form.hotel = q.hotel;
    this.form.fechaInicio = q.fechaInicio;
    this.form.fechaFin = q.fechaFin;
    this.form.precio = Number(q.precio);
  },

  methods: {
    enviarFormulario() {
      alert(`✅ Reserva confirmada para ${this.form.nombre}.
Destino: ${this.form.destino}
Total: USD ${this.totalPagar}`);
    },
  },
};
</script>
