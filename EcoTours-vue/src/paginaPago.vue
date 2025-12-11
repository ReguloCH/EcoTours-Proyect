<template>
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
                  <input type="text" :value="'USD ' + (form.precio || 539)" readonly />
                </div>

                <div class="col-md-4 mb-3 campo">
                  <label>Cantidad de personas (Fijo por Paquete)</label>
                  <input v-model.number="form.personas" type="number" readonly class="bg-light" />
                </div>
                
                <div class="col-md-4 mb-3 campo">
                  <label>Total a pagar:</label>
                  <input type="text" :value="'USD ' + totalPagar" readonly class="precio" />
                </div>

              </div>
              
              <hr class="my-4" />
              
              <h2 class="mb-3 text-center">Datos del Cliente</h2>
              
              <!-- Selector de Usuario (Solo si hay usuarios cargados) -->
              <div class="row mb-3" v-if="listaUsuarios.length > 0">
                 <div class="col-12 campo">
                    <label class="text-primary">Seleccionar Usuario Registrado:</label>
                    <select v-model="usuarioSeleccionadoId" @change="actualizarDatosCliente" class="form-select border-primary">
                        <option :value="null" disabled>-- Quién realiza la compra? --</option>
                        <option v-for="u in listaUsuarios" :key="u.cedula_usuario" :value="u.cedula_usuario">
                            {{ u.nombre_usuario }} ({{ u.cedula_usuario }})
                        </option>
                    </select>
                 </div>
              </div>

              <div class="row">
                  
                  <div class="col-md-6 mb-3 campo">
                      <label>Cédula</label>
                      <input type="text" v-model="cliente.cedula" readonly class="bg-light" />
                  </div>
                  
                  <div class="col-md-6 mb-3 campo">
                      <label>Nombre Completo</label>
                      <input type="text" v-model="cliente.nombre" readonly class="bg-light" />
                  </div>

                  <div class="col-md-6 mb-3 campo">
                      <label>Usuario</label>
                       <!-- Usando apellido para mostrar el username si no hay apellido real -->
                      <input type="text" v-model="cliente.apellido" readonly class="bg-light" />
                  </div>

                  <div class="col-md-6 mb-3 campo">
                      <label>Teléfono</label>
                      <input type="text" v-model="cliente.telefono" readonly class="bg-light" />
                  </div>
                  
                  <div class="col-12 mb-3 campo">
                      <label>Correo Electrónico</label>
                      <input type="text" v-model="cliente.correo" readonly class="bg-light" />
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
      </div>
    </div>
    <Footer_Cliente />
  </div>
</template>

<script>
import menuPrincipal1 from "./components/menuPrincipal1.vue";
import Footer_Cliente from "./components/Footer_Cliente.vue";
import axios from "axios";

export default {
  name: "paginaPago",
  components: { menuPrincipal1, Footer_Cliente },

  data() {
    return {
      // === DATOS DE CLIENTES ===
      listaUsuarios: [],
      usuarioSeleccionadoId: null, // Model para el select
      cliente: { // Datos visuales del usuario seleccionado
          cedula: '',
          nombre: '',
          apellido: '',
          telefono: '',
          correo: '',
      },
      
      // === DATOS PRECARGADOS PARA PAGOS ===
      datosPago: {
          pagoMovil: {
              telefono: '0412-0553988',
              rif: 'J-12345678-9',
              banco: '0108 - Banco Provincial',
          },
          transferencia: {
              beneficiario: 'EcoTours, C.A.',
              cedula: 'J-12345678-9',
              cuenta: '0108-0102-0304-0506-0708',
              banco: 'Provincial',
          }
      },
      
      form: {
        origen: "",
        destino: "",
        aerolinea: "",
        hotel: "",
        fechaInicio: "2026-01-22",
        fechaFin: "2026-01-27",
        precio: 0,
        personas: 1,
        metodoPago: "",
        referenciaPago: '',
      },
    };
  },

  computed: {
    totalPagar() {
      const precioUnitario = this.form.precio || 0;
      const personas = this.form.personas || 1;
      return (precioUnitario * personas).toFixed(2);
    },
  },

  async created() {
    const q = this.$route.query;
    
    // 1. Intentar recuperar del LocalStorage si no hay query param (persistencia)
    const storedPackage = JSON.parse(localStorage.getItem('temp_reserva_paquete') || '{}');

    if (q && q.idPaquete) {
        // Prioridad: Query Params
        this.form.origen = q.origen || "";
        this.form.destino = q.destino || "";
        this.form.fechaInicio = q.date || "2026-01-22"; 
        this.form.precio = Number(q.precio) || 0;
        this.form.idPaquete = Number(q.idPaquete);
        
        // Guardar en Storage para futuras recargas
        localStorage.setItem('temp_reserva_paquete', JSON.stringify({
            id: this.form.idPaquete,
            precio: this.form.precio,
            destino: this.form.destino
        }));
    } else if (storedPackage.id) {
        // Fallback: LocalStorage
        this.form.idPaquete = storedPackage.id;
        this.form.precio = storedPackage.precio;
        this.form.destino = storedPackage.destino;
        console.log("Restaurado del almacenamiento local:", storedPackage);
    }
    
    // 2. Fetch de Datos Reales (Personas)
    if (this.form.idPaquete) {
        await this.cargarDetallesPaquete(this.form.idPaquete);
    }
    
    // Cargar usuarios
    try {
        const res = await axios.get('http://localhost:3000/api/usuario');
        this.listaUsuarios = Array.isArray(res.data) ? res.data : [];
    } catch (e) {
        console.error("Error cargando usuarios:", e);
    }
  },
  
  watch: {
    'form.idPaquete': {
      handler(newId, oldId) {
        if (newId && newId !== oldId) {
          this.cargarDetallesPaquete(newId);
        }
      },
      immediate: false, // No ejecutar en la creación, ya se maneja en created
    },
  },

  methods: {
    async cargarDetallesPaquete(id) {
        try {
            console.log("Consultando paquete:", id);
            const resPaq = await axios.get(`http://localhost:3000/api/paquete-turistico/${id}`);
            const paqueteData = resPaq.data; 
            if (paqueteData) {
                // FORZAR la cantidad de personas del paquete
                this.form.personas = paqueteData.cantidad_personas || 1;
                console.log("Cantidad de personas actualizada:", this.form.personas);
            }
        } catch (error) {
            console.error("Error cargando detalles del paquete:", error);
        }
    },
    actualizarDatosCliente() {
        const u = this.listaUsuarios.find(user => user.cedula_usuario === this.usuarioSeleccionadoId);
        if (u) {
            this.cliente.cedula = u.cedula_usuario.toString();
            this.cliente.nombre = u.nombre_usuario || '';
            this.cliente.apellido = u.user_usuario || ''; // Usamos user como apellido placeholder
            this.cliente.telefono = u.telefono_usuario || '';
            this.cliente.correo = u.correo_usuario || '';
        }
    },
    todayDate() {
        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0'); 
        const day = String(now.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    },
    
    async procesarPago() {
      const today = this.todayDate();
      const startDate = this.form.fechaInicio;
      // const endDate = this.form.fechaFin;
      
      // === VALIDACIONES ===
      if (startDate < today) {
          alert("❌ Error: La fecha de inicio no puede ser anterior a hoy.");
          return; 
      }
      
      if (!this.form.metodoPago) {
         alert("Por favor, seleccione un método de pago.");
         return;
      }
      if (!this.form.referenciaPago) {
         alert(`Por favor, ingrese el número de referencia.`);
         return;
      }
      if (!this.usuarioSeleccionadoId) {
          alert("Debe seleccionar un usuario para facturar.");
          return;
      }
      
      // Mapeo básico de métodos de pago (Ajustar según IDs reales de la BD: 1=PagoMovil, 2=Transferencia, etc)
      // Asumiremos: 1: Pago Movil, 2: Transferencia, 3: Efectivo, etc.
      let idMetodo = 3; // Default
      if (this.form.metodoPago === 'pago-movil') idMetodo = 1; 
      if (this.form.metodoPago === 'transferencia') idMetodo = 2;

      const payload = {
        cedula_usuario: this.usuarioSeleccionadoId, // ID directo del select (es INT)
        id_paquete: this.form.idPaquete, 
        id_metodoP: idMetodo,
        id_estado_transaccion: 1, // 1 = Aprobado/Pagado (Asumido)
        monto_pagado: parseFloat(this.totalPagar),
        fecha_pago: new Date(),
        num_referencia: this.form.referenciaPago // CORREGIDO: Debe coincidir con BD
      };

      try {
        await axios.post('http://localhost:3000/api/facturas-clientes', payload);
        
        alert(`✅ ¡Reserva Exitosa!\n\nSe ha generado la factura y el registro contable automáticamente.\nMonto: USD ${this.totalPagar}`);
        this.$router.push('/movimientos-contables'); // Redirigir a contabilidad para ver el resultado
      } catch (error) {
        console.error(error);
        alert("❌ Error al procesar el pago: " + (error.response?.data?.error || error.message));
      }
    },
    
    cancelarPago() {
      this.$router.push('/pagina-clientes'); 
    },
  },
};
</script>

<style scoped>
/* ESTILOS DE LA PÁGINA DE PAGO */

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

/* Botones */
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