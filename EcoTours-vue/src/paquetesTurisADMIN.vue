<template>
    <div class="pag-ADMIN-paquetes">

        <!-- NOTA: Se asume que los componentes Sidebar_Admin y Footer_Admin existen -->

        <Sidebar_Admin />

        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Paquetes Turísticos</h1>

            <!-- Mensaje de Notificación (Reemplaza alert() / Se borra tras 4 segundos) -->
            <div v-if="message" :class="['alert mb-5', messageType === 'success' ? 'alert-success' : (messageType === 'danger' ? 'alert-danger' : 'alert-info')]" role="alert">
                {{ message }}
            </div>

            <!-- Bloque de Registro/Edición -->
            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div :class="['card-header text-white', paqueteEditando ? 'bg-naranja-oscuro' : 'bg-naranja-principal']">
                    <h3 class="card-title mb-0">
                        {{ paqueteEditando ? 'Editando Paquete (ID: ' + nuevoPaquete.id + ')' : 'Registrar Nuevo Paquete' }}
                    </h3>
                </div>
                <div class="card-body">
                    <form @submit.prevent="paqueteEditando ? guardarEdicion() : agregarPaquete()">

                        <!-- Bloque Principal de Información del Paquete -->
                        <div class="row g-3 mb-4">
                            <!-- Destino (Ahora Select con opciones predefinidas) -->
                            <div class="col-md-5">
                                <label for="destino" class="form-label">Destino del Paquete</label>
                                <select id="destino" class="form-select" v-model="nuevoPaquete.destino" required>
                                    <option value="" disabled>-- Seleccione Destino --</option>
                                    <option value="Los Roques">Los Roques</option>
                                    <option value="Margarita">Margarita</option>
                                    <option value="El Salto Ángel">El Salto Ángel</option>
                                    <option value="Mérida">Mérida</option>
                                </select>
                            </div>
                            <!-- Duración (Se Mantiene) -->
                            <div class="col-md-4">
                                <label for="duracion" class="form-label">Duración del Viaje (días/noches)</label>
                                <input type="text" class="form-control" id="duracion" v-model="nuevoPaquete.duracion" required placeholder="Ej: 3 días / 2 noches">
                            </div>
                            <!-- Cantidad de Personas (Nuevo) -->
                            <div class="col-md-3">
                                <label for="cantidadPersonas" class="form-label text-naranja">Cantidad de Personas</label>
                                <input type="number" class="form-control" id="cantidadPersonas" v-model.number="nuevoPaquete.cantidadPersonas" min="1" required>
                            </div>
                            
                            <!-- Descripción del Paquete (Nuevo, ocupa el ancho completo) -->
                            <div class="col-md-12">
                                <label for="descripcion" class="form-label">Descripción del Paquete</label>
                                <textarea class="form-control" id="descripcion" v-model="nuevoPaquete.descripcion" rows="3" required placeholder="Detalle las actividades, tipo de hospedaje y otros servicios."></textarea>
                            </div>
                        </div>

                        <hr class="my-4 border-naranja">
                        <h4 class="text-naranja-oscuro mb-3"><i class="bi bi-tag-fill me-2"></i>Selección de Tarifas por Proveedor (Costo Unitario)</h4>

                        <!-- Bloque de Selección de Tarifas -->
                        <div class="row g-3">

                            <!-- Tarifa Aérea -->
                            <div class="col-md-4">
                                <label for="tarifaAerea" class="form-label text-naranja">1. Tarifa de Boleto Aéreo</label>
                                <select id="tarifaAerea" class="form-select" v-model="nuevoPaquete.idTarifaAerea" required>
                                    <option value="" disabled>-- Seleccione Boleto Aéreo --</option>
                                    <option v-for="t in listaBoletosAereos" :key="t.id_tarifa_aerolinea" :value="t.id_tarifa_aerolinea">
                                        {{ t.ProveedorAerolinea ? t.ProveedorAerolinea.nombre_aerolinea : 'Aerolínea' }} 
                                        ({{ t.DestinoManejado ? t.DestinoManejado.ciudad_origen + ' -> ' + t.DestinoManejado.ciudad_destino : 'Vuelo' }}) 
                                        - Base: ${{ t.precio_vuelos }}
                                    </option>
                                </select>
                            </div>

                            <!-- Tarifa Hospedaje -->
                            <div class="col-md-4">
                                <label for="tarifaHospedaje" class="form-label text-naranja">2. Tarifa de Hospedaje</label>
                                <select id="tarifaHospedaje" class="form-select" v-model="nuevoPaquete.idTarifaHospedaje" required>
                                    <option value="" disabled>-- Seleccione Oferta de Hospedaje --</option>
                                    <option v-for="t in listaOfertasHospedaje" :key="t.id_tarifa_hospedaje" :value="t.id_tarifa_hospedaje">
                                        {{ t.ProveedorHospedaje ? t.ProveedorHospedaje.nombre_hospedaje : 'Hotel' }} 
                                        ({{ t.TipoHospedaje ? t.TipoHospedaje.nombre_tipo : 'Habitacion' }}) 
                                        - Base: ${{ t.precio_x_noche }}
                                    </option>
                                </select>
                            </div>

                            <!-- Tarifa Restaurante (Ahora Obligatorio en todos los paquetes) -->
                            <div class="col-md-4">
                                <label for="tarifaRestaurante" class="form-label text-naranja">3. Plan de Restaurante (Obligatorio)</label>
                                <select id="tarifaRestaurante"
                                        class="form-select"
                                        v-model="nuevoPaquete.idTarifaRestaurante"
                                        required>
                                    <option value="" disabled>-- Seleccione Plan de Comidas --</option>
                                    <option v-for="t in listaPlanesAlimentacion" :key="t.id_tarifa_restaurante" :value="t.id_tarifa_restaurante">
                                        {{ t.ProveedorRestaurante ? t.ProveedorRestaurante.nombre_restaurante : 'Restaurante' }} 
                                        ({{ t.nombre_platillo }}) - Base: ${{ t.costo_unitario }}
                                    </option>
                                </select>
                            </div>

                            <!-- URL de Imagen (Selección) -->
                            <div class="col-md-12">
                                <label for="imagenURL" class="form-label">Seleccionar Imagen del Paquete</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-image"></i></span>
                                    <select id="imagenURL" class="form-select" v-model="nuevoPaquete.imagenURL" required>
                                        <option value="" disabled>-- Seleccione una Imagen --</option>
                                        <option v-for="img in listaImagenes" :key="img" :value="'/img/' + img">
                                            {{ img }}
                                        </option>
                                    </select>
                                </div>
                                <!-- Previsualización pequeña -->
                                <div v-if="nuevoPaquete.imagenURL" class="mt-2">
                                    <img :src="nuevoPaquete.imagenURL" alt="Vista previa" style="height: 100px; border-radius: 8px; border: 2px solid #ddd;">
                                </div>
                            </div>
                        </div>

                        <!-- Bloque de Cálculos Automáticos -->
                        <div class="row g-3 mt-4 p-3 border rounded-3 bg-light">
                            <h5 class="text-naranja-oscuro"><i class="bi bi-calculator-fill me-2"></i>Detalle de Costos (Cálculo Automático - UNITARIO)</h5>

                            <!-- Costo Base Unitario -->
                            <div class="col-md-4">
                                <label class="form-label fw-bold">1. Costo Base Unitario (Por Persona)</label>
                                <input type="text" class="form-control fw-bold" :value="`$${costoBaseUnitario.toFixed(2)}`" disabled>
                            </div>
                            <!-- IVA (16%) Unitario -->
                            <div class="col-md-4">
                                <label class="form-label text-primary">2. IVA ({{ IVA * 100 }}%) Unitario</label>
                                <input type="text" class="form-control text-primary" :value="`$${montoIVAUnitario.toFixed(2)}`" disabled>
                            </div>
                            <!-- Ganancia (40%) Unitario -->
                            <div class="col-md-4">
                                <label class="form-label text-success">3. Ganancia ({{ PORCENTAJE_GANANCIA * 100 }}%) Unitario</label>
                                <input type="text" class="form-control text-success" :value="`$${montoGananciaUnitario.toFixed(2)}`" disabled>
                            </div>

                            <!-- Precio Final TOTAL (Multiplicado por Cantidad de Personas) -->
                            <div class="col-12 mt-3">
                                <div class="alert alert-warning text-center fw-bold fs-5 mb-0 shadow-sm">
                                    PRECIO FINAL DE VENTA: ${{ precioFinalVenta.toFixed(2) }} (Total para {{ nuevoPaquete.cantidadPersonas }} persona(s))
                                </div>
                            </div>
                        </div>

                        <!-- Botón de Acción (Registrar o Guardar Cambios) -->
                        <div class="d-flex justify-content-between mt-4">
                            <button type="submit" :disabled="!costoBaseUnitario" :class="['btn w-75 me-2', paqueteEditando ? 'btn-naranja-oscuro' : 'btn-naranja-principal']">
                                <i :class="['bi me-2', paqueteEditando ? 'bi-save-fill' : 'bi-plus-square-fill']"></i>
                                {{ paqueteEditando ? 'Guardar Cambios' : 'Registrar Paquete Turístico' }}
                            </button>
                            <button v-if="paqueteEditando" type="button" class="btn btn-secondary w-25" @click="cancelarEdicion">
                                Cancelar
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Bloque de Listado, Filtro y Tabla -->
            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white">
                    <h3 class="card-title mb-0">Paquetes Registrados (Total: {{ paquetesFiltrados.length }})</h3>
                </div>
                <div class="card-body p-3">
                    <!-- Filtro por Destino -->
                    <div class="row mb-3">
                        <div class="col-md-6 offset-md-6">
                            <label for="filtroDestino" class="form-label visually-hidden">Filtrar por Destino</label>
                            <div class="input-group">
                                <span class="input-group-text bg-naranja-claro" id="basic-addon1"><i class="bi bi-search"></i></span>
                                <input type="text"
                                        id="filtroDestino"
                                        class="form-control"
                                        placeholder="Buscar por Destino de Viaje..."
                                        v-model="filtroDestino">
                            </div>
                        </div>
                    </div>
                    <!-- Fin Filtro -->

                    <div class="table-responsive">
                        <table class="table table-striped table-hover tabla-datos">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th rowspan="2" class="align-middle">ID</th>
                                    <th rowspan="2" class="align-middle">Destino</th>
                                    <th rowspan="2" class="align-middle">Duración</th>
                                    <th rowspan="2" class="align-middle">Personas</th>
                                    <th colspan="3" class="text-center">Detalle de Proveedores</th>
                                    <th colspan="4" class="text-center">Desglose Financiero (Unitario/Total USD)</th>
                                    <th rowspan="2" class="align-middle">Acciones</th>
                                </tr>
                                <tr>
                                    <th>Aéreo</th>
                                    <th>Hospedaje</th>
                                    <th>Restaurante</th>
                                    <th>Costo Base (Unitario)</th>
                                    <th>IVA (16%) Unitario</th>
                                    <th>Ganancia (40%) Unitario</th>
                                    <th class="text-warning">Precio Final (Total)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="paquetesFiltrados.length === 0">
                                    <td colspan="11" class="text-center text-muted">
                                        {{ filtroDestino ? 'No hay paquetes que coincidan con el destino.' : 'Aún no se han creado paquetes turísticos.' }}
                                    </td>
                                </tr>
                                <tr v-else v-for="paquete in paquetesFiltrados" :key="paquete.id">
                                    <td>{{ paquete.id }}</td>
                                    <td>{{ paquete.destino }}</td>
                                    <td>{{ paquete.duracion }}</td>
                                    <td class="fw-bold">{{ paquete.cantidadPersonas }}</td>

                                    <!-- Detalle de Proveedores -->
                                    <td>{{ getTarifaNombre(paquete.idTarifaAerea, 'aereo') }}</td>
                                    <td>{{ getTarifaNombre(paquete.idTarifaHospedaje, 'hospedaje') }}</td>
                                    <td>
                                        {{ getTarifaNombre(paquete.idTarifaRestaurante, 'alimentacion') }}
                                    </td>

                                    <!-- Desglose Financiero (Unitario y Total) -->
                                    <td>${{ (paquete.costoBaseUnitario || 0).toFixed(2) }}</td>
                                    <td class="text-primary">${{ (paquete.montoIVAUnitario || 0).toFixed(2) }}</td>
                                    <td class="text-success">${{ (paquete.montoGananciaUnitario || 0).toFixed(2) }}</td>
                                    <td class="fw-bold text-warning">${{ (paquete.precioFinalVenta || 0).toFixed(2) }}</td>

                                    <!-- Botones de Acción (Editar y Eliminar) -->
                                    <td>
                                        <div class="btn-group" role="group">
                                            <button @click="iniciarEdicion(paquete)" class="btn btn-sm btn-outline-info me-1" title="Editar Paquete">
                                                <i class="bi bi-pencil-square"></i>
                                            </button>
                                            <button @click="confirmarEliminar(paquete.id, paquete.destino)" class="btn btn-sm btn-outline-danger" title="Eliminar Paquete">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Modal de Confirmación para Eliminar (Reemplazo de window.confirm) -->
            <div v-if="paqueteAEliminar" class="modal-backdrop-custom">
                <div class="modal-dialog-custom">
                    <div class="card shadow-lg">
                        <div class="card-header bg-danger text-white">
                            <h5 class="mb-0">Confirmación de Eliminación</h5>
                        </div>
                        <div class="card-body">
                            <p>¿Está seguro de que desea eliminar el paquete **{{ paqueteAEliminarNombre }}**? Esta acción es irreversible.</p>
                        </div>
                        <div class="card-footer d-flex justify-content-end">
                            <button @click="paqueteAEliminar = null" class="btn btn-secondary me-2">Cancelar</button>
                            <button @click="ejecutarEliminacion()" class="btn btn-danger">Eliminar</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>




        <Footer_Admin />
    </div>
</template>

<script setup>
import { reactive, ref, computed, watch, onMounted } from 'vue';
import axios from 'axios';
import Sidebar_Admin from './components/Sidebar_Admin.vue';
import Footer_Admin from './components/Footer_Admin.vue';

// --- CONSTANTES DE CÁLCULO ---
const IVA = 0.16;
const PORCENTAJE_GANANCIA = 0.40;

// Lista de imágenes disponibles en /public/img
const listaImagenes = [
    "paquete1.jpg", "paquete2.jpg", "paquete3.jpg", "paquete4.jpg", "paquete5.jpg", 
    "paquete6.jpg", "paquete7.jpg", "paquete8.jpg", "paquete9.jpg", "paqueteTURISTICO.jpg",
    "losROQUES.jpg", "maracaibo.jpg", "valencia.jpg", "caracas.webp", "playa-en-margarita.webp",
    "oferta1.jpg", "oferta2.jpg", "oferta3.jpg", "oferta4.jpg", "oferta5.jpg", "oferta6.jpg"
];

// --- ESTADO ---
const message = ref(null);
const messageType = ref('success');
const filtroDestino = ref('');
const paqueteEditando = ref(null);

// Modal de eliminación
const paqueteAEliminar = ref(null);
const paqueteAEliminarNombre = ref('');

// Listas de datos reales (desde Backend)
const listaBoletosAereos = ref([]);
const listaOfertasHospedaje = ref([]);
const listaPlanesAlimentacion = ref([]);
const listaPaquetes = ref([]);

// Objeto para consolidar todas las tarifas para búsqueda rápida en la tabla
const todasLasTarifas = computed(() => {
    // Mapeamos para unificar estructura si es necesario
    const aereos = listaBoletosAereos.value.map(t => ({
        id: t.id_tarifa_aerolinea, // ID de la tabla tarifa_por_destino
        proveedor: t.ProveedorAerolinea ? t.ProveedorAerolinea.nombre_aerolinea : 'Aerolínea',
        detalle: t.DestinoManejado ? `${t.DestinoManejado.ciudad_origen} -> ${t.DestinoManejado.ciudad_destino}` : 'Vuelo',
        costoBaseUSD: parseFloat(t.precio_vuelos || 0),
        tipo: 'aereo'
    }));
    
    const hospedajes = listaOfertasHospedaje.value.map(t => ({
        id: t.id_tarifa_hospedaje,
        proveedor: t.ProveedorHospedaje ? t.ProveedorHospedaje.nombre_hospedaje : 'Hotel',
        detalle: t.TipoHospedaje ? t.TipoHospedaje.nombre_tipo : 'Hospedaje', // O descripción
        costoBaseUSD: parseFloat(t.precio_por_dia || 0), // CORREGIDO: Usar precio_por_dia
        tipo: 'hospedaje'
    }));

    const restaurantes = listaPlanesAlimentacion.value.map(t => ({
        id: t.id_tarifa_restaurante,
        proveedor: t.ProveedorRestaurante ? t.ProveedorRestaurante.nombre_restaurante : 'Restaurante',
        detalle: t.nombre_platillo || 'Comida', // Ojo: nombre_platillo no existe en modelo? Revisar.
        // Si modelo restaurante no tiene detalle de comida, usar nombre genérico
        costoBaseUSD: parseFloat(t.precio_por_dia || 0), // CORREGIDO: Usar precio_por_dia (era costo_unitario)
        tipo: 'alimentacion'
    }));

    return [...aereos, ...hospedajes, ...restaurantes];
});

// Función para inicializar el formulario
function inicializarPaquete() {
    return {
        id: 0,
        destino: '', 
        duracion: '',
        descripcion: '',
        cantidadPersonas: 1,
        idTarifaAerea: '',
        idTarifaHospedaje: '',
        idTarifaRestaurante: '',
        imagenURL: '',
        costoBaseUnitario: 0,
        montoIVAUnitario: 0,
        montoGananciaUnitario: 0,
        precioFinalVenta: 0,
    };
}

const nuevoPaquete = reactive(inicializarPaquete());

// --- CARGA DE DATOS (ON MOUNTED) ---
onMounted(async () => {
    await cargarDatos();
});

async function cargarDatos() {
    try {
        // Cargar Tarifas y Paquetes en paralelo
        const [resAereos, resHospedajes, resRestaurantes, resPaquetes] = await Promise.all([
            axios.get('http://localhost:3000/api/tarifa-por-destino'),
            axios.get('http://localhost:3000/api/tarifa-hospedaje'),
            axios.get('http://localhost:3000/api/tarifa-restaurante'),
            axios.get('http://localhost:3000/api/paquete-turistico')
        ]);

        listaBoletosAereos.value = resAereos.data;
        listaOfertasHospedaje.value = resHospedajes.data;
        listaPlanesAlimentacion.value = resRestaurantes.data;
        
        // Mapear los paquetes recibidos para que coincidan con la estructura interna del frontend
        // El backend devuelve snake_case (destino_paquete, id_tarifa_aerolinea, etc.)
        listaPaquetes.value = resPaquetes.data.map(p => ({
            id: p.id_paquete,
            destino: p.destino_paquete,
            duracion: p.duracion_paquete,
            descripcion: p.descripcion_paquete,
            cantidadPersonas: p.cantidad_personas,
            idTarifaAerea: p.id_tarifa_aerolinea,
            idTarifaHospedaje: p.id_tarifa_hospedaje,
            idTarifaRestaurante: p.id_tarifa_restaurante,
            // imagenURL: p.imagen_url, // Si agregas este campo al backend
            costoBaseUnitario: parseFloat(p.subtotal), // Asumimos subtotal unitario
            // Recalculamos o usamos lo del backend
            precioFinalVenta: parseFloat(p.total_con_iva), 
            // Campos calculados visuales (opcional recalcular)
            montoIVAUnitario: parseFloat(p.subtotal) * IVA,
            montoGananciaUnitario: parseFloat(p.subtotal) * PORCENTAJE_GANANCIA
        }));

    } catch (error) {
        console.error('Error cargando datos:', error);
        mostrarMensaje('Error al conectar con el servidor.', 'danger');
    }
}

// --- LÓGICA DE CÁLCULO ---

function findTarifa(id, lista, idField, costoField) {
    if(!id) return null;
    return lista.find(t => t[idField] === id);
}

// Computadas para obtener el objeto tarifa seleccionado real
// Nota: Usamos los IDs correctos de la BD (id_tarifa_aerolinea, etc)
const tarifaAereaObj = computed(() => findTarifa(nuevoPaquete.idTarifaAerea, listaBoletosAereos.value, 'id_tarifa_aerolinea'));
const tarifaHospedajeObj = computed(() => findTarifa(nuevoPaquete.idTarifaHospedaje, listaOfertasHospedaje.value, 'id_tarifa_hospedaje'));
const tarifaRestauranteObj = computed(() => findTarifa(nuevoPaquete.idTarifaRestaurante, listaPlanesAlimentacion.value, 'id_tarifa_restaurante'));

// 1. Costo Base Unitario
const costoBaseUnitario = computed(() => {
    let base = 0;
    if (tarifaAereaObj.value) base += parseFloat(tarifaAereaObj.value.precio_vuelos || 0);
    if (tarifaHospedajeObj.value) base += parseFloat(tarifaHospedajeObj.value.precio_por_dia || 0); // CORREGIDO
    if (tarifaRestauranteObj.value) base += parseFloat(tarifaRestauranteObj.value.precio_por_dia || 0); // CORREGIDO
    return base;
});

const montoIVAUnitario = computed(() => costoBaseUnitario.value * IVA);
const montoGananciaUnitario = computed(() => costoBaseUnitario.value * PORCENTAJE_GANANCIA);

// Precio Final Total
const precioFinalVenta = computed(() => 
    (costoBaseUnitario.value + montoIVAUnitario.value + montoGananciaUnitario.value) * (nuevoPaquete.cantidadPersonas || 1)
);

// Watcher para actualizar el formulario visual
watch([precioFinalVenta, () => nuevoPaquete.cantidadPersonas], () => {
    nuevoPaquete.costoBaseUnitario = costoBaseUnitario.value;
    nuevoPaquete.montoIVAUnitario = montoIVAUnitario.value;
    nuevoPaquete.montoGananciaUnitario = montoGananciaUnitario.value;
    nuevoPaquete.precioFinalVenta = precioFinalVenta.value;
});

// --- FILTRO ---
const paquetesFiltrados = computed(() => {
    if (!filtroDestino.value) return listaPaquetes.value;
    const filtro = filtroDestino.value.toLowerCase().trim();
    return listaPaquetes.value.filter(p => p.destino.toLowerCase().includes(filtro));
});

function getTarifaNombre(id, tipo) {
    const t = todasLasTarifas.value.find(item => item.id === id && item.tipo === tipo);
    return t ? `${t.proveedor} (${t.detalle})` : 'N/A';
}

// --- CRUD ---

async function agregarPaquete() {
    if (!nuevoPaquete.idTarifaRestaurante) {
        mostrarMensaje('Debe seleccionar restaurante.', 'danger');
        return;
    }

    try {
        // Payload snake_case para backend
        const payload = {
            destino_paquete: nuevoPaquete.destino,
            duracion_paquete: nuevoPaquete.duracion,
            cantidad_personas: nuevoPaquete.cantidadPersonas,
            descripcion_paquete: nuevoPaquete.descripcion,
            id_tarifa_aerolinea: nuevoPaquete.idTarifaAerea,
            id_tarifa_hospedaje: nuevoPaquete.idTarifaHospedaje,
            id_tarifa_restaurante: nuevoPaquete.idTarifaRestaurante,
            subtotal: nuevoPaquete.costoBaseUnitario, // Guardamos unitario o total segun lógica de negocio. Backend espera 'subtotal'. Ajustar.
            total_con_iva: nuevoPaquete.precioFinalVenta // Este es el total global
            // imagen_url ... si existe
        };

        await axios.post('http://localhost:3000/api/paquete-turistico', payload);
        
        mostrarMensaje('Paquete creado exitosamente.', 'success');
        limpiarFormulario();
        await cargarDatos(); // Recargar lista
    } catch (error) {
        console.error(error);
        mostrarMensaje('Error al crear paquete: ' + (error.response?.data?.error || error.message), 'danger');
    }
}

function iniciarEdicion(paquete) {
    // Mapeo inverso para llenar el form
    Object.assign(nuevoPaquete, {
        id: paquete.id,
        destino: paquete.destino,
        duracion: paquete.duracion,
        descripcion: paquete.descripcion,
        cantidadPersonas: paquete.cantidadPersonas,
        idTarifaAerea: paquete.idTarifaAerea,
        idTarifaHospedaje: paquete.idTarifaHospedaje,
        idTarifaRestaurante: paquete.idTarifaRestaurante,
        imagenURL: '' // paquete.imagenURL
    });
    paqueteEditando.value = paquete.id;
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

async function guardarEdicion() {
    try {
        const payload = {
            destino_paquete: nuevoPaquete.destino,
            duracion_paquete: nuevoPaquete.duracion,
            cantidad_personas: nuevoPaquete.cantidadPersonas,
            descripcion_paquete: nuevoPaquete.descripcion,
            id_tarifa_aerolinea: nuevoPaquete.idTarifaAerea,
            id_tarifa_hospedaje: nuevoPaquete.idTarifaHospedaje,
            id_tarifa_restaurante: nuevoPaquete.idTarifaRestaurante,
            subtotal: nuevoPaquete.costoBaseUnitario,
            total_con_iva: nuevoPaquete.precioFinalVenta
        };

        await axios.put(`http://localhost:3000/api/paquete-turistico/${paqueteEditando.value}`, payload);
        
        mostrarMensaje('Paquete actualizado.', 'success');
        cancelarEdicion();
        await cargarDatos();
    } catch (error) {
        console.error(error);
        mostrarMensaje('Error al actualizar: ' + (error.response?.data?.error || error.message), 'danger');
    }
}

function cancelarEdicion() {
    paqueteEditando.value = null;
    limpiarFormulario();
}

function confirmarEliminar(id, nombre) {
    paqueteAEliminar.value = id;
    paqueteAEliminarNombre.value = nombre;
}

async function ejecutarEliminacion() {
    if (!paqueteAEliminar.value) return;
    try {
        await axios.delete(`http://localhost:3000/api/paquete-turistico/${paqueteAEliminar.value}`);
        mostrarMensaje('Paquete eliminado.', 'warning');
        paqueteAEliminar.value = null;
        await cargarDatos();
    } catch (error) {
        console.error(error);
        mostrarMensaje('Error al eliminar.', 'danger');
    }
}

function mostrarMensaje(msg, type) {
    message.value = msg;
    messageType.value = type;
    setTimeout(() => message.value = null, 4000);
}

function limpiarFormulario() {
    Object.assign(nuevoPaquete, inicializarPaquete());
}
</script>

<style scoped>
/* ESTILOS (Asegurando la coherencia visual con la estética de Naranja/Admin) */

:root {
    --naranja-principal: #ff6600;
    --naranja-oscuro: #e65c00;
    --naranja-claro: #ffad66;
    --color-fondo: #faf9f8;
}

.pag-ADMIN-paquetes {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    background: url('/img/paqueteTURISTICO.jpg') no-repeat center center fixed;
    background-size: cover;
    color: #333;
}
.main-content-admin {
    flex-grow: 1;
}
.titulo-admin {
    color: var(--naranja-oscuro);
    font-weight: 700;
    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
}
.tarjeta-transparente {
    background-color: rgba(255, 255, 255, 0.98);
    border-radius: 12px;
    border: 1px solid rgba(0, 0, 0, 0.1);
}

/* Colores Naranja */
.bg-naranja-principal { background-color: var(--naranja-principal) !important; }
.bg-naranja-oscuro { background-color: var(--naranja-oscuro) !important; }
.bg-naranja-claro {
    background-color: var(--naranja-claro) !important;
    color: #333 !important;
}
.border-naranja { border-color: var(--naranja-claro) !important; }

/* Botones y Texto */
.btn-naranja-principal, .btn-naranja-oscuro {
    color: rgb(221, 73, 5) !important; /* Corregido a blanco para mejor contraste en botones */
    font-weight: 600;
    transition: background-color 0.3s, transform 0.1s;
    border-radius: 0.5rem;
}
.btn-naranja-principal {
    background-color: var(--naranja-principal) !important;
    border-color: var(--naranja-principal) !important;
}
.btn-naranja-principal:hover {
    background-color: var(--naranja-oscuro) !important;
    border-color: var(--naranja-oscuro) !important;
    transform: translateY(-1px);
}

.btn-naranja-oscuro {
    background-color: var(--naranja-oscuro) !important;
    border-color: var(--naranja-oscuro) !important;
}
.btn-naranja-oscuro:hover {
    background-color: #c95100 !important;
    border-color: #c95100 !important;
    transform: translateY(-1px);
}

.text-naranja { color: var(--naranja-oscuro); font-weight: 600; }
.text-naranja-oscuro { color: var(--naranja-oscuro); font-weight: 700; }
.badge { font-weight: 700; border-radius: 0.25rem; padding: 0.35em 0.65em; }

/* Tabla de Datos */
.tabla-datos th, .tabla-datos td {
    vertical-align: middle;
    font-size: 0.85rem;
    padding: 0.5rem;
}
.tabla-datos thead th {
    font-weight: 700;
    text-transform: uppercase;
}

/* Modal de Confirmación Custom (Reemplazo de window.confirm) */
.modal-backdrop-custom {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1050;
}
.modal-dialog-custom {
    max-width: 400px;
    width: 90%;
}
</style>