<template>
    <div class="pag-ADMIN-general">
        <Sidebar_Admin />

        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Aerolíneas</h1>
            <h2 class="text-center mb-4 sub-titulo-secundario">Proveedores de Vuelos</h2>

            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div class="card-header bg-naranja-principal text-white">
                    <h3 class="card-title mb-0">
                    <!--CONDICIONAL PARA MOSTRAR O REGISTRAR NUEVA AEROLINEA O EDITAR ALGUNA YA EXISTENTE -->

                        {{ aerolineaEditandoId ? 'Editar Aerolínea' : 'Registrar Nueva Aerolínea' }}
                    </h3>
                </div>
                <div class="card-body">
                    <!--COMIENZA EL FORMULARIO EN BOOTSTRAP, MEJOR ADMINISTRACION DEL ESPACIO, CON RESPONSIVIDAD  -->

                    <form @submit.prevent="agregarOActualizarAerolinea">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label for="codigoAerolinea" class="form-label">Código Aerolínea</label>
                                <input type="text" class="form-control" id="codigoAerolinea" v-model="nuevaAerolinea.codigoAerolinea" maxlength="8" required>
                            </div>
                            <div class="col-md-8">
                                <label for="nombreAerolinea" class="form-label">Nombre Aerolínea</label>
                                <input type="text" class="form-control" id="nombreAerolinea" v-model="nuevaAerolinea.nombreAerolinea" required>
                            </div>
                            
                            <h5 class="mt-4 mb-2">Ciudad Base (Rutas de Salida)</h5>
                            <div class="col-md-4" v-for="n in 3" :key="'base' + n">
                                <label :for="'ciudadBase' + n" class="form-label sr-only">Ciudad Base {{ n }}</label>
                                <select :id="'ciudadBase' + n" class="form-select" v-model="nuevaAerolinea.ciudadesBase[n-1]">
                                    <option value="" disabled>-- Ciudad Base {{ n }} --</option>        
                                    <!--RECIBE PARAMETROS DE UN ARREGLO PARA NO TENER QUE ESCRIBIR LA LISTA DE LAS CIUDADES VARIAS VECES  -->
                                    <option v-for="ciudad in opcionesCiudades" :key="ciudad" :value="ciudad">{{ ciudad }}</option>
                                </select>
                            </div>

                            <h5 class="mt-4 mb-2">Rutas Turísticas Principales</h5>
                            <div class="col-md-3" v-for="n in 4" :key="'ruta' + n">
                                <label :for="'rutaPrincipal' + n" class="form-label sr-only">Ruta {{ n }}</label>
                                <select :id="'rutaPrincipal' + n" class="form-select" v-model="nuevaAerolinea.rutasPrincipales[n-1]">
                                 <!--IGUAL AQUI, CON PARAMETROS  -->
                                    <option value="" disabled>-- Ruta {{ n }} --</option>
                                    <option v-for="ruta in opcionesRutas" :key="ruta" :value="ruta">{{ ruta }}</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label for="telefonoContacto" class="form-label">Teléfono de Contacto</label>
                                <input type="tel" class="form-control" id="telefonoContacto" v-model="nuevaAerolinea.telefonoContacto" required>
                            </div>
                            <div class="col-md-6">
                                <label for="correoElectronico" class="form-label">Correo Electrónico</label>
                                <input type="email" class="form-control" id="correoElectronico" v-model="nuevaAerolinea.correoElectronico" required>
                            </div>

                            <div class="col-md-6">
                                <label for="representante" class="form-label">Representante / Persona de Contacto</label>
                                <input type="text" class="form-control" id="representante" v-model="nuevaAerolinea.representanteContacto" required>
                            </div>
                            <div class="col-md-3">
                                <label for="estado" class="form-label">Estado</label>
                                <select id="estado" class="form-select" v-model="nuevaAerolinea.estado" required>
                                    <option value="Activo">Activo</option>
                                    <option value="Inactivo">Inactivo</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="fechaRegistro" class="form-label">Fecha de Registro</label>
                                <input type="date" class="form-control" id="fechaRegistro" v-model="nuevaAerolinea.fechaRegistro" readonly>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-naranja-principal mt-4 w-100">
                            <i :class="aerolineaEditandoId ? 'bi bi-save-fill' : 'bi bi-plus-circle-fill'" class="me-2"></i>
                   <!--OTRO CONDICIONAL, PARA MOSTRAR EN EL BOTON O GUARDAR CAMBIOS (CUANDO SE ESTA EDITANDO) O PARAREGISTRAR AEROLINEA (CUANDO SE ESTA HACIENDO EL REGISTRO)  -->
                            {{ aerolineaEditandoId ? 'Guardar Cambios' : 'Registrar Aerolínea' }}
                        </button>
                        
                        <button v-if="aerolineaEditandoId" @click="limpiarFormulario" type="button" class="btn btn-secondary-admin mt-2 w-100">
                            Cancelar Edición
                        </button>
                    </form>
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

// Opciones fijas para los selects
const opcionesCiudades = ['Caracas', 'Valencia', 'Barquisimeto', 'Maracaibo'];
const opcionesRutas = ['Los Roques', 'Porlamar-Margarita', 'Ciudad Bolívar - Salto Ángel', 'La Gran Sabana', 'Amazonas', 'Mérida', 'Colonia Tovar'];

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
                limpiarFormulario();
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