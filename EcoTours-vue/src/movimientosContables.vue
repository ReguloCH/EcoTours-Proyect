<template>
  <div class="pag-ADMIN">
    <Sidebar_Admin />

    <main class="container-xl py-5">
      <h1 class="titulo-modulo text-center mb-5">Módulo Contable</h1>

      <!-- FILTROS DE BÚSQUEDA -->
      <div class="card p-4 mb-5 shadow-sm rounded-4 filtros-container">
        <h4 class="mb-3 text-warning fw-bold">Filtros de Búsqueda</h4>
        
        <div class="row g-3 align-items-end">
          
          <!-- Filtro Factura -->
          <div class="col-md-2">
            <label class="form-label fw-bold">ID Factura:</label>
            <input type="number" v-model="filtros.factura" class="form-control" placeholder="# ID">
          </div>

          <!-- Filtro Cuenta -->
          <div class="col-md-3">
            <label class="form-label fw-bold">Cuenta Contable:</label>
            <select v-model="filtros.cuenta" class="form-select">
              <option value="">Todas</option>
              <option v-for="c in cuentas" :key="c.id_cuenta" :value="c.id_cuenta">
                {{ c.codigo }} - {{ c.nombre }}
              </option>
            </select>
          </div>

          <!-- Filtro Movimiento -->
          <div class="col-md-2">
            <label class="form-label fw-bold">Movimiento:</label>
            <select v-model="filtros.tipoMov" class="form-select">
              <option value="">Todos</option>
              <option value="Debe">Debe</option>
              <option value="Haber">Haber</option>
            </select>
          </div>

          <!-- Filtro Fecha Desde -->
          <div class="col-md-2">
            <label class="form-label fw-bold">Desde:</label>
            <input type="date" v-model="filtros.fechaInicio" class="form-control">
          </div>

          <!-- Filtro Fecha Hasta -->
          <div class="col-md-2">
            <label class="form-label fw-bold">Hasta:</label>
            <input type="date" v-model="filtros.fechaFin" class="form-control">
          </div>
          
           <!-- Botones -->
          <div class="col-md-1 d-flex gap-2">
             <button class="btn btn-secondary w-100 fw-bold" @click="resetFiltros" title="Limpiar"><i class="fas fa-undo"></i></button>
          </div>

        </div>
      </div>

      <!-- TABLA DE RESULTADOS -->
      <div class="card shadow-lg rounded-4 overflow-hidden">
        <div class="card-header bg-white p-3">
            <h4 class="mb-0 text-warning fw-bold">Movimientos Registrados</h4>
        </div>
        
        <div class="card-body p-0">
          <table class="table table-hover mb-0 tabla-movimientos">
            <thead class="bg-orange text-white">
              <tr>
                <th class="py-3 px-4">ID</th>
                <th class="py-3 px-4">Factura</th>
                <th class="py-3 px-4">Código Contable</th>
                <th class="py-3 px-4">Nombre</th>
                <th class="py-3 px-4">Tipo Contable</th>
                <th class="py-3 px-4">Movimiento</th>
                <th class="py-3 px-4">Fecha</th>
                <th class="py-3 px-4">Monto</th>
                <th class="py-3 px-4">Descripción</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="m in movimientosFiltrados" :key="m.id_registro">
                <td class="px-4 fw-bold">{{ m.id_registro }}</td>
                <td class="px-4 text-center">{{ m.id_factura ? '#' + m.id_factura : '-' }}</td>
                <td class="px-4 fw-bold text-secondary">{{ m.cuenta_codigo }}</td>
                <td class="px-4">{{ m.cuenta_nombre }}</td>
                <td class="px-4">{{ m.cuenta_tipo }}</td>
                <td class="px-4 fw-bold" :class="m.tipo_movimiento === 'Debe' ? 'text-danger' : 'text-success'">
                    {{ m.tipo_movimiento }}
                </td>
                <td class="px-4">{{ m.fecha_mov }}</td>
                <td class="px-4 fw-bold">{{ m.monto }} USD</td>
                <td class="px-4 text-muted">{{ m.descripcion }}</td>
              </tr>
              <tr v-if="movimientosFiltrados.length === 0">
                  <td colspan="9" class="text-center py-4 text-muted">No se encontraron registros</td>
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
import { ref, computed, onMounted } from "vue";
import Sidebar_Admin from "./components/Sidebar_Admin.vue";
import Footer_Admin from "./components/Footer_Admin.vue";

export default {
  components: { Sidebar_Admin, Footer_Admin },

  setup() {
    const movimientos = ref([]);
    const cuentas = ref([]);

    const filtros = ref({
      factura: "",
      cuenta: "",
      tipoMov: "",
      fechaInicio: "",
      fechaFin: ""
    });

    const cargarMovimientos = async () => {
      try {
        const res = await axios.get("http://localhost:3000/api/movimientos-contables");
        movimientos.value = res.data;
      } catch(e) { console.error(e); }
    };

    const cargarCuentas = async () => {
      try {
        const res = await axios.get("http://localhost:3000/api/cuentas-contables");
        cuentas.value = res.data;
      } catch(e) { console.error(e); }
    };

    // Filtrado en el cliente
    const movimientosFiltrados = computed(() => {
        return movimientos.value.filter(m => {
            // Filtro Factura
            if (filtros.value.factura && m.id_factura != filtros.value.factura) return false;

            // Filtro Cuenta
            if (filtros.value.cuenta && m.id_cuenta !== filtros.value.cuenta) return false;

            // Filtro Movimiento
            if (filtros.value.tipoMov && m.tipo_movimiento !== filtros.value.tipoMov) return false;

            // Filtro Fechas
            if (filtros.value.fechaInicio && new Date(m.fecha_mov) < new Date(filtros.value.fechaInicio)) return false;
            if (filtros.value.fechaFin && new Date(m.fecha_mov) > new Date(filtros.value.fechaFin)) return false;

            return true;
        });
    });

    const buscar = () => {
        // En este caso, como cargamos todo al inicio, el buscar es solo visual (trigger reactivity si fuera manual, pero computed lo hace auto)
        // Podríamos recargar datos del server si quisiéramos asegurar frescura.
        cargarMovimientos();
    };

    const resetFiltros = () => {
      filtros.value = {
        cuenta: "",
        tipoMov: "",
        fechaInicio: "",
        fechaFin: ""
      };
    };

    onMounted(() => {
      cargarMovimientos();
      cargarCuentas();
    });

    return { movimientos, cuentas, filtros, movimientosFiltrados, buscar, resetFiltros };
  }
};
</script>

<style scoped>
.pag-ADMIN {
  min-height: 100vh;
  background: #f1f3f5; /* Color de fondo suave */
  background-image: url('https://user-images.githubusercontent.com/123/bg-texture.png'); /* Opcional textura */
  background-size: cover;
}

.titulo-modulo {
    color: white;
    text-shadow: 0 2px 4px rgba(0,0,0,0.5);
    font-weight: 800;
}

.filtros-container {
    background: #f8f9fa;
    border: none;
}

.bg-orange {
    background-color: #ff6600 !important;
}

.tabla-movimientos th {
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.tabla-movimientos td {
    vertical-align: middle;
    font-size: 0.95rem;
}

/* Scrollbar para la tabla si es muy ancha */
.table-responsive {
    overflow-x: auto;
}
</style>
