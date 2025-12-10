<template>
  <div class="pag-ADMIN">
    <Sidebar_Admin />

    <main class="container-xl py-5">

      <h1 class="text-center mb-4 titulo-admin">Movimientos Contables</h1>

      <!-- FILTROS -->
      <div class="card p-3 mb-4 shadow-sm">

        <div class="row g-3">

          <div class="col-md-4">
            <label>Factura:</label>
            <input type="number" v-model="filtros.factura" class="form-control" placeholder="ID factura">
          </div>

          <div class="col-md-4">
            <label>Fecha:</label>
            <input type="date" v-model="filtros.fecha" class="form-control">
          </div>

          <div class="col-md-4">
            <label>Cuenta Contable:</label>
            <select v-model="filtros.cuenta" class="form-control">
              <option value="">Todas</option>
              <option v-for="c in cuentas" :key="c.id_cuenta" :value="c.id_cuenta">
                {{ c.nombre }} ({{ c.tipo }})
              </option>
            </select>
          </div>

        </div>

        <div class="mt-3 text-end">
          <button class="btn btn-primary" @click="buscar">Buscar</button>
          <button class="btn btn-secondary ms-2" @click="resetFiltro">Limpiar</button>
        </div>

      </div>

      <!-- TABLA -->
      <div class="card contenido shadow-lg">
        <div class="card-header encabezado">
          <h3 class="mb-0">Registros Contables</h3>
        </div>

        <div class="card-body p-0">
          
          <table class="tabla">
            <thead>
              <tr>
                <th>ID</th>
                <th>Factura</th>
                <th>Cuenta</th>
                <th>Tipo</th>
                <th>Monto</th>
                <th>Fecha</th>
                <th>Descripción</th>
              </tr>
            </thead>

            <tbody>
              <tr v-for="m in movimientos" :key="m.id_registro">
                <td>{{ m.id_registro }}</td>
                <td>{{ m.id_factura }}</td>
                <td>{{ m.cuenta_nombre }}</td>
                <td>{{ m.tipo_movimiento }}</td>
                <td>{{ m.monto }} USD</td>
                <td>{{ m.fecha_mov }}</td>
                <td>{{ m.descripcion }}</td>
              </tr>
            </tbody>
          </table>

        </div>
      </div>

    </main>

    <Footer_Admin />
  </div>
</template>

<script>
import axios from "axios";
import { ref, onMounted } from "vue";
import Sidebar_Admin from "./components/Sidebar_Admin.vue";
import Footer_Admin from "./components/Footer_Admin.vue";

export default {
  components: { Sidebar_Admin, Footer_Admin },

  setup() {
    const movimientos = ref([]);
    const cuentas = ref([]);

    const filtros = ref({
      factura: "",
      fecha: "",
      cuenta: ""
    });

    const cargarMovimientos = async () => {
      const res = await axios.get("http://localhost:3000/api/movimientos-contables");
      movimientos.value = res.data;
    };

    const cargarCuentas = async () => {
      const res = await axios.get("http://localhost:3000/api/cuentas-contables");
      cuentas.value = res.data;
    };

    const buscar = async () => {
      const res = await axios.get("http://localhost:3000/api/movimientos-contables/filtro", {
        params: filtros.value
      });
      movimientos.value = res.data;
    };

    const resetFiltro = () => {
      filtros.value = {
        factura: "",
        fecha: "",
        cuenta: ""
      };
      cargarMovimientos();
    };

    onMounted(() => {
      cargarMovimientos();
      cargarCuentas();
    });

    return { movimientos, cuentas, filtros, buscar, resetFiltro };
  }
};
</script>

<style scoped>
/* Usa tu propio CSS tal cual */
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
</style>
