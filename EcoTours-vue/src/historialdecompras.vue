<template>
  <div class="pag-ADMIN">
    <Sidebar_Admin />

    <main class="container-xl py-5">
      <h1 class="text-center mb-4 titulo-admin">Historial de Compras</h1>

      <div class="card contenido shadow-lg">
        <div class="card-header encabezado">
          <h3 class="mb-0">Registros de Pagos</h3>
        </div>

        <div class="card-body p-0">
          <table class="tabla">
            <thead>
              <tr>
                <th>ID</th>
                <th>Cliente</th>
                <th>Paquete</th>
                <th>Monto</th>
                <th>Fecha Generación</th>
                <th>Fecha Pago Real</th>
                <th>Referencia</th>
                <th>Estado</th>
                <th>Editar</th>
              </tr>
            </thead>

            <tbody>
              <tr v-for="item in historial" :key="item.id">
                <td>{{ item.id }}</td>
                <td>{{ item.cliente }}</td>
                <td>{{ item.paquete }}</td>
                <td>{{ item.monto }} USD</td>
                <td>{{ item.fecha_generacion }}</td>
                <td>{{ item.fecha_pago_real || "---" }}</td>
                <td>{{ item.referencia || "---" }}</td>

                <td>
                  <span
                    class="estado"
                    :class="{
                      pendiente: item.estado === 'Pendiente',
                      confirmado: item.estado === 'Confirmado'
                    }"
                  >
                    {{ item.estado }}
                  </span>
                </td>

                <td>
                  <button class="btn-editar" @click="abrirModal(item)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#ff6600" viewBox="0 0 16 16">
                      <path
                        d="M12.146.854a.5.5 0 0 1 .708 0L15 3l-2 2-2.146-2.146a.5.5 0 0 1 0-.708l1.292-1.292zM11.207 3.5 
                           3 11.707V14h2.293L13.5 6.793l-2.293-2.293z"
                      />
                    </svg>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- MODAL -->
      <div v-if="modalVisible" class="modal-backdrop">
        <div class="modal-container">

          <h3 class="modal-title">Editar Registro</h3>

          <div class="modal-body">
            <label>Fecha de Pago Real:</label>
            <input type="date" v-model="form.fecha_pago_real" class="input-modal">

            <label>Número de Referencia:</label>
            <input type="text" v-model="form.referencia" class="input-modal">

            <label>Estado del Pago:</label>
            <select v-model="form.estado" class="input-modal">
              <option value="Pendiente">Pendiente</option>
              <option value="Confirmado">Confirmado</option>
            </select>
          </div>

          <div class="modal-footer">
            <button class="btn-cerrar" @click="cerrarModal">Cerrar</button>
            <button class="btn-guardar" @click="guardarCambios">Guardar</button>
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

    const form = ref({
      id: null,
      fecha_pago_real: "",
      referencia: "",
      estado: "Pendiente"
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
      form.value = {
        id: item.id,
        fecha_pago_real: item.fecha_pago_real || "",
        referencia: item.referencia || "",
        estado: item.estado
      };
      modalVisible.value = true;
    };

    const cerrarModal = () => {
      modalVisible.value = false;
    };

    const guardarCambios = async () => {
      try {
        await axios.put(`http://localhost:3000/api/historial-compras/${form.value.id}`, {
          fecha_pago_real: form.value.fecha_pago_real,
          numReferenciaPago: form.value.referencia,
          id_estado_transaccion: form.value.estado === "Confirmado" ? 2 : 1
        });

        alert("Actualizado con éxito");
        cerrarModal();
        cargarHistorial();
      } catch (e) {
        console.error(e);
        alert("Error al actualizar el registro");
      }
    };

    cargarHistorial();

    return {
      historial,
      modalVisible,
      abrirModal,
      cerrarModal,
      guardarCambios,
      form
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
  width: 420px;
  padding: 20px;
  border-radius: 14px;
  box-shadow: 0 6px 20px rgba(0,0,0,0.25);
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
