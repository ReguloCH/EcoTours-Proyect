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
                        <div class="row g-3 align-items-end">
                            
                            <div class="col-md-4">
                                <label for="id_aerolinea_select" class="form-label">Código de Aerolínea</label>
                                <select id="id_aerolinea_select" class="form-select" v-model.number="nuevaTarifa.id_aerolinea" required>
                                    <option value="" disabled>-- Seleccione Código --</option>
                                    <option v-for="aerolinea in listaAerolineas" :key="aerolinea.id" :value="aerolinea.id">{{ aerolinea.codigo }}</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label for="destino_iata" class="form-label">Destino</label>
                                <select id="destino_iata" class="form-select" v-model="nuevaTarifa.destino_iata" required>
                                    <option value="" disabled>-- Seleccione Destino --</option>
                                    <option v-for="destino in destinosDisponibles" :key="destino" :value="destino">{{ destino }}</option>
                                </select>
                            </div>
                            
                            <div class="col-md-2">
                                <label for="tarifa_base_neta" class="form-label">Precio (I/V)</label>
                                <input type="number" step="0.01" class="form-control" id="tarifa_base_neta" v-model.number="nuevaTarifa.tarifa_base_neta" required>
                            </div>
                            
                            <div class="col-md-2">
                                 <button type="submit" class="btn btn-naranja-principal w-100">
                                    <i class="bi bi-plus-circle me-1"></i> Registrar
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
                    <h3 class="card-title mb-0">Listado de Tarifas Aéreas ({{ listaTarifas.length }})</h3>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover tabla-datos">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th>Aerolínea</th>
                                    <th>Destino</th>
                                    <th>Tipo</th>
                                    <th>**Precio (I/V)**</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="listaTarifas.length === 0">
                                    <td colspan="5" class="text-center text-muted">No hay tarifas registradas.</td>
                                </tr>
                                <tr v-else v-for="tarifa in listaTarifas" :key="tarifa.id_tarifa_aerea">
                                    <td>{{ obtenerCodigoAerolinea(tarifa.id_aerolinea) }}</td> 
                                    <td>{{ tarifa.destino_iata }}</td>
                                    <td>Ida y Vuelta</td> 
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
const idAerolinea = ref(route.params.id); 

// Lista de Destinos Disponibles 
const destinosDisponibles = [
    'MIA - Miami', 'PTY - Ciudad de Panamá', 'MAD - Madrid', 'BOG - Bogotá', 'SDQ - Santo Domingo', 'GYE - Guayaquil'
];

// Lista de Aerolíneas Simulada (Necesaria para el Select)
const listaAerolineas = [
    { id: 101, codigo: 'AVA', nombre: 'Avianca' },
    { id: 102, codigo: 'AA', nombre: 'American Airlines' },
    { id: 103, codigo: 'LA', nombre: 'Latam' },
    { id: 104, codigo: 'CO', nombre: 'Conviasa' },
];

const nombreProveedor = ref('');
const listaTarifas = reactive([]);
const tarifaEditandoId = ref(null); 
const API_URL = '/api/tarifas-aerolineas';
const API_PROV = '/api/aerolineas';

const nuevaTarifa = reactive(inicializarTarifa());

// FUNCIÓN INICIALIZAR TARIFA (SIMPLIFICADA)
function inicializarTarifa() {
    return {
        id_tarifa_aerea: 0,
        // Usamos el ID de la URL o el primer ID de la lista por defecto
        id_aerolinea: idAerolinea.value ? parseInt(idAerolinea.value) : listaAerolineas[0]?.id || 0, 
        origen_iata: 'CCS', 
        destino_iata: '',
        clase_vuelo: 'Económica', 
        tipo_viaje: 'Ida y Vuelta', 
        fecha_inicio_vigencia: new Date().toISOString().substr(0, 10),
        fecha_fin_vigencia: '2099-12-31', 
        tarifa_base_neta: 0.00,
        impuestos_y_tasas: 0.00, 
        moneda: 'USD',
        comision_agencia_porcentaje: 0.00, 
    };
}

// CÁLCULO DE TARIFA VENTA (SIMPLIFICADO: es solo la tarifa base)
function calcularTarifaVenta(tarifa = nuevaTarifa) {
    return `${tarifa.moneda || 'USD'} ${parseFloat(tarifa.tarifa_base_neta || 0).toFixed(2)}`;
}

// Función para buscar el código de la aerolínea por su ID (PARA EL LISTADO)
function obtenerCodigoAerolinea(id) {
    const aerolinea = listaAerolineas.find(a => a.id === id);
    return aerolinea ? aerolinea.codigo : 'N/A';
}


onMounted(() => {
    // Si la vista se carga por ID, cargamos los datos del proveedor y las tarifas
    if (idAerolinea.value) {
        cargarDatosProveedor(idAerolinea.value);
        cargarListaTarifas(idAerolinea.value);
    }
    // Si la aerolínea no está seleccionada, forzamos la inicialización con el primer elemento de la lista
    if (!nuevaTarifa.id_aerolinea && listaAerolineas.length > 0) {
        nuevaTarifa.id_aerolinea = listaAerolineas[0].id;
    }
});

// --- Lógica de CRUD (Se mantiene) ---

async function cargarDatosProveedor(id) {
    try {
        const response = await axios.get(`${API_PROV}/${id}`); 
        // Mostrar el nombre de la aerolínea seleccionada o cargada por URL
        nombreProveedor.value = response.data.nombre_aerolinea || 'Aerolínea (Sin Nombre)'; 
    } catch (error) {
        console.error('Error al cargar proveedor:', error);
        nombreProveedor.value = 'ERROR: Aerolínea No Encontrada';
    }
}

async function cargarListaTarifas(id) {
    try {
        // En una aplicación real, aquí podrías querer cargar todas las tarifas
        // y filtrarlas si no quieres depender del ID de la URL
        const response = await axios.get(`${API_URL}/${id}`); 
        listaTarifas.splice(0, listaTarifas.length, ...response.data); 
    } catch (error) {
        console.error('Error al cargar lista de tarifas:', error);
    }
}


async function agregarOActualizarTarifa() {
    const dataToSend = { ...nuevaTarifa };

    if (!dataToSend.id_aerolinea) {
        alert('Por favor, selecciona un Código de Aerolínea.');
        return;
    }

    try {
        if (tarifaEditandoId.value) {
            await axios.put(`${API_URL}/${tarifaEditandoId.value}`, dataToSend);
            alert('Tarifa aérea actualizada con éxito.');
        } else {
            await axios.post(API_URL, dataToSend);
            alert('Tarifa aérea registrada con éxito.');
        }
        
        cargarListaTarifas(dataToSend.id_aerolinea); 
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
            await axios.delete(`${API_URL}/${id}`);
            alert('Tarifa eliminada.');
            cargarListaTarifas(nuevaTarifa.id_aerolinea);
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