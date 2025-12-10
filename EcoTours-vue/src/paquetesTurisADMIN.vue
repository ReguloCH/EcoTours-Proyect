<template>
    <div class="pag-ADMIN-paquetes">
<<<<<<< HEAD
=======
        <!-- NOTA: Se asume que los componentes Sidebar_Admin y Footer_Admin existen -->
>>>>>>> 682b119356ef687eac453c3d9066f92d0f9530d8
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
                                    <option v-for="t in listaBoletosAereos" :key="t.id" :value="t.id">
                                        {{ t.proveedor }} ({{ t.origen }} -> {{ t.destinoVuelo }}) - Base: ${{ t.costoBaseUSD }}
                                    </option>
                                </select>
                            </div>

                            <!-- Tarifa Hospedaje -->
                            <div class="col-md-4">
                                <label for="tarifaHospedaje" class="form-label text-naranja">2. Tarifa de Hospedaje</label>
                                <select id="tarifaHospedaje" class="form-select" v-model="nuevoPaquete.idTarifaHospedaje" required>
                                    <option value="" disabled>-- Seleccione Oferta de Hospedaje --</option>
                                    <option v-for="t in listaOfertasHospedaje" :key="t.id" :value="t.id">
                                        {{ t.proveedor }} ({{ t.tipoHabitacion }}) - Base: ${{ t.costoBaseUSD }}
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
                                    <option v-for="t in listaPlanesAlimentacion" :key="t.id" :value="t.id">
                                        {{ t.proveedor }} ({{ t.nombrePlan }}) - Base: ${{ t.costoBaseUSD }}
                                    </option>
                                </select>
                            </div>

                            <!-- URL de Imagen (Para Card del Cliente) -->
                            <div class="col-md-12">
                                <label for="imagenURL" class="form-label">URL de Imagen (Para Card del Cliente)</label>
                                <input type="url" class="form-control" id="imagenURL" v-model="nuevoPaquete.imagenURL" placeholder="Ej: /img/losroques-paquete.jpg" required>
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
                                    <th rowspan="2" class="align-middle">Personas</th> <!-- Nuevo campo en tabla -->
                                    <th colspan="3" class="text-center">Detalle de Proveedores</th>
                                    <th colspan="4" class="text-center">Desglose Financiero (Unitario/Total USD)</th>
                                    <th rowspan="2" class="align-middle">Acciones</th>
                                </tr>
                                <tr>
                                    <th>Aéreo</th>
                                    <th>Hospedaje</th>
                                    <th>Restaurante</th> <!-- Cambiado de 'Comidas' -->
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
                                    <td class="fw-bold">{{ paquete.cantidadPersonas }}</td> <!-- Nuevo campo -->

                                    <!-- Detalle de Proveedores -->
                                    <td>{{ getTarifaNombre(paquete.idTarifaAerea, 'aereo') }}</td>
                                    <td>{{ getTarifaNombre(paquete.idTarifaHospedaje, 'hospedaje') }}</td>
                                    <td>
                                        <!-- Plan de Restaurante (ahora siempre debe existir) -->
                                        {{ getTarifaNombre(paquete.idTarifaRestaurante, 'alimentacion') }}
                                    </td>

                                    <!-- Desglose Financiero (Unitario y Total) -->
                                    <td>${{ paquete.costoBaseUnitario.toFixed(2) }}</td>
                                    <td class="text-primary">${{ paquete.montoIVAUnitario.toFixed(2) }}</td>
                                    <td class="text-success">${{ paquete.montoGananciaUnitario.toFixed(2) }}</td>
                                    <td class="fw-bold text-warning">${{ paquete.precioFinalVenta.toFixed(2) }}</td>

                                    <!-- Botones de Acción (Editar y Eliminar) -->
                                    <td>
                                        <div class="btn-group" role="group">
                                            <button @click="iniciarEdicion(paquete)" class="btn btn-sm btn-outline-info me-1" title="Editar Paquete">
                                                <i class="bi bi-pencil-square"></i>
                                            </button>
                                            <!-- Usamos un modal o componente de confirmación en lugar de window.confirm() -->
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
<<<<<<< HEAD
        
=======

>>>>>>> 682b119356ef687eac453c3d9066f92d0f9530d8
        <Footer_Admin />
    </div>
</template>

<script setup>
<<<<<<< HEAD
import { reactive, ref } from 'vue';
=======
import { reactive, ref, computed, watch } from 'vue';
// Importamos los componentes de la interfaz de administración (simulación)
>>>>>>> 682b119356ef687eac453c3d9066f92d0f9530d8
import Sidebar_Admin from './components/Sidebar_Admin.vue';
import Footer_Admin from './components/Footer_Admin.vue';

// --- CONSTANTES DE CÁLCULO ---
const IVA = 0.16; // 16% de Impuesto al Valor Agregado
const PORCENTAJE_GANANCIA = 0.40; // 40% de Ganancia

// --- ESTADO Y SIMULACIÓN DE DATOS ---

// Refs para manejo de mensajes y filtro
const message = ref(null);
const messageType = ref('success');
const filtroDestino = ref('');
const paqueteEditando = ref(null);

// Refs para el modal de eliminación (Reemplazo de window.confirm)
const paqueteAEliminar = ref(null);
const paqueteAEliminarNombre = ref('');

// SIMULACIÓN DE DATOS DE TARIFAS (Se reemplazará con datos del backend)
const listaBoletosAereos = reactive([
    { id: 10, proveedor: 'CONVIASA', origen: 'CCS', destinoVuelo: 'LRM', costoBaseUSD: 250 },
    { id: 11, proveedor: 'Turismo Albatros', origen: 'CCS', destinoVuelo: 'CMM', costoBaseUSD: 350 },
    { id: 12, proveedor: 'Laser Airlines', origen: 'CCS', destinoVuelo: 'MAR', costoBaseUSD: 180 },
]);

const listaOfertasHospedaje = reactive([
    { id: 20, proveedor: 'Posada Sol y Arena', tipoHabitacion: 'Doble Estándar', costoBaseUSD: 150, noches: 2 },
    { id: 21, proveedor: 'Hotel Playa Grande', tipoHabitacion: 'Suite Ejecutiva', costoBaseUSD: 280, noches: 3 },
    { id: 22, proveedor: 'Campamento Canaima', tipoHabitacion: 'Churuata Compartida', costoBaseUSD: 100, noches: 3 },
]);

const listaPlanesAlimentacion = reactive([
    { id: 30, proveedor: 'Sabores del Mar', nombrePlan: 'Pensión Completa (3D)', costoBaseUSD: 90 },
    { id: 31, proveedor: 'El Grill Venezolano', nombrePlan: 'Cena Gourmet (1N)', costoBaseUSD: 45 },
    { id: 32, proveedor: 'Desayunos Express', nombrePlan: 'Solo Desayuno (2D)', costoBaseUSD: 30 },
]);

// Objeto para consolidar todas las tarifas para búsqueda rápida
const todasLasTarifas = computed(() => [
    ...listaBoletosAereos.map(t => ({ ...t, tipo: 'aereo' })),
    ...listaOfertasHospedaje.map(t => ({ ...t, tipo: 'hospedaje' })),
    ...listaPlanesAlimentacion.map(t => ({ ...t, tipo: 'alimentacion' })),
]);

// Arreglo principal (simulación BDD de Paquetes con la nueva estructura)
const listaPaquetes = reactive([
    {
        id: 101,
        destino: 'Los Roques', // Destino de la lista
        duracion: '3 días / 2 noches',
        descripcion: 'Paquete playero con pasaje aéreo y hospedaje en posada, incluye pensión completa.', // Nuevo
        cantidadPersonas: 2, // Nuevo
        idTarifaAerea: 10, // CONVIASA (Base: 250)
        idTarifaHospedaje: 20, // Posada Sol y Arena (Base: 150)
        idTarifaRestaurante: 30, // Pensión Completa (Base: 90) - Obligatorio
        imagenURL: '/img/roques-1.jpg',
        // Costos Calculados (Unitario: 490)
        costoBaseUnitario: 490,
        montoIVAUnitario: 78.4,
        montoGananciaUnitario: 196,
        precioFinalVenta: 1528.8, // (490 + 78.4 + 196) * 2 = 1528.8
    },
    {
        id: 102,
        destino: 'El Salto Ángel',
        duracion: '4 días / 3 noches',
        descripcion: 'Expedición de aventura incluyendo vuelo, campamento y plan de comidas básico.',
        cantidadPersonas: 1,
        idTarifaAerea: 11, // Turismo Albatros (Base: 350)
        idTarifaHospedaje: 22, // Campamento Canaima (Base: 100)
        idTarifaRestaurante: 31, // Cena Gourmet (Base: 45) - Obligatorio
        imagenURL: '/img/canaima-2.jpg',
        // Costos Calculados (Unitario: 495)
        costoBaseUnitario: 495, // 350 + 100 + 45
        montoIVAUnitario: 79.2,
        montoGananciaUnitario: 198,
        precioFinalVenta: 772.2, // (495 + 79.2 + 198) * 1 = 772.2
    }
]);

// Contador e ID del nuevo paquete (para simulación de IDs)
const siguienteId = ref(103);

// Función para resetear el objeto del formulario a su estado inicial
function inicializarPaquete() {
    return {
        id: 0,
        destino: 'Los Roques', // Default selection
        duracion: '',
        descripcion: '', // Nuevo campo
        cantidadPersonas: 1, // Nuevo campo
        idTarifaAerea: '',
        idTarifaHospedaje: '',
        idTarifaRestaurante: '', // Ahora siempre obligatorio
        imagenURL: '',
        // Cálculos Unitarios (Por Persona)
        costoBaseUnitario: 0,
        montoIVAUnitario: 0,
        montoGananciaUnitario: 0,
        // Cálculo Total
        precioFinalVenta: 0,
    };
}

// Objeto reactivo para el formulario
const nuevoPaquete = reactive(inicializarPaquete());

// --- LÓGICA DE CÁLCULO DE PRECIOS (Computadas) ---

// Función helper para encontrar una tarifa
function findTarifa(id, lista) {
    return lista.find(t => t.id === id);
}

const tarifaAereaSeleccionada = computed(() =>
    findTarifa(nuevoPaquete.idTarifaAerea, listaBoletosAereos)
);

const tarifaHospedajeSeleccionada = computed(() =>
    findTarifa(nuevoPaquete.idTarifaHospedaje, listaOfertasHospedaje)
);

const tarifaRestauranteSeleccionada = computed(() =>
    // Ya no hay chequeo condicional, el restaurante es obligatorio
    findTarifa(nuevoPaquete.idTarifaRestaurante, listaPlanesAlimentacion)
);

// 1. Costo Base Unitario (Suma de las tarifas seleccionadas - POR PERSONA)
const costoBaseUnitario = computed(() => {
    let base = 0;
    if (tarifaAereaSeleccionada.value) {
        base += tarifaAereaSeleccionada.value.costoBaseUSD;
    }
    if (tarifaHospedajeSeleccionada.value) {
        base += tarifaHospedajeSeleccionada.value.costoBaseUSD;
    }
    if (tarifaRestauranteSeleccionada.value) {
        base += tarifaRestauranteSeleccionada.value.costoBaseUSD;
    }
    return base;
});

// 2. Monto IVA Unitario (Costo Base Unitario * IVA)
const montoIVAUnitario = computed(() => costoBaseUnitario.value * IVA);

// 3. Monto Ganancia Unitario (Costo Base Unitario * 40%)
const montoGananciaUnitario = computed(() => costoBaseUnitario.value * PORCENTAJE_GANANCIA);

// 4. Precio Final de Venta (TOTAL: (Unitario + Unitario IVA + Unitario Ganancia) * Cantidad de Personas)
const precioFinalVenta = computed(() =>
    (costoBaseUnitario.value + montoIVAUnitario.value + montoGananciaUnitario.value) * (nuevoPaquete.cantidadPersonas || 1)
);

// Sincronizar los campos calculados con el objeto reactivo *siempre que cambien las tarifas o la cantidad de personas*
watch([precioFinalVenta, () => nuevoPaquete.cantidadPersonas], () => {
    // Los campos unitarios se guardan para fines informativos en la tabla/BDD
    nuevoPaquete.costoBaseUnitario = costoBaseUnitario.value;
    nuevoPaquete.montoIVAUnitario = montoIVAUnitario.value;
    nuevoPaquete.montoGananciaUnitario = montoGananciaUnitario.value;
    // El precio final es el total
    nuevoPaquete.precioFinalVenta = precioFinalVenta.value;
}, { immediate: true });


// --- FUNCIONES DE FILTRO Y BÚSQUEDA ---

const paquetesFiltrados = computed(() => {
    if (!filtroDestino.value) {
        return listaPaquetes;
    }
    const filtro = filtroDestino.value.toLowerCase().trim();
    return listaPaquetes.filter(paquete =>
        paquete.destino.toLowerCase().includes(filtro)
    );
});

/**
 * Función para obtener el nombre corto de la tarifa para la tabla.
 */
function getTarifaNombre(id, tipo) {
    if (!id) return 'N/A';
    const tarifa = todasLasTarifas.value.find(t => t.id === id && t.tipo === tipo);

    if (!tarifa) return `ID ${id} no encontrado`;

    switch (tipo) {
        case 'aereo':
            return `${tarifa.proveedor} (${tarifa.destinoVuelo})`;
        case 'hospedaje':
            return `${tarifa.proveedor} (${tarifa.tipoHabitacion})`;
        case 'alimentacion':
            return `${tarifa.proveedor} (${tarifa.nombrePlan})`;
        default:
            return 'N/A';
    }
}

// --- LÓGICA DE CRUD ---

// Método para agregar un paquete nuevo (Simulación de POST)
function agregarPaquete() {
    // 1. Validación de obligatoriedad del restaurante
    if (!nuevoPaquete.idTarifaRestaurante) {
        mostrarMensaje('Debe seleccionar un Plan de Restaurante (es obligatorio en todos los paquetes).', 'danger');
        return;
    }

    // 2. Crear objeto final con IDs y Cálculos
    const nuevo = { ...nuevoPaquete };
    nuevo.id = siguienteId.value;

    // SIMULACIÓN: Aquí iría el fetch/axios.post(URL, nuevo)
    listaPaquetes.push(nuevo);
    siguienteId.value++;

    mostrarMensaje(`Paquete "${nuevo.destino}" registrado con éxito.`, 'success');
    limpiarFormulario();
}

// Inicia el modo de edición
function iniciarEdicion(paquete) {
    // Asignamos el paquete (incluyendo sus cálculos y tarifas IDs) al formulario
    Object.assign(nuevoPaquete, { ...paquete });
    paqueteEditando.value = paquete.id;
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

// Guarda los cambios del paquete (Simulación de PUT)
function guardarEdicion() {
    // 1. Validación de obligatoriedad del restaurante
    if (!nuevoPaquete.idTarifaRestaurante) {
        mostrarMensaje('Debe seleccionar un Plan de Restaurante (es obligatorio en todos los paquetes).', 'danger');
        return;
    }

    // 2. Busca el índice y actualiza
    const index = listaPaquetes.findIndex(p => p.id === paqueteEditando.value);

    if (index !== -1) {
        // SIMULACIÓN: Aquí iría el fetch/axios.put(URL/id, nuevoPaquete)
        // nuevoPaquete ya tiene los cálculos actualizados gracias al watcher
        listaPaquetes[index] = { ...nuevoPaquete };

        mostrarMensaje(`Paquete "${nuevoPaquete.destino}" actualizado con éxito.`, 'success');

        // 3. Salir del modo edición
        cancelarEdicion();
    }
}

// Cancela la edición y limpia el formulario
function cancelarEdicion() {
    paqueteEditando.value = null;
    limpiarFormulario();
}

// Confirma la eliminación (usando el modal custom)
function confirmarEliminar(id, nombre) {
    paqueteAEliminar.value = id;
    paqueteAEliminarNombre.value = nombre;
}

// Ejecuta la eliminación (Simulación de DELETE)
function ejecutarEliminacion() {
    const id = paqueteAEliminar.value;
    const index = listaPaquetes.findIndex(p => p.id === id);

    if (index !== -1) {
        const nombrePaquete = listaPaquetes[index].destino;
        // SIMULACIÓN: Aquí iría el fetch/axios.delete(URL/id)
        listaPaquetes.splice(index, 1);
        mostrarMensaje(`Paquete "${nombrePaquete}" eliminado con éxito.`, 'danger');
    }

    paqueteAEliminar.value = null; // Cierra el modal
}


/**
 * Muestra una notificación temporal.
 */
function mostrarMensaje(msg, type) {
    message.value = msg;
    messageType.value = type;
    setTimeout(() => {
        message.value = null;
    }, 4000);
}

// Resetea el formulario
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