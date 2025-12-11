<template>
  <div class="pag-ADMIN">
    <Sidebar_Admin />

    <main class="container-xl py-5">
      <h1 class="text-center mb-4 titulo-admin">Historial de Compras</h1>

      <div class="card contenido shadow-lg">
        <div class="card-header encabezado">
          <h3 class="mb-0">Gestión de Pagos a Proveedores</h3>
        </div>

        <div class="card-body p-0">
          <table class="tabla">
            <thead>
              <tr>
                <th>ID Factura</th>
                <th>Cliente</th>
                <th>Paquete</th>
                <th>Monto Total (Ingreso)</th>
                <th>Estado Pagos Prov.</th>
                <th>Acción</th>
              </tr>
            </thead>

            <tbody>
              <tr v-for="item in historial" :key="item.id">
                <td>#{{ item.id }}</td>
                <td>{{ item.cliente }}</td>
                <td>{{ item.paquete }}</td>
                <td>{{ item.monto }} USD</td>
                
                <td>
                  <span
                    class="estado"
                    :class="{
                      pendiente: estadoGeneral(item) === 'Pendiente',
                      parcial: estadoGeneral(item) === 'Parcial',
                      confirmado: estadoGeneral(item) === 'Completo'
                    }"
                  >
                    {{ estadoGeneral(item) }}
                  </span>
                </td>

                <td>
                  <button class="btn-editar" @click="abrirModal(item)" title="Gestionar Pagos">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#ff6600" viewBox="0 0 16 16">
                      <path d="M4 0h5.293A1 1 0 0 1 10 .293L13.707 4a1 1 0 0 1 .293.707V14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2zm5.5 1.5v2a1 1 0 0 0 1 1h2l-3-3z"/>
                      <path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 2a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5z"/>
                    </svg>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- MODAL DE GESTIÓN DE PAGOS -->
      <div v-if="modalVisible" class="modal-backdrop">
        <div class="modal-container p-4">
          
          <h3 class="modal-title text-center text-primary mb-4">Gestionar Pagos a Proveedores</h3>
          <p class="text-center text-muted">Factura #{{ form.id }}</p>

          <div class="modal-body-scroll">
              
              <!-- SECCIÓN AEROLINEA -->
              <div class="card mb-3 border-info">
                  <div class="card-header bg-info text-white d-flex justify-content-between">
                      <span>✈️ Aerolínea</span>
                      <span class="fw-bold">{{ form.pagos.aerolinea.nombre }}</span>
                  </div>
                  <div class="card-body bg-light">
                      <div class="row">
                          <div class="col-6 mb-2">
                             <label class="small fw-bold">Monto a Pagar:</label>
                             <div class="input-group input-group-sm">
                                <span class="input-group-text">$</span>
                                <input type="number" v-model="form.pagos.aerolinea.monto" class="form-control" readonly />
                             </div>
                          </div>
                          <div class="col-6 mb-2 d-flex align-items-center">
                              <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" v-model="form.pagos.aerolinea.confirmado">
                                <label class="form-check-label fw-bold" :class="form.pagos.aerolinea.confirmado ? 'text-success' : 'text-danger'">
                                    {{ form.pagos.aerolinea.confirmado ? 'PAGADO' : 'PENDIENTE' }}
                                </label>
                              </div>
                          </div>
                          
                          <div class="col-6 mb-2">
                             <label class="small">Referencia:</label>
                             <input type="text" v-model="form.pagos.aerolinea.referencia" class="form-control form-control-sm" placeholder="# Ref" :disabled="!form.pagos.aerolinea.confirmado">
                          </div>
                           <div class="col-6 mb-2">
                             <label class="small">Fecha Pago:</label>
                             <input type="date" v-model="form.pagos.aerolinea.fecha_pago" class="form-control form-control-sm" :disabled="!form.pagos.aerolinea.confirmado">
                          </div>
                      </div>
                  </div>
              </div>

              <!-- SECCIÓN HOTEL -->
              <div class="card mb-3 border-warning">
                  <div class="card-header bg-warning text-dark d-flex justify-content-between">
                      <span>🏨 Hotel</span>
                      <span class="fw-bold">{{ form.pagos.hotel.nombre }}</span>
                  </div>
                  <div class="card-body bg-light">
                      <div class="row">
                          <div class="col-6 mb-2">
                             <label class="small fw-bold">Monto a Pagar:</label>
                             <div class="input-group input-group-sm">
                                <span class="input-group-text">$</span>
                                <input type="number" v-model="form.pagos.hotel.monto" class="form-control" readonly />
                             </div>
                          </div>
                          <div class="col-6 mb-2 d-flex align-items-center">
                              <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" v-model="form.pagos.hotel.confirmado">
                                <label class="form-check-label fw-bold" :class="form.pagos.hotel.confirmado ? 'text-success' : 'text-danger'">
                                    {{ form.pagos.hotel.confirmado ? 'PAGADO' : 'PENDIENTE' }}
                                </label>
                              </div>
                          </div>
                          <div class="col-6 mb-2">
                             <label class="small">Referencia:</label>
                             <input type="text" v-model="form.pagos.hotel.referencia" class="form-control form-control-sm" placeholder="# Ref" :disabled="!form.pagos.hotel.confirmado">
                          </div>
                           <div class="col-6 mb-2">
                             <label class="small">Fecha Pago:</label>
                             <input type="date" v-model="form.pagos.hotel.fecha_pago" class="form-control form-control-sm" :disabled="!form.pagos.hotel.confirmado">
                          </div>
                      </div>
                  </div>
              </div>

               <!-- SECCIÓN RESTAURANTE -->
               <div class="card mb-3 border-success">
                  <div class="card-header bg-success text-white d-flex justify-content-between">
                      <span>🍽️ Restaurante</span>
                      <span class="fw-bold">{{ form.pagos.restaurante.nombre }}</span>
                  </div>
                  <div class="card-body bg-light">
                      <div class="row">
                          <div class="col-6 mb-2">
                             <label class="small fw-bold">Monto a Pagar:</label>
                             <div class="input-group input-group-sm">
                                <span class="input-group-text">$</span>
                                <input type="number" v-model="form.pagos.restaurante.monto" class="form-control" readonly />
                             </div>
                          </div>
                           <div class="col-6 mb-2 d-flex align-items-center">
                              <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" v-model="form.pagos.restaurante.confirmado">
                                <label class="form-check-label fw-bold" :class="form.pagos.restaurante.confirmado ? 'text-success' : 'text-danger'">
                                    {{ form.pagos.restaurante.confirmado ? 'PAGADO' : 'PENDIENTE' }}
                                </label>
                              </div>
                          </div>
                          <div class="col-6 mb-2">
                             <label class="small">Referencia:</label>
                             <input type="text" v-model="form.pagos.restaurante.referencia" class="form-control form-control-sm" placeholder="# Ref" :disabled="!form.pagos.restaurante.confirmado">
                          </div>
                           <div class="col-6 mb-2">
                             <label class="small">Fecha Pago:</label>
                             <input type="date" v-model="form.pagos.restaurante.fecha_pago" class="form-control form-control-sm" :disabled="!form.pagos.restaurante.confirmado">
                          </div>
                      </div>
                  </div>
              </div>

          </div>

          <div class="modal-footer mt-3">
            <button class="btn btn-secondary" @click="cerrarModal">Cancelar</button>
            <button class="btn btn-primary fw-bold" @click="guardarCambios">Guardar Cambios</button>
          </div>

        </div>
      </div>

    </main>

    <Footer_Admin />
  </div>
</template>



<script>
import { ref } from "vue";
import axios from "axios";

import Sidebar_Admin from "./components/Sidebar_Admin.vue";
import Footer_Admin from "./components/Footer_Admin.vue";

export default {
  name: "HistorialCompras",
  components: { Sidebar_Admin, Footer_Admin },

  setup() {
    const historial = ref([]);
    const modalVisible = ref(false);

    // Estado del formulario (3 secciones)
    const form = ref({
      id: null,
      pagos: {
          aerolinea: { confirmado: false, referencia: '', fecha_pago: '', monto: 0, nombre: '' },
          hotel: { confirmado: false, referencia: '', fecha_pago: '', monto: 0, nombre: '' },
          restaurante: { confirmado: false, referencia: '', fecha_pago: '', monto: 0, nombre: '' },
      }
    });

    const cargarHistorial = async () => {
      try {
        const res = await axios.get("http://localhost:3000/api/historial-compras");
        historial.value = res.data.data;
      } catch (e) {
        console.error(e);
        alert("Error cargando historial");
      }
    };

    const abrirModal = (item) => {
      console.log("Abriendo modal para item:", item);
      console.log("Pagos data:", item.pagos);

      // Clonar datos del item para no mutar lista directamente antes de guardar
      // Aseguramos valores por defecto
      const p = item.pagos;
      // Usamos la referencia de la factura si no hay una especifica del pago
      const refDefault = item.referencia_factura || '';
      
      form.value = {
        id: item.id,
        pagos: {
            aerolinea: { 
                ...p.aerolinea, 
                fecha_pago: p.aerolinea.fecha_pago || new Date().toISOString().split('T')[0],
                referencia: p.aerolinea.referencia || refDefault
            },
            hotel: { 
                ...p.hotel, 
                fecha_pago: p.hotel.fecha_pago || new Date().toISOString().split('T')[0],
                referencia: p.hotel.referencia || refDefault
            },
            restaurante: { 
                ...p.restaurante, 
                fecha_pago: p.restaurante.fecha_pago || new Date().toISOString().split('T')[0],
                referencia: p.restaurante.referencia || refDefault
            }
        }
      };
      console.log("Formulario cargado:", form.value);
      
      modalVisible.value = true;
    };

    const cerrarModal = () => {
      modalVisible.value = false;
    };

    const guardarCambios = async () => {
      try {
        await axios.put(`http://localhost:3000/api/historial-compras/${form.value.id}`, {
          pagos: form.value.pagos
        });

        alert("Pagos actualizados y contabilizados con éxito");
        cerrarModal();
        cargarHistorial(); // Refrescar para ver nuevos estados
      } catch (e) {
        console.error(e);
        alert("Error al actualizar: " + (e.response?.data?.error || e.message));
      }
    };

    // Computada simple o metodo para ver estado general en tabla
    const estadoGeneral = (item) => {
        const p = item.pagos;
        const total = (p.aerolinea.confirmado ? 1 : 0) + (p.hotel.confirmado ? 1 : 0) + (p.restaurante.confirmado ? 1 : 0);
        if (total === 3) return 'Completo';
        if (total > 0) return 'Parcial';
        return 'Pendiente';
    };

    cargarHistorial();

    return {
      historial,
      modalVisible,
      abrirModal,
      cerrarModal,
      guardarCambios,
      form,
      estadoGeneral
    };
  }
};
</script>

<style scoped>
/* (Tus estilos originales – NO se tocan) */

.pag-ADMIN {
  min-height: 100vh;
  background: #f3f3f3;
}

.contenido {
  background: white;
  border-radius: 12px;
}

.encabezado {
  background: #ff6600;
  color: white;
  padding: 15px;
  border-radius: 12px 12px 0 0;
}

.titulo-admin {
  color: #ff6600;
  font-weight: bold;
}

.tabla {
  width: 100%;
  border-collapse: collapse;
}

.tabla th {
  background: #ffc189;
  padding: 10px;
  color: #333;
  font-weight: bold;
}

.tabla td {
  padding: 10px;
  border-bottom: 1px solid #eee;
}

.estado {
  padding: 5px 12px;
  border-radius: 8px;
  color: white;
  font-weight: 600;
}

.pendiente {
  background: #d63333;
}

.confirmado {
  background: #198754;
}

.btn-editar {
  background: none;
  border: none;
  cursor: pointer;
}

.modal-backdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.55);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2000;
}

.modal-container {
  background: white;
  width: 500px; /* Mas ancho */
  max-width: 95vw;
  max-height: 90vh; /* Limite altura */
  border-radius: 14px;
  box-shadow: 0 6px 20px rgba(0,0,0,0.25);
  display: flex;
  flex-direction: column;
}

.modal-body-scroll {
    overflow-y: auto;
    padding: 10px;
    flex-grow: 1;
}

.parcial {
  background-color: #ffc107;
  color: #333;
}

.modal-title {
  margin-bottom: 15px;
  font-size: 22px;
  color: #ff6600;
  font-weight: bold;
}

.input-modal {
  width: 100%;
  padding: 10px;
  margin-bottom: 12px;
  border: 1px solid #ddd;
  border-radius: 8px;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

.btn-cerrar {
  background: #777;
  color: white;
  padding: 8px 15px;
  border-radius: 8px;
}

.btn-guardar {
  background: #ff6600;
  color: white;
  padding: 8px 15px;
  border-radius: 8px;
}
</style>
