<template>
    <div class="pag-ADMIN-general">
        <Sidebar_Admin />
        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Aerolíneas</h1>
            <h2 class="text-center mb-4 sub-titulo-secundario text-ligth">Proveedores de Vuelos</h2>
            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white">    <!--AQUI ABAJO RECIBE EL PRAMETRO EN BASE AL ID, CON UN CONTADOR QUE AUMETA EL VALOR DEL LISTADO DE AEROLINEAS REGISTRADAS  -->
                    <h3 class="card-title mb-0">Listado de Aerolíneas (Total: {{ listaAerolineas.length }})</h3>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover tabla-datos">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th>ID</th>
                                    <th>Código</th>
                                    <th>Nombre</th>
                                    <th>Contacto</th>
                                    <th>Representante</th>
                                    <th>Base(s)</th>
                                    <th>Estado</th>
                                    <th>Registro</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="listaAerolineas.length === 0"> <!--CONDICIONAL QUE MUESTRA MENSAJE EN LA TABLA SI NO HAY AEROLINEAS REGISTRADAS  -->
                                    <td colspan="9" class="text-center text-muted">No hay aerolíneas registradas aún.</td>
                                </tr>
                                <tr v-else v-for="aerolinea in listaAerolineas" :key="aerolinea.id"><!--LA CONSECUENCIA, EN EL CASO DE QUE SI HAYA REGISTROS, LO MOSTRARA EN CADA ESPACIO SIMULANDO UNA BASE DE DATOS -->
                                    <td>{{ aerolinea.id }}</td>
                                    <td>{{ aerolinea.codigoAerolinea }}</td>
                                    <td>{{ aerolinea.nombreAerolinea }}</td>
                                    <td>{{ aerolinea.correoElectronico }}</td>
                                    <td>{{ aerolinea.representanteContacto }}</td>
                                    <td>{{ aerolinea.ciudadesBase.filter(c => c).join(', ') }}</td>
                                    <td><span :class="{'badge bg-success': aerolinea.estado === 'Activo', 'badge bg-danger': aerolinea.estado === 'Inactivo'}">{{ aerolinea.estado }}</span></td>
                                    <td>{{ aerolinea.fechaRegistro }}</td>
                                    <td>
                                        <button class="btn btn-sm btn-warning me-2">
                                            <i class="bi bi-pencil-square"></i><router-link to="/E_Aerolinea" class="dropdown-item">Editar</router-link> 
                                        </button>
                                        <button @click="eliminarAerolinea(aerolinea.id)" class="btn btn-sm btn-danger" title="Eliminar">
                                            <i class="bi bi-trash-fill"></i><a>Eliminar</a>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                            <button type="submit" class="btn btn-naranja-principal mt-5 w-100">
                            <i class="bi-plus-circle-fill"></i><router-link to="/C_Aerolinea" class="dropdown-item">Crear una nueva aerolinea</router-link> 
                        </button>
                        <br>
                        <br>
                    </div>
                </div>
            </div>
        </main>
             <!--COMPONENENTE  -->
        <Footer_Admin />
    </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import Sidebar_Admin from './components/Sidebar_Admin.vue';
import Footer_Admin from './components/Footer_Admin.vue';

// ===============================================================
// 1. Opciones y Simulación de BDD
// ===============================================================


// Arreglo principal (simulación BDD)
const listaAerolineas = reactive([
    {
        id: 1, 
        codigoAerolinea: 'CONV001', 
        nombreAerolinea: 'CONVIASA', 
        ciudadesBase: ['Caracas', 'Maracaibo', ''],
        rutasPrincipales: ['Los Roques', 'Porlamar-Margarita', '', ''],
        telefonoContacto: '0251 (848) 555-10', 
        correoElectronico: 'conviasasoport@airparadise.com',
        representanteContacto: 'Juan Pérez',
        estado: 'Activo',
        fechaRegistro: '2025-10-15'
    },
]);

// Contador e ID de edición
const siguienteId = ref(listaAerolineas.length + 1);
const aerolineaEditandoId = ref(null); 

// Objeto reactivo para el formulario
const nuevaAerolinea = reactive(inicializarAerolinea());

// Función de utilidad para limpiar el formulario y establecer valores por defecto
function inicializarAerolinea() {
    return {
        id: 0,
        codigoAerolinea: '',
        nombreAerolinea: '',
        // Arreglos para los 3 selects de ciudad base y 4 selects de rutas
        ciudadesBase: ['', '', ''],
        rutasPrincipales: ['', '', '', ''],
        telefonoContacto: '',
        correoElectronico: '',
        representanteContacto: '',
        estado: 'Activo', // Estado por defecto
        fechaRegistro: new Date().toISOString().substr(0, 10), // Fecha actual (YYYY-MM-DD)
    };
}


// MÉTODOS (LÓGICA DE GESTIÓN)


// Método para agregar o actualizar una aerolínea
function agregarOActualizarAerolinea() {
    if (aerolineaEditandoId.value) {
        // Lógica de EDICIÓN
        const index = listaAerolineas.findIndex(a => a.id === aerolineaEditandoId.value);
        if (index !== -1) {
            Object.assign(listaAerolineas[index], nuevaAerolinea);
            alert(`Aerolínea ${nuevaAerolinea.nombreAerolinea} actualizada con éxito.`);
        }
    } else {
        // Lógica de REGISTRO (Nueva Aerolínea)
        const nueva = { ...nuevaAerolinea }; 
        nueva.id = siguienteId.value; 
        listaAerolineas.push(nueva); 
        siguienteId.value++; 
        alert(`Aerolínea ${nueva.nombreAerolinea} registrada con éxito. ID: ${nueva.id}`);
    }

    limpiarFormulario();
}

// Carga los datos de una aerolínea seleccionada al formulario para edición
function cargarParaEditar(aerolinea) {
    aerolineaEditandoId.value = aerolinea.id;
    // Usamos JSON.parse(JSON.stringify(aerolinea)) para una copia profunda
    // y evitar modificar la listaAerolineas directamente antes de guardar.
    Object.assign(nuevaAerolinea, JSON.parse(JSON.stringify(aerolinea)));
}

// Resetea el formulario y el estado de edición
function limpiarFormulario() {
    Object.assign(nuevaAerolinea, inicializarAerolinea());
    aerolineaEditandoId.value = null;
}

// Método para eliminar una aerolínea por su ID
function eliminarAerolinea(id) {
    if (confirm('¿Está seguro de que desea eliminar esta aerolínea?')) {
        const index = listaAerolineas.findIndex(a => a.id === id);
        if (index !== -1) {
            listaAerolineas.splice(index, 1); 
            alert('Aerolínea eliminada.');
            if (aerolineaEditandoId.value === id) {
            }
        }
    }
}
</script>

<style scoped>
/* NOTA: Los estilos de color y transparencia (bg-naranja-principal, tarjeta-transparente, etc.)
   se mantienen igual que en la versión anterior y funcionan para este nuevo formulario. */
:root {
    --naranja-principal: #ff6600; 
    --naranja-oscuro: #e65c00;
    --naranja-claro: #ffad66; 
}
.pag-ADMIN-general {
   display: flex;
    flex-direction: column;
    min-height: 100vh;
    background: url('/img/fondoCLIENTESad.jpg') no-repeat center center fixed; 
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
.bg-naranja-principal { background-color: var(--naranja-principal) !important; }
.bg-naranja-oscuro { background-color: var(--naranja-oscuro) !important; }
.bg-naranja-claro { background-color: var(--naranja-claro) !important; color: #333 !important; }
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
/* Estilo para el estado activo/inactivo en la tabla */
.badge {
    padding: 0.35em 0.65em;
    font-weight: 700;
    line-height: 1;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: 0.25rem;
}
.bg-success { background-color: #198754 !important; }
.bg-danger { background-color: #dc3545 !important; }
.sr-only { /* Oculta visualmente el label para los inputs repetidos (ciudades/rutas) */
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    border: 0;
}
</style>