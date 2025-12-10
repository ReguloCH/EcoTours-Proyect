<template>
<<<<<<< HEAD
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
=======
  <div class="pagina-pago d-flex flex-column min-vh-100">
    <menuPrincipal1 />

    <div class="container flex-grow-1 my-5">
      <div class="row justify-content-center">
        <div class="col-12 col-md-10 col-lg-8">
          <div class="pago-box formulario-pago p-4 rounded-4 shadow-lg">
            <h1 class="text-center mb-4">Confirmación de Reserva y Pago</h1>

            <form @submit.prevent="procesarPago">
              
              <h2 class="mb-3 mt-4 text-center">Detalles del Paquete</h2>
              <div class="row">
                
                <div class="col-md-6 mb-3 campo">
                  <label>Aerolínea</label>
                  <input type="text" :value="form.aerolinea || 'Copa Airlines'" readonly />
                </div>
                
                <div class="col-md-6 mb-3 campo">
                  <label>Hotel</label>
                  <input type="text" :value="form.hotel || 'El Roques Club'" readonly />
                </div>

                <div class="col-md-6 mb-3 campo">
                  <label>Fecha inicio</label>
                  <input type="date" v-model="form.fechaInicio" required />
                </div>

                <div class="col-md-6 mb-3 campo">
                  <label>Fecha fin</label>
                  <input type="date" v-model="form.fechaFin" required />
                </div>

                <div class="col-md-4 mb-3 campo">
                  <label>Precio del paquete</label>
                  <input type="text" :value="'USD ' + (vueloSeleccionado ? vueloSeleccionado.precio : 539)" readonly />
                </div>

                <div class="col-md-4 mb-3 campo">
                  <label>Cantidad de personas</label>
                  <input v-model.number="form.personas" type="number" required min="1" />
                </div>
                
                <div class="col-md-4 mb-3 campo">
                  <label>Total a pagar:</label>
                  <input type="text" :value="'USD ' + totalPagar" readonly class="precio" />
                </div>

              </div>
              
              <hr class="my-4" />
              
              <h2 class="mb-3 text-center">Datos del Cliente</h2>
              <div class="row">
                  
                  <div class="col-md-6 mb-3 campo">
                      <label>Cédula</label>
                      <input type="text" :value="cliente.cedula" readonly />
                  </div>
                  
                  <div class="col-md-6 mb-3 campo">
                      <label>Nombre</label>
                      <input type="text" :value="cliente.nombre" readonly />
                  </div>

                  <div class="col-md-6 mb-3 campo">
                      <label>Apellido</label>
                      <input type="text" :value="cliente.apellido" readonly />
                  </div>

                  <div class="col-md-6 mb-3 campo">
                      <label>Teléfono</label>
                      <input type="text" :value="cliente.telefono" readonly />
                  </div>
                  
                  <div class="col-12 mb-3 campo">
                      <label>Correo Electrónico</label>
                      <input type="text" :value="cliente.correo" readonly />
                  </div>
                  
              </div>
              <hr class="my-4" />
              <h2 class="mb-3 text-center">Datos del Pago</h2>
              
              <div class="row">
                
                <div class="col-12 mb-3 campo">
                  <label>Método de pago</label>
                  <select v-model="form.metodoPago" required>
                    <option value="" disabled>Seleccione un método</option>
                    <option value="pago-movil">Pago Móvil 📱</option>
                    <option value="transferencia">Transferencia Bancaria 🏦</option>
                  </select>
                </div>
                
                <template v-if="form.metodoPago === 'pago-movil'">
                  <div class="col-12 mt-3 mb-3 form-section">
                    <h3 class="text-start">Datos para Pago Móvil</h3>
                  </div>
                  <div class="col-md-6 mb-3 campo">
                    <label>Teléfono (Cédula/RIF)</label>
                    <input type="text" :value="datosPago.pagoMovil.telefono" readonly />
                  </div>
                  <div class="col-md-6 mb-3 campo">
                    <label>RIF / Cédula</label>
                    <input type="text" :value="datosPago.pagoMovil.rif" readonly />
                  </div>
                  <div class="col-12 mb-3 campo">
                    <label>Banco (Proveedor)</label>
                    <input type="text" :value="datosPago.pagoMovil.banco" readonly />
                  </div>
                  <div class="col-12 mb-3 campo">
                    <label>Referencia del Pago Móvil</label>
                    <input v-model="form.referenciaPago" type="text" required placeholder="Ingrese el número de referencia" />
                  </div>
                </template>
                
                <template v-if="form.metodoPago === 'transferencia'">
                  <div class="col-12 mt-3 mb-3 form-section">
                    <h3 class="text-start">Datos para Transferencia</h3>
                  </div>
                  <div class="col-md-6 mb-3 campo">
                    <label>Beneficiario</label>
                    <input type="text" :value="datosPago.transferencia.beneficiario" readonly />
                  </div>
                  <div class="col-md-6 mb-3 campo">
                    <label>Cédula/RIF</label>
                    <input type="text" :value="datosPago.transferencia.cedula" readonly />
                  </div>
                  <div class="col-12 mb-3 campo">
                    <label>Cuenta Bancaria</label>
                    <input type="text" :value="datosPago.transferencia.cuenta" readonly />
                  </div>
                   <div class="col-12 mb-3 campo">
                    <label>Referencia de la Transferencia</label>
                    <input v-model="form.referenciaPago" type="text" required placeholder="Ingrese el número de referencia" />
                  </div>
                </template>
                
                <div class="col-12 d-grid mt-4">
                  <button type="submit" class="btn-pagar">
                    Confirmar Reserva
                  </button>
                </div>

                <div class="col-12 text-center mt-3">
                  <button @click="cancelarPago" class="btn-cancelar" type="button">
                    Cancelar
                  </button>
                </div>
                
              </div>
            </form>
          </div>
        </div>
>>>>>>> 682b119356ef687eac453c3d9066f92d0f9530d8
      </div>

<<<<<<< HEAD
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

=======
>>>>>>> 682b119356ef687eac453c3d9066f92d0f9530d8
    <Footer_Cliente />
  </div>
</template>

<script>
import menuPrincipal1 from "./components/menuPrincipal1.vue";
import Footer_Cliente from "./components/Footer_Cliente.vue";

export default {
  name: "paginaPago",
<<<<<<< HEAD

=======
>>>>>>> 682b119356ef687eac453c3d9066f92d0f9530d8
  components: { menuPrincipal1, Footer_Cliente },

  data() {
    return {
<<<<<<< HEAD
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
=======
      pago: {
        nombre: "", 
        tarjeta: "",
        expiracion: "",
        cvv: "",
        monto: 0, 
      },
      // === DATOS DEL CLIENTE (Placeholder para la visualización) ===
      cliente: {
          cedula: 'V-15876543',
          nombre: 'Juan',
          apellido: 'Pérez',
          telefono: '+58 412-1234567',
          correo: 'juan.perez@email.com',
      },
      // ============================================================
      
      // === DATOS PRECARGADOS PARA PAGOS (Actualizados) ===
      datosPago: {
          pagoMovil: {
              telefono: '0412-0553988', // Actualizado
              rif: 'J-12345678-9',
              banco: '0108 - Banco Provincial',
          },
          transferencia: {
              beneficiario: 'EcoTours, C.A.', // Actualizado
              cedula: 'J-12345678-9',
              cuenta: '0108-0102-0304-0506-0708',
              banco: 'Provincial',
          }
      },
      // =================================
      
      vuelos: [
        {
          origen: "Caracas (CCS)",
          destino: "Panamá (PTY)",
          fechaInicio: "2026-01-22", 
          fechaFin: "2026-01-27",   
          precio: 539,
          aerolinea: "Copa Airlines",
          hotel: "Hotel Panamá City",
          imagen: "/img/vueloCaracas-Panama.webp",
        },
      ],
      vueloSeleccionado: null, 
      form: {
        fechaInicio: "2026-01-22", 
        fechaFin: "2026-01-27",   
        personas: 1, 
        metodoPago: "", 
        referenciaPago: '', 
>>>>>>> 682b119356ef687eac453c3d9066f92d0f9530d8
      },
    };
  },

  mounted() {
    if (!this.vueloSeleccionado && this.vuelos.length > 0) {
      this.seleccionarVuelo(this.vuelos[0]);
    }
  },

  computed: {
    totalPagar() {
<<<<<<< HEAD
      return this.form.precio * this.form.personas;
=======
      const precioUnitario = this.vueloSeleccionado?.precio || 539; 
      const personas = this.form.personas || 1;
      return (precioUnitario * personas).toFixed(2); 
>>>>>>> 682b119356ef687eac453c3d9066f92d0f9530d8
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
<<<<<<< HEAD
    enviarFormulario() {
      alert(`✅ Reserva confirmada para ${this.form.nombre}.
Destino: ${this.form.destino}
Total: USD ${this.totalPagar}`);
=======
    todayDate() {
        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0'); 
        const day = String(now.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    },
    
    seleccionarVuelo(vuelo) {
      this.vueloSeleccionado = vuelo;
      this.form.fechaInicio = vuelo.fechaInicio;
      this.form.fechaFin = vuelo.fechaFin;
    },
    
    procesarPago() {
      const today = this.todayDate();
      const startDate = this.form.fechaInicio;
      const endDate = this.form.fechaFin;
      
      // === VALIDACIONES DE FECHAS ===
      if (startDate < today) {
          alert("❌ Error: La fecha de inicio de la reserva no puede ser un día que ya pasó.");
          return;
      }
      if (endDate < startDate) {
          alert("❌ Error: La fecha de fin de la reserva no puede ser anterior a la fecha de inicio.");
          return;
      }
      
      // === VALIDACIONES DE PAGO Y REFERENCIA ===
      if (!this.form.metodoPago) {
         alert("Por favor, seleccione un método de pago.");
         return;
      }
      if (!this.form.referenciaPago) {
         alert(`Por favor, ingrese el número de referencia para la ${this.form.metodoPago === 'pago-movil' ? 'Pago Móvil' : 'Transferencia'}.`);
         return;
      }
      
      alert(`✅ Reserva CONFIRMADA por USD ${this.totalPagar}. Método: ${this.form.metodoPago === 'pago-movil' ? 'Pago Móvil' : 'Transferencia'}. Referencia: ${this.form.referenciaPago}.`);
    },
    
    cancelarPago() {
      this.$router.push('/pagina-clientes'); 
>>>>>>> 682b119356ef687eac453c3d9066f92d0f9530d8
    },
  },
};
</script>

<style scoped>
/* ------------------------------------------------ */
/* ESTILOS DE LA PÁGINA DE PAGO */
/* ------------------------------------------------ */

.pagina-pago {
  font-family: "Poppins", sans-serif;
  background: url('/img/pgclientes.webp') no-repeat center center fixed; 
  background-size: cover;
  color: #1e1e1e;
  padding-bottom: 2rem;
}

.formulario-pago {
  background: rgba(255, 255, 255, 0.95);
  margin: 2rem auto;
  max-width: 800px;
  border-radius: 12px;
  padding: 2rem;
  box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
}

.formulario-pago h2, .formulario-pago h1 {
  text-align: center;
  color: #ff6600;
  margin-bottom: 1.5rem;
}

label {
  display: block;
  font-weight: 600;
  margin-top: 0.5rem;
}

.campo input,
.campo select {
  width: 100%;
  padding: 0.6rem;
  border-radius: 8px;
  border: 1px solid #ccc;
  margin-top: 0.3rem;
  box-sizing: border-box; 
}

/* Estilos para el campo de precio total */
input.precio {
    font-weight: bold;
    color: #ff6600;
    font-size: 1.1em;
}

/* Estilos para el botón Confirmar Reserva */
.btn-pagar {
  display: block;
  width: 100%;
  background-color: #ff6600;
  color: white;
  border: none;
  padding: 0.9rem;
  border-radius: 10px;
  font-size: 1rem;
  cursor: pointer;
  transition: background 0.3s;
}

.btn-pagar:hover {
  background-color: #ff8a33;
}

/* Estilos para el botón Cancelar */
.btn-cancelar {
  background: none;
  border: 1px solid #ff6600;
  color: #ff6600;
  padding: 0.5rem 1rem;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s;
}

.btn-cancelar:hover {
  background-color: #fce4d4;
  text-decoration: underline;
}
</style>