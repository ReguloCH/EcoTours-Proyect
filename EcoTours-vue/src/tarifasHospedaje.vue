<template>
    <div class="pag-ADMIN-tarifas">
        <menu_ADMIN />

        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Tarifas</h1>
            <h2 class="text-center mb-4 sub-titulo-secundario">
                Tarifas para: {{ nombreProveedor || 'Cargando Proveedor...' }}
            </h2>

            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div class="card-header bg-naranja-principal text-white">
                    <h3 class="card-title mb-0">
                        {{ tarifaEditandoId ? 'Editar Tarifa' : 'Registrar Nueva Tarifa' }}
                    </h3>
                </div>
                <div class="card-body">
                    <form @submit.prevent="agregarOActualizarTarifa">
                        <div class="row g-3">
                            <input type="hidden" v-model="nuevaTarifa.id_hospedaje">

                            <div class="col-md-4">
                                <label for="tipo_habitacion" class="form-label">Tipo de Habitación</label>
                                <select id="tipo_habitacion" class="form-select" v-model="nuevaTarifa.tipo_habitacion" required>
                                    <option value="" disabled>-- Seleccione Tipo --</option>
                                    <option value="Sencilla">Sencilla</option>
                                    <option value="Doble">Doble</option>
                                    <option value="Triple">Triple</option>
                                    <option value="Suite">Suite</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="regimen_comida" class="form-label">Régimen de Comida</label>
                                <select id="regimen_comida" class="form-select" v-model="nuevaTarifa.regimen_comida" required>
                                    <option value="" disabled>-- Seleccione Régimen --</option>
                                    <option value="SA">Solo Alojamiento (SA)</option>
                                    <option value="AD">Alojamiento + Desayuno (AD)</option>
                                    <option value="MP">Media Pensión (MP)</option>
                                    <option value="TI">Todo Incluido (TI)</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="temporada" class="form-label">Temporada</label>
                                <select id="temporada" class="form-select" v-model="nuevaTarifa.temporada" required>
                                    <option value="Baja">Baja</option>
                                    <option value="Media">Media</option>
                                    <option value="Alta">Alta</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="fecha_inicio_vigencia" class="form-label">Fecha Inicio Vigencia</label>
                                <input type="date" class="form-control" id="fecha_inicio_vigencia" v-model="nuevaTarifa.fecha_inicio_vigencia" required>
                            </div>
                            <div class="col-md-6">
                                <label for="fecha_fin_vigencia" class="form-label">Fecha Fin Vigencia</label>
                                <input type="date" class="form-control" id="fecha_fin_vigencia" v-model="nuevaTarifa.fecha_fin_vigencia" required>
                            </div>

                            <div class="col-md-3">
                                <label for="precio_neto_noche" class="form-label">Precio Neto / Noche</label>
                                <input type="number" step="0.01" class="form-control" id="precio_neto_noche" v-model.number="nuevaTarifa.precio_neto_noche" required>
                            </div>
                            <div class="col-md-2">
                                <label for="moneda" class="form-label">Moneda</label>
                                <select id="moneda" class="form-select" v-model="nuevaTarifa.moneda" required>
                                    <option value="USD">USD</option>
                                    <option value="VES">VES</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="impuesto_porcentaje" class="form-label">Impuesto (%)</label>
                                <input type="number" step="0.01" class="form-control" id="impuesto_porcentaje" v-model.number="nuevaTarifa.impuesto_porcentaje">
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
                            <i :class="tarifaEditandoId ? 'bi bi-save-fill' : 'bi bi-plus-circle-fill'" class="me-2"></i>
                            {{ tarifaEditandoId ? 'Guardar Cambios de Tarifa' : 'Registrar Tarifa' }}
                        </button>
                        
                        <button v-if="tarifaEditandoId" @click="limpiarFormulario" type="button" class="btn btn-secondary-admin mt-2 w-100">
                            Cancelar Edición
                        </button>
                    </form>
                </div>
            </div>

            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white">
                    <h3 class="card-title mb-0">Listado de Tarifas Registradas ({{ listaTarifas.length }})</h3>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover tabla-datos">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th>Habitación</th>
                                    <th>Régimen</th>
                                    <th>Temporada</th>
                                    <th>Vigencia</th>
                                    <th>Precio Neto</th>
                                    <th>Comisión (%)</th>
                                    <th>**Tarifa Venta**</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="listaTarifas.length === 0">
                                    <td colspan="8" class="text-center text-muted">No hay tarifas registradas para este hospedaje.</td>
                                </tr>
                                <tr v-else v-for="tarifa in listaTarifas" :key="tarifa.id_tarifa">
                                    <td>{{ tarifa.tipo_habitacion }}</td>
                                    <td>{{ tarifa.regimen_comida }}</td>
                                    <td>{{ tarifa.temporada }}</td>
                                    <td>{{ tarifa.fecha_inicio_vigencia }} a {{ tarifa.fecha_fin_vigencia }}</td>
                                    <td>{{ tarifa.moneda }} {{ tarifa.precio_neto_noche }}</td>
                                    <td>{{ tarifa.comision_agencia_porcentaje || 0 }}%</td>
                                    <td>**{{ tarifa.moneda }} {{ calcularTarifaVenta(tarifa) }}**</td>
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
import { reactive, ref, onMounted } from 'vue';
import { useRoute } from 'vue-router'; // Necesitas Vue Router para obtener el ID de la URL
import menu_ADMIN from './components/menu_ADMIN.vue';
import Footer_Cliente from './components/Footer_Cliente.vue';
// Asume que tienes un servicio de API para hacer las llamadas HTTP (fetch o axios)
import axios from 'axios'; // O tu librería de HTTP preferida

const route = useRoute();
const idHospedaje = ref(route.params.id); // Obtener el ID del proveedor de la URL (Ej: /tarifas/hospedaje/1)

const nombreProveedor = ref('');
const listaTarifas = reactive([]);
const tarifaEditandoId = ref(null); 

// Objeto reactivo para el formulario (usando el mismo estilo que tu código)
const nuevaTarifa = reactive(inicializarTarifa());

function inicializarTarifa() {
    return {
        id_tarifa: 0,
        id_hospedaje: parseInt(idHospedaje.value), // Asignamos el ID del proveedor
        tipo_habitacion: '',
        regimen_comida: 'SA',
        temporada: 'Baja',
        fecha_inicio_vigencia: new Date().toISOString().substr(0, 10),
        fecha_fin_vigencia: '',
        precio_neto_noche: 0.00,
        moneda: 'USD',
        impuesto_porcentaje: 0.00,
        comision_agencia_porcentaje: 10.00, // Valor por defecto
    };
}

// Método de Cálculo Clave: Tarifa de Venta al Público
function calcularTarifaVenta(tarifa = nuevaTarifa) {
    let precio_neto = parseFloat(tarifa.precio_neto_noche || 0);
    let impuesto_perc = parseFloat(tarifa.impuesto_porcentaje || 0);
    let comision_perc = parseFloat(tarifa.comision_agencia_porcentaje || 0);
    
    if (precio_neto <= 0) return `${tarifa.moneda} 0.00`;
    
    // 1. Costo Base (Neto + Impuesto)
    let costo_base = precio_neto * (1 + (impuesto_perc / 100));
    
    // 2. Tarifa Total (Costo Base + Comisión)
    let tarifa_total = costo_base / (1 - (comision_perc / 100)); // Comisión sobre el precio de VENTA
    
    // Si la comisión es sobre el costo, usa: tarifa_total = costo_base * (1 + (comision_perc / 100));

    return `${tarifa.moneda} ${tarifa_total.toFixed(2)}`;
}


// Carga los datos iniciales al montar el componente
onMounted(() => {
    if (idHospedaje.value) {
        cargarDatosProveedor(idHospedaje.value);
        cargarListaTarifas(idHospedaje.value);
    }
});

// Lógica de Conexión al Backend (Axios)

async function cargarDatosProveedor(id) {
    try {
        // Asumiendo la ruta del router de proveedor_hospedaje
        const response = await axios.get(`/api/hospedaje/${id}`); 
        nombreProveedor.value = response.data.nombre_hospedaje;
    } catch (error) {
        console.error('Error al cargar proveedor:', error);
        nombreProveedor.value = 'ERROR: Proveedor No Encontrado';
    }
}

async function cargarListaTarifas(id) {
    try {
        // Asumiendo la ruta del nuevo router de tarifas
        const response = await axios.get(`/api/tarifas/hospedaje/${id}`); 
        // Vaciar y rellenar la lista reactiva
        listaTarifas.splice(0, listaTarifas.length, ...response.data); 
    } catch (error) {
        console.error('Error al cargar lista de tarifas:', error);
    }
}


async function agregarOActualizarTarifa() {
    const dataToSend = { ...nuevaTarifa };
    // Aseguramos que los números se envíen como números, no strings
    dataToSend.precio_neto_noche = parseFloat(dataToSend.precio_neto_noche); 
    dataToSend.impuesto_porcentaje = parseFloat(dataToSend.impuesto_porcentaje || 0); 
    dataToSend.comision_agencia_porcentaje = parseFloat(dataToSend.comision_agencia_porcentaje || 0); 

    try {
        if (tarifaEditandoId.value) {
            // EDICIÓN (PUT)
            await axios.put(`/api/tarifas/hospedaje/${tarifaEditandoId.value}`, dataToSend);
            alert('Tarifa actualizada con éxito.');
        } else {
            // REGISTRO (POST)
            await axios.post('/api/tarifas/hospedaje', dataToSend);
            alert('Tarifa registrada con éxito.');
        }
        
        cargarListaTarifas(idHospedaje.value); // Recargar la tabla
        limpiarFormulario(); // Limpiar y resetear el formulario
    } catch (error) {
        console.error('Error en la operación de tarifa:', error.response?.data || error.message);
        alert('Hubo un error al guardar la tarifa. Revisa la consola para más detalles.');
    }
}

function cargarParaEditar(tarifa) {
    tarifaEditandoId.value = tarifa.id_tarifa;
    
    Object.assign(nuevaTarifa, JSON.parse(JSON.stringify(tarifa)));
}

function limpiarFormulario() {
    Object.assign(nuevaTarifa, inicializarTarifa());
    tarifaEditandoId.value = null;
}

async function eliminarTarifa(id) {
    if (confirm('¿Está seguro de que desea eliminar esta tarifa? Esto es irreversible.')) {
        try {
            await axios.delete(`/api/tarifas/hospedaje/${id}`);
            alert('Tarifa eliminada.');
            cargarListaTarifas(idHospedaje.value);
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

.pag-ADMIN-tarifas {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    background: url('/img/quienes_somos.jpg') no-repeat center center fixed; 
    background-size: cover;
    color: #333;
}

.main-content-admin {
   flex-grow: 1;
}

.titulo-admin {
   color: #fff; 
   text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.8);
   font-weight: 700;
}
.sub-titulo-secundario {
    color: var(--naranja-oscuro);
    font-weight: 600;
}
.tarjeta-transparente {
    background-color: rgba(255, 255, 255, 0.9);
    border-radius: 12px;
}
.bg-naranja-principal { background-color: #ff6600 !important; }
.bg-naranja-oscuro { background-color: #e65c00 !important; }
.bg-naranja-claro { background-color: #ffad66 !important; color: #333 !important; }

.btn-naranja-principal { 
    background-color: #ff6600;
    border-color: #ff6600; 
    color: white; 
    transition: background-color 0.3s, transform 0.2s;
}
.btn-secondary-admin {
    background-color: #6c757d;
    border-color: #6c757d;
    color: white;
    opacity: 1;
}
</style>