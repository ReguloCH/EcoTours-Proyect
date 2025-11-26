<template>
    <div class="pag-ADMIN-hospedaje">
        <menu_ADMIN />

        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Hospedaje</h1>
            <h2 class="text-center mb-4 sub-titulo-secundario">Proveedores de Alojamiento</h2>

            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div class="card-header bg-naranja-principal text-white">
                    <h3 class="card-title mb-0">
                        {{ hospedajeEditandoId ? 'Editar Hospedaje' : 'Registrar Nuevo Hospedaje' }}
                    </h3>
                </div>
                <div class="card-body">
                    <form @submit.prevent="agregarOActualizarHospedaje">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="nombre_hospedaje" class="form-label">Nombre del Hospedaje</label>
                                <input type="text" class="form-control" id="nombre_hospedaje" v-model="nuevoHospedaje.nombre_hospedaje" required>
                            </div>
                            <div class="col-md-6">
                                <label for="tipo" class="form-label">Tipo de Alojamiento</label>
                                <select id="tipo" class="form-select" v-model="nuevoHospedaje.tipo" required>
                                    <option value="" disabled>-- Seleccione Tipo --</option>
                                    <option value="Hotel">Hotel</option>
                                    <option value="Posada">Posada</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="estado" class="form-label">Estado / Ubicación</label>
                                <select id="estado" class="form-select" v-model="nuevoHospedaje.estado" required>
                                    <option value="" disabled>-- Seleccione Estado --</option>
                                    <option v-for="estado in opcionesEstados" :key="estado" :value="estado">{{ estado }}</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="direccion" class="form-label">Dirección Específica</label>
                                <input type="text" class="form-control" id="direccion" v-model="nuevoHospedaje.direccion" required>
                            </div>

                            <div class="col-md-6">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="tel" class="form-control" id="telefono" v-model="nuevoHospedaje.telefono" required>
                            </div>
                            <div class="col-md-6">
                                <label for="correo" class="form-label">Correo Electrónico</label>
                                <input type="email" class="form-control" id="correo" v-model="nuevoHospedaje.correo" required>
                            </div>

                            <div class="col-md-6">
                                <label for="contacto" class="form-label">Persona de Contacto / Representante</label>
                                <input type="text" class="form-control" id="contacto" v-model="nuevoHospedaje.contacto" required>
                            </div>
                            <div class="col-md-3">
                                <label for="estado_proveedor" class="form-label">Estado Proveedor</label>
                                <select id="estado_proveedor" class="form-select" v-model="nuevoHospedaje.estado_proveedor" required>
                                    <option value="Activo">Activo</option>
                                    <option value="Inactivo">Inactivo</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="fecha_registro" class="form-label">Fecha de Registro</label>
                                <input type="date" class="form-control" id="fecha_registro" v-model="nuevoHospedaje.fecha_registro" readonly>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-naranja-principal mt-4 w-100">
                            <i :class="hospedajeEditandoId ? 'bi bi-save-fill' : 'bi bi-building-fill-add'" class="me-2"></i>
                            {{ hospedajeEditandoId ? 'Guardar Cambios' : 'Registrar Hospedaje' }}
                        </button>
                        
                        <button v-if="hospedajeEditandoId" @click="limpiarFormulario" type="button" class="btn btn-secondary-admin mt-2 w-100">
                            Cancelar Edición
                        </button>
                    </form>
                </div>
            </div>

            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white">
                    <h3 class="card-title mb-0">Listado de Hospedajes (Total: {{ listaHospedajes.length }})</h3>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover tabla-datos">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Tipo</th>
                                    <th>Estado/Ubic.</th>
                                    <th>Contacto</th>
                                    <th>Teléfono</th>
                                    <th>Estatus</th>
                                    <th>Registro</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="listaHospedajes.length === 0">
                                    <td colspan="9" class="text-center text-muted">No hay hospedajes registrados aún.</td>
                                </tr>
                                <tr v-else v-for="hospedaje in listaHospedajes" :key="hospedaje.id">
                                    <td>{{ hospedaje.id }}</td>
                                    <td>{{ hospedaje.nombre_hospedaje }}</td>
                                    <td>{{ hospedaje.tipo }}</td>
                                    <td>{{ hospedaje.estado }}</td>
                                    <td>{{ hospedaje.contacto }}</td>
                                    <td>{{ hospedaje.telefono }}</td>
                                    <td><span :class="{'badge bg-success': hospedaje.estado_proveedor === 'Activo', 'badge bg-danger': hospedaje.estado_proveedor === 'Inactivo'}">{{ hospedaje.estado_proveedor }}</span></td>
                                    <td>{{ hospedaje.fecha_registro }}</td>
                                    <td>
                                        <button @click="cargarParaEditar(hospedaje)" class="btn btn-sm btn-warning me-2" title="Editar">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <button @click="eliminarHospedaje(hospedaje.id)" class="btn btn-sm btn-danger" title="Eliminar">
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
// USAMOS VUE 3 COMPOSITION API (<script setup>)
import { reactive, ref } from 'vue';
import menu_ADMIN from './components/menu_ADMIN.vue';
import Footer_Cliente from './components/Footer_Cliente.vue';

// Opciones y Simulación de BDD

// Opciones de Estados/Ubicaciones 
const opcionesEstados = ['Mérida', 'Porlamar-Margarita', 'Ciudad Bolívar - Salto Ángel', 'La Gran Sabana', 'Amazonas', 'Colonia Tovar', 'Los Roques'];

// Arreglo principal (simulación BDD)
const listaHospedajes = reactive([
    {
        id: 1, 
        nombre_hospedaje: 'Hotel Montaña Azul', 
        tipo: 'Hotel', 
        estado: 'Mérida', 
        direccion: 'Av. Principal, Sector La Teleferico', 
        telefono: '+58 416-1234567', 
        correo: 'reservas@montanaazul.com',
        contacto: 'Sra. Carmen Díaz',
        estado_proveedor: 'Activo',
        fecha_registro: '2025-10-18'
    },
    {
        id: 2, 
        nombre_hospedaje: 'Posada Sol y Arena', 
        tipo: 'Posada', 
        estado: 'Archipiélago Los Roques', 
        direccion: 'Calle El Morro, Pampatar', 
        telefono: '+58 414-9876543', 
        correo: 'posadasol@gmail.com',
        contacto: 'Sr. Roberto Gómez',
        estado_proveedor: 'Activo',
        fecha_registro: '2025-09-01'
    },
]);

// Contador e ID de edición
const siguienteId = ref(listaHospedajes.length + 1);
const hospedajeEditandoId = ref(null); 

// Objeto reactivo para el formulario
const nuevoHospedaje = reactive(inicializarHospedaje());

// Función de utilidad para limpiar el formulario y establecer valores por defecto
function inicializarHospedaje() {
    return {
        id: 0,
        nombre_hospedaje: '',
        tipo: '',
        estado: '',
        direccion: '',
        telefono: '',
        correo: '',
        contacto: '',
        estado_proveedor: 'Activo', // Estado por defecto
        fecha_registro: new Date().toISOString().substr(0, 10), // Fecha actual (YYYY-MM-DD)
    };
}




// Método para agregar o actualizar un hospedaje
function agregarOActualizarHospedaje() {
    if (hospedajeEditandoId.value) {
        // Lógica de EDICIÓN
        const index = listaHospedajes.findIndex(h => h.id === hospedajeEditandoId.value);
        if (index !== -1) {
            Object.assign(listaHospedajes[index], nuevoHospedaje);
            alert(`Hospedaje ${nuevoHospedaje.nombre_hospedaje} actualizado con éxito.`);
        }
    } else {
        // Lógica de REGISTRO (Nuevo Hospedaje)
        const nuevo = { ...nuevoHospedaje }; 
        nuevo.id = siguienteId.value; 
        listaHospedajes.push(nuevo); 
        siguienteId.value++; 
        alert(`Hospedaje ${nuevo.nombre_hospedaje} registrado con éxito. ID: ${nuevo.id}`);
    }

    limpiarFormulario();
}

// Carga los datos de un hospedaje seleccionado al formulario para edición
function cargarParaEditar(hospedaje) {
    hospedajeEditandoId.value = hospedaje.id;
    // Se realiza una copia profunda para editar sin afectar la lista original
    Object.assign(nuevoHospedaje, JSON.parse(JSON.stringify(hospedaje)));
}

// Resetea el formulario y el estado de edición
function limpiarFormulario() {
    Object.assign(nuevoHospedaje, inicializarHospedaje());
    hospedajeEditandoId.value = null;
}

// Método para eliminar un hospedaje por su ID
function eliminarHospedaje(id) {
    if (confirm('¿Está seguro de que desea eliminar este hospedaje?')) {
        const index = listaHospedajes.findIndex(h => h.id === id);
        if (index !== -1) {
            listaHospedajes.splice(index, 1); 
            alert('Hospedaje eliminado.');
            if (hospedajeEditandoId.value === id) {
                limpiarFormulario();
            }
        }
    }
}
</script>

<style scoped>
/* ESTILOS ESPECÍFICOS PARA HOSPEDAJEPROV.VUE */

:root {
    --naranja-principal: #ff6600; 
    --naranja-oscuro: #e65c00;
    --naranja-claro: #ffad66; 
}

/* 1. Fondo principal para HOSPEDAJE */
.pag-ADMIN-hospedaje {
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

/* Estilos de Tipografía y Colores Temáticos (Reutilizados) */
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
    /* Manteniendo la transparencia sobre el fondo de imagen */
    background-color: rgba(255, 255, 255, 0.9);
    border-radius: 12px;
}

/* Colores Naranja */
.bg-naranja-principal { background-color: var(--naranja-principal) !important; }
.bg-naranja-oscuro { background-color: var(--naranja-oscuro) !important; }
.bg-naranja-claro { background-color: var(--naranja-claro) !important; color: #333 !important; }

/* Botones y Badges */
.btn-naranja-principal { 
    background-color: var(--naranja-principal);
    border-color: var(--naranja-principal);
    color: rgb(235, 124, 34);
    transition: background-color 0.3s, transform 0.2s;
}
.btn-secondary-admin {
    background-color: #6c757d;
    border-color: #6c757d;
    color: white;
    opacity: 1;
}
.badge {
    padding: 0.35em 0.65em;
    font-weight: 700;
    border-radius: 0.25rem;
}
.bg-success { background-color: #198754 !important; }
.bg-danger { background-color: #dc3545 !important; }
</style>