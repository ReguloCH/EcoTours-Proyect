<template>
    <div class="pag-ADMIN-tarifas">
        <menu_ADMIN />

        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Tarifas Aéreas</h1>
            <h2 class="text-center mb-4 sub-titulo-secundario">
                Tarifas para: {{ nombreProveedor || 'Cargando Aerolínea...' }}
            </h2>

            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div class="card-header bg-naranja-principal text-white">
                    <h3 class="card-title mb-0">
                        {{ tarifaEditandoId ? 'Editar Tarifa Aérea' : 'Registrar Nueva Tarifa Aérea' }}
                    </h3>
                </div>
                <div class="card-body">
                    <form @submit.prevent="agregarOActualizarTarifa">
                        <div class="row g-3">
                            <input type="hidden" v-model="nuevaTarifa.id_aerolinea">

                            <div class="col-md-4">
                                <label for="origen_iata" class="form-label">Origen (Código IATA)</label>
                                <input type="text" class="form-control" id="origen_iata" v-model="nuevaTarifa.origen_iata" placeholder="Ej: CCS" maxlength="5" required>
                            </div>
                            <div class="col-md-4">
                                <label for="destino_iata" class="form-label">Destino (Código IATA)</label>
                                <input type="text" class="form-control" id="destino_iata" v-model="nuevaTarifa.destino_iata" placeholder="Ej: MIA" maxlength="5" required>
                            </div>
                            <div class="col-md-4">
                                <label for="tipo_viaje" class="form-label">Tipo de Viaje</label>
                                <select id="tipo_viaje" class="form-select" v-model="nuevaTarifa.tipo_viaje" required>
                                    <option value="Ida y Vuelta">Ida y Vuelta</option>
                                    <option value="Solo Ida">Solo Ida</option>
                                    <option value="Multidestino">Multidestino</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label for="clase_vuelo" class="form-label">Clase de Vuelo</label>
                                <select id="clase_vuelo" class="form-select" v-model="nuevaTarifa.clase_vuelo" required>
                                    <option value="Económica">Económica</option>
                                    <option value="Business">Business</option>
                                    <option value="Primera">Primera</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="fecha_inicio_vigencia" class="form-label">Fecha Inicio Vigencia</label>
                                <input type="date" class="form-control" id="fecha_inicio_vigencia" v-model="nuevaTarifa.fecha_inicio_vigencia" required>
                            </div>
                            <div class="col-md-4">
                                <label for="fecha_fin_vigencia" class="form-label">Fecha Fin Vigencia</label>
                                <input type="date" class="form-control" id="fecha_fin_vigencia" v-model="nuevaTarifa.fecha_fin_vigencia" required>
                            </div>

                            <div class="col-md-3">
                                <label for="tarifa_base_neta" class="form-label">Tarifa Base Neta</label>
                                <input type="number" step="0.01" class="form-control" id="tarifa_base_neta" v-model.number="nuevaTarifa.tarifa_base_neta" required>
                            </div>
                            <div class="col-md-3">
                                <label for="impuestos_y_tasas" class="form-label">Impuestos/Tasas (TUA)</label>
                                <input type="number" step="0.01" class="form-control" id="impuestos_y_tasas" v-model.number="nuevaTarifa.impuestos_y_tasas" required>
                            </div>
                            <div class="col-md-2">
                                <label for="moneda" class="form-label">Moneda</label>
                                <select id="moneda" class="form-select" v-model="nuevaTarifa.moneda" required>
                                    <option value="USD">USD</option>
                                    <option value="VES">VES</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label for="comision_agencia_porcentaje" class="form-label">Comisión (%)</label>
                                <input type="number" step="0.01" class="form-control" id="comision_agencia_porcentaje" v-model.number="nuevaTarifa.comision_agencia_porcentaje">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Tarifa Venta</label>
                                <p class="form-control-plaintext **fw-bold**">{{ calcularTarifaVenta() }}</p>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-naranja-principal mt-4 w-100">
                            <i :class="tarifaEditandoId ? 'bi bi-save-fill' : 'bi bi-airplane-fill'" class="me-2"></i>
                            {{ tarifaEditandoId ? 'Guardar Cambios de Tarifa' : 'Registrar Tarifa Aérea' }}
                        </button>
                        
                        <button v-if="tarifaEditandoId" @click="limpiarFormulario" type="button" class="btn btn-secondary-admin mt-2 w-100">
                            Cancelar Edición
                        </button>
                    </form>
                </div>
            </div>

            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white">
                    <h3 class="card-title mb-0">Listado de Tarifas Aéreas ({{ listaTarifas.length }})</h3>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover tabla-datos">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th>Ruta</th>
                                    <th>Clase</th>
                                    <th>Vigencia</th>
                                    <th>Base Neta</th>
                                    <th>Tasas</th>
                                    <th>Comisión (%)</th>
                                    <th>**Tarifa Venta**</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="listaTarifas.length === 0">
                                    <td colspan="8" class="text-center text-muted">No hay tarifas registradas para esta aerolínea.</td>
                                </tr>
                                <tr v-else v-for="tarifa in listaTarifas" :key="tarifa.id_tarifa_aerea">
                                    <td>{{ tarifa.origen_iata }} a {{ tarifa.destino_iata }} ({{ tarifa.tipo_viaje }})</td>
                                    <td>{{ tarifa.clase_vuelo }}</td>
                                    <td>{{ tarifa.fecha_inicio_vigencia }} a {{ tarifa.fecha_fin_vigencia }}</td>
                                    <td>{{ tarifa.moneda }} {{ tarifa.tarifa_base_neta }}</td>
                                    <td>{{ tarifa.moneda }} {{ tarifa.impuestos_y_tasas }}</td>
                                    <td>{{ tarifa.comision_agencia_porcentaje || 0 }}%</td>
                                    <td>**{{ calcularTarifaVenta(tarifa) }}**</td>
                                    <td>
                                        <button @click="cargarParaEditar(tarifa)" class="btn btn-sm btn-warning me-2" title="Editar">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <button @click="eliminarTarifa(tarifa.id_tarifa_aerea)" class="btn btn-sm btn-danger" title="Eliminar">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
        
        <Footer_Cliente />
    </div>
</template>

<script setup>
import { reactive, ref, onMounted } from 'vue';
import { useRoute } from 'vue-router'; 
import menu_ADMIN from './components/menu_ADMIN.vue';
import Footer_Cliente from './components/Footer_Cliente.vue';
import axios from 'axios'; 

const route = useRoute();
// Debe coincidir con el nombre del parámetro en tu router (ej: /tarifas/aerolineas/:id)
const idAerolinea = ref(route.params.id); 

const nombreProveedor = ref('');
const listaTarifas = reactive([]);
const tarifaEditandoId = ref(null); 
const API_URL = '/api/tarifas-aerolineas'; // Endpoint principal
const API_PROV = '/api/aerolineas'; // Endpoint de proveedor

const nuevaTarifa = reactive(inicializarTarifa());

function inicializarTarifa() {
    return {
        id_tarifa_aerea: 0,
        id_aerolinea: parseInt(idAerolinea.value), 
        origen_iata: '',
        destino_iata: '',
        clase_vuelo: 'Económica',
        tipo_viaje: 'Ida y Vuelta',
        fecha_inicio_vigencia: new Date().toISOString().substr(0, 10),
        fecha_fin_vigencia: '',
        tarifa_base_neta: 0.00,
        impuestos_y_tasas: 0.00,
        moneda: 'USD',
        comision_agencia_porcentaje: 10.00, 
    };
}

// Cálculo de Tarifa de Venta Aérea
function calcularTarifaVenta(tarifa = nuevaTarifa) {
    let tarifa_base = parseFloat(tarifa.tarifa_base_neta || 0);
    let impuestos_tasas = parseFloat(tarifa.impuestos_y_tasas || 0);
    let comision_perc = parseFloat(tarifa.comision_agencia_porcentaje || 0);
    
    if (tarifa_base <= 0) return `${tarifa.moneda} 0.00`;
    
    // 1. Costo Neto Total: Base + Impuestos/Tasas (asumiendo que las tasas ya son un valor fijo)
    let costo_neto = tarifa_base + impuestos_tasas;

    // 2. Tarifa Total (Aplicando comisión sobre el precio de VENTA)
    // Formula: Venta = Costo Neto / (1 - %Comision)
    let tarifa_total = costo_neto / (1 - (comision_perc / 100));

    return `${tarifa.moneda} ${tarifa_total.toFixed(2)}`;
}


onMounted(() => {
    if (idAerolinea.value) {
        cargarDatosProveedor(idAerolinea.value);
        cargarListaTarifas(idAerolinea.value);
    }
});

// --- Lógica de CRUD ---

async function cargarDatosProveedor(id) {
    try {
        const response = await axios.get(`${API_PROV}/${id}`); 
        // Asumiendo que el campo se llama 'nombre_aerolinea' en el backend
        nombreProveedor.value = response.data.nombre_aerolinea || response.data.nombre_hospedaje; 
    } catch (error) {
        console.error('Error al cargar proveedor:', error);
        nombreProveedor.value = 'ERROR: Aerolínea No Encontrada';
    }
}

async function cargarListaTarifas(id) {
    try {
        // La ruta es: /api/tarifas-aerolineas/:idAerolinea
        const response = await axios.get(`${API_URL}/${id}`); 
        listaTarifas.splice(0, listaTarifas.length, ...response.data); 
    } catch (error) {
        console.error('Error al cargar lista de tarifas:', error);
    }
}


async function agregarOActualizarTarifa() {
    const dataToSend = { ...nuevaTarifa };

    try {
        if (tarifaEditandoId.value) {
            // EDICIÓN (PUT) - /api/tarifas-aerolineas/:idTarifa
            await axios.put(`${API_URL}/${tarifaEditandoId.value}`, dataToSend);
            alert('Tarifa aérea actualizada con éxito.');
        } else {
            // REGISTRO (POST) - /api/tarifas-aerolineas
            await axios.post(API_URL, dataToSend);
            alert('Tarifa aérea registrada con éxito.');
        }
        
        cargarListaTarifas(idAerolinea.value); 
        limpiarFormulario(); 
    } catch (error) {
        console.error('Error en la operación de tarifa:', error.response?.data || error.message);
        alert('Hubo un error al guardar la tarifa. Revisa la consola para más detalles.');
    }
}

function cargarParaEditar(tarifa) {
    tarifaEditandoId.value = tarifa.id_tarifa_aerea;
    Object.assign(nuevaTarifa, JSON.parse(JSON.stringify(tarifa)));
}

function limpiarFormulario() {
    Object.assign(nuevaTarifa, inicializarTarifa());
    tarifaEditandoId.value = null;
}

async function eliminarTarifa(id) {
    if (confirm('¿Está seguro de que desea eliminar esta tarifa aérea?')) {
        try {
            // DELETE - /api/tarifas-aerolineas/:idTarifa
            await axios.delete(`${API_URL}/${id}`);
            alert('Tarifa eliminada.');
            cargarListaTarifas(idAerolinea.value);
            if (tarifaEditandoId.value === id) {
                limpiarFormulario();
            }
        } catch (error) {
            console.error('Error al eliminar tarifa:', error.response?.data || error.message);
            alert('Hubo un error al eliminar la tarifa.');
        }
    }
}
</script>

<style scoped>
/* Reutilizando tus estilos de administración */
.pag-ADMIN-tarifas {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    background: url('/img/quienes_somos.jpg') no-repeat center center fixed; 
    background-size: cover;
    color: #333;
}
.main-content-admin { flex-grow: 1; }
.titulo-admin { color: #fff; text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.8); font-weight: 700; }
.sub-titulo-secundario { color: #e65c00; font-weight: 600; }
.tarjeta-transparente { background-color: rgba(255, 255, 255, 0.9); border-radius: 12px; }
.bg-naranja-principal { background-color: #ff6600 !important; }
.bg-naranja-oscuro { background-color: #e65c00 !important; }
.bg-naranja-claro { background-color: #ffad66 !important; color: #333 !important; }

.btn-naranja-principal { 
    background-color: #ff6600;
    border-color: #ff6600;
    color: white;
}
.btn-secondary-admin {
    background-color: #6c757d;
    border-color: #6c757d;
    color: white;
}
</style>