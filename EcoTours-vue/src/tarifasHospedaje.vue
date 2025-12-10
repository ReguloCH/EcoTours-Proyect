<template>
    <div class="pag-ADMIN-tarifas">
        <menu_ADMIN />

        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Registro de Tarifa por Alojamiento</h1>
            
            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div class="card-header bg-naranja-principal text-white">
                    <h3 class="card-title mb-0">
                        {{ tarifaEditandoId ? 'Editar Tarifa' : 'Registrar Tarifa de Hospedaje' }}
                    </h3>
                </div>
                <div class="card-body">
                    <form @submit.prevent="agregarOActualizarTarifa">
                        <div class="row g-3 align-items-end">
                            
                            <div class="col-md-4">
                                <label for="id_hospedaje_select" class="form-label">Hospedaje</label>
                                <select id="id_hospedaje_select" class="form-select" v-model.number="nuevaTarifa.id_hospedaje" required @change="actualizarDireccion">
                                    <option value="" disabled>-- Seleccione Hospedaje --</option>
                                    <option v-for="hospedaje in listaHospedajes" :key="hospedaje.id" :value="hospedaje.id">{{ hospedaje.nombre }}</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label for="direccion_hospedaje" class="form-label">Dirección</label>
                                <input type="text" class="form-control" id="direccion_hospedaje" :value="direccionHospedaje" disabled>
                            </div>
                            
                            <div class="col-md-2">
                                <label for="precio_neto_noche" class="form-label">Precio por Día (VES)</label>
                                <input type="number" step="0.01" class="form-control" id="precio_neto_noche" v-model.number="nuevaTarifa.precio_neto_noche" required>
                            </div>
                            
                            <div class="col-md-2">
                                 <button type="submit" class="btn btn-naranja-principal w-100">
                                    <i :class="tarifaEditandoId ? 'bi bi-save-fill' : 'bi bi-plus-circle-fill'" class="me-1"></i> 
                                    {{ tarifaEditandoId ? 'Guardar' : 'Registrar' }}
                                </button>
                            </div>
                            
                        </div>
                    </form>
                    
                    <button v-if="tarifaEditandoId" @click="limpiarFormulario" type="button" class="btn btn-secondary-admin mt-2 w-100">
                        Cancelar Edición
                    </button>
                </div>
            </div>

            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white">
                    <h3 class="card-title mb-0">Listado de Tarifas Registradas ({{ tarifasFiltradas.length }})</h3>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover tabla-datos">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th>Hospedaje</th>
                                    <th>Dirección</th>
                                    <th>**Precio por Día (VES)**</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="tarifasFiltradas.length === 0">
                                    <td colspan="4" class="text-center text-muted">No hay tarifas registradas o tarifas válidas para mostrar.</td>
                                </tr>
                                <tr v-else v-for="tarifa in tarifasFiltradas" :key="tarifa.id_tarifa">
                                    <td>{{ obtenerNombreHospedaje(tarifa.id_hospedaje) }}</td>
                                    <td>{{ obtenerDireccionHospedaje(tarifa.id_hospedaje) }}</td> 
                                    <td>**VES {{ parseFloat(tarifa.precio_neto_noche || 0).toFixed(2) }}**</td>
                                    <td>
                                        <button @click="cargarParaEditar(tarifa)" class="btn btn-sm btn-warning me-2" title="Editar">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <button @click="eliminarTarifa(tarifa.id_tarifa)" class="btn btn-sm btn-danger" title="Eliminar">
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
import { reactive, ref, onMounted, watch, computed } from 'vue';
import { useRoute } from 'vue-router'; 
import menu_ADMIN from './components/menu_ADMIN.vue';
import Footer_Cliente from './components/Footer_Cliente.vue';
import axios from 'axios'; 

const route = useRoute();
const idHospedajeInicial = route.params.id ? ref(parseInt(route.params.id)) : ref(null); 

// Lista Simulada de Hospedajes
const listaHospedajes = [
    { id: 1, nombre: 'Hotel Mariposa Dorada', direccion: 'Av. Principal, Sector El Bosque, Valencia' },
    { id: 2, nombre: 'Posada Sol y Arena', direccion: 'Calle 5, Playa Grande, Choroní' },
    { id: 3, nombre: 'Suite Ejecutiva Caracas', direccion: 'Torre Central, Av. Libertador, Caracas' },
];

const direccionHospedaje = ref('');
const nombreProveedor = ref('');
const listaTarifas = reactive([]);
const tarifaEditandoId = ref(null); 

const API_URL = '/api/tarifas/hospedaje';
const API_PROV = '/api/hospedaje';

const nuevaTarifa = reactive(inicializarTarifa());

// PROPIEDAD COMPUTADA: Filtra las tarifas con precio cero (VES 0.00)
const tarifasFiltradas = computed(() => {
    // Solo muestra las entradas que tienen precio_neto_noche > 0
    return listaTarifas.filter(tarifa => parseFloat(tarifa.precio_neto_noche || 0) > 0);
});

// FUNCIÓN INICIALIZAR TARIFA 
function inicializarTarifa() {
    return {
        id_tarifa: 0,
        id_hospedaje: idHospedajeInicial.value || (listaHospedajes.length > 0 ? listaHospedajes[0].id : null), 
        precio_neto_noche: 0.00,
        moneda: 'VES',
    };
}

// FUNCIONES DE BÚSQUEDA PARA LA TABLA
function obtenerNombreHospedaje(id) {
    const hosp = listaHospedajes.find(h => h.id === id);
    return hosp ? hosp.nombre : 'N/A';
}

function obtenerDireccionHospedaje(id) {
    const hosp = listaHospedajes.find(h => h.id === id);
    return hosp ? hosp.direccion : 'N/A';
}

// Lógica para actualizar la dirección mostrada al cambiar el select
function actualizarDireccion() {
    const id = nuevaTarifa.id_hospedaje;
    const hosp = listaHospedajes.find(h => h.id === id);
    direccionHospedaje.value = hosp ? hosp.direccion : '';
    cargarListaTarifas(id);
}

// Watch para asegurar que la dirección se carga al inicio o al cambiar el ID
watch(() => nuevaTarifa.id_hospedaje, (newId) => {
    if (newId) {
        actualizarDireccion();
    }
}, { immediate: true });

onMounted(() => {
    if (!tarifaEditandoId.value && nuevaTarifa.id_hospedaje) {
        actualizarDireccion();
        cargarListaTarifas(nuevaTarifa.id_hospedaje);
    }
});

// --- Lógica de CRUD ---

async function cargarListaTarifas(id) {
    if (!id) return;
    try {
        const response = await axios.get(`${API_URL}/${id}`); 
        listaTarifas.splice(0, listaTarifas.length, ...response.data); 
    } catch (error) {
        console.error('Error al cargar lista de tarifas:', error);
        listaTarifas.splice(0, listaTarifas.length);
    }
}


async function agregarOActualizarTarifa() {
    const dataToSend = { 
        id_tarifa: nuevaTarifa.id_tarifa,
        id_hospedaje: nuevaTarifa.id_hospedaje,
        precio_neto_noche: parseFloat(nuevaTarifa.precio_neto_noche || 0),
        moneda: 'VES',
    };

    if (!dataToSend.id_hospedaje || dataToSend.precio_neto_noche <= 0) {
        alert('Por favor, seleccione un Hospedaje e ingrese un Precio válido.');
        return;
    }

    try {
        if (tarifaEditandoId.value) {
            await axios.put(`${API_URL}/${tarifaEditandoId.value}`, dataToSend);
            alert('Tarifa actualizada con éxito.');
        } else {
            await axios.post(API_URL, dataToSend);
            alert('Tarifa registrada con éxito.');
        }
        
        cargarListaTarifas(dataToSend.id_hospedaje); 
        limpiarFormulario(); 
    } catch (error) {
        console.error('Error en la operación de tarifa:', error.response?.data || error.message);
        alert('Hubo un error al guardar la tarifa. Revisa la consola para más detalles.');
    }
}

function cargarParaEditar(tarifa) {
    tarifaEditandoId.value = tarifa.id_tarifa;
    nuevaTarifa.id_tarifa = tarifa.id_tarifa;
    nuevaTarifa.id_hospedaje = tarifa.id_hospedaje;
    nuevaTarifa.precio_neto_noche = tarifa.precio_neto_noche;
    nuevaTarifa.moneda = 'VES';
    actualizarDireccion(); 
}

function limpiarFormulario() {
    const currentId = nuevaTarifa.id_hospedaje; 
    Object.assign(nuevaTarifa, inicializarTarifa());
    if (currentId) {
        nuevaTarifa.id_hospedaje = currentId;
    }
    tarifaEditandoId.value = null;
    actualizarDireccion(); 
}

async function eliminarTarifa(id) {
    if (confirm('¿Está seguro de que desea eliminar esta tarifa?')) {
        try {
            await axios.delete(`${API_URL}/${id}`);
            alert('Tarifa eliminada.');
            cargarListaTarifas(nuevaTarifa.id_hospedaje);
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
/* ESTILOS (Sin cambios) */
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