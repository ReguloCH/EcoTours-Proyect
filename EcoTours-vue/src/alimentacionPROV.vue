<template>
    <div class="pag-ADMIN-alimentacion">
        <menu_ADMIN />
                <!--aerolineasPROV, hospedajePROV y alimentacionPROV comparten una logica y estructura identica, simulan un CRUD-->

        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Alimentación</h1>
            <h2 class="text-center mb-4 sub-titulo-secundario">Proveedores de Restaurantes y Comida</h2>

            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div class="card-header bg-naranja-principal text-white">
                    <h3 class="card-title mb-0">
                        {{ restauranteEditandoId ? 'Editar Restaurante' : 'Registrar Nuevo Restaurante' }}
                    </h3>
                </div>
                <div class="card-body">
                    <form @submit.prevent="agregarOActualizarRestaurante">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="nombreRestaurante" class="form-label">Nombre del Restaurante</label>
                                <input type="text" class="form-control" id="nombreRestaurante" v-model="nuevoRestaurante.nombreRestaurante" required>
                            </div>
                            <div class="col-md-6">
                                <label for="ciudad" class="form-label">Ciudad</label>
                                <select id="ciudad" class="form-select" v-model="nuevoRestaurante.ciudad" required>
                                    <option value="" disabled>-- Seleccione Ciudad --</option>
                                    <option v-for="ciudad in opcionesCiudades" :key="ciudad" :value="ciudad">{{ ciudad }}</option>
                                </select>
                            </div>
                            
                            <div class="col-12">
                                <label for="direccion" class="form-label">Dirección Completa</label>
                                <input type="text" class="form-control" id="direccion" v-model="nuevoRestaurante.direccion" required>
                            </div>

                            <div class="col-md-6">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="tel" class="form-control" id="telefono" v-model="nuevoRestaurante.telefono" required>
                            </div>
                            <div class="col-md-6">
                                <label for="correo" class="form-label">Correo Electrónico</label>
                                <input type="email" class="form-control" id="correo" v-model="nuevoRestaurante.correo" required>
                            </div>

                            <div class="col-md-6">
                                <label for="contacto" class="form-label">Persona de Contacto / Gerente</label>
                                <input type="text" class="form-control" id="contacto" v-model="nuevoRestaurante.contacto" required>
                            </div>
                            <div class="col-md-6">
                                <label for="horario" class="form-label">Horario de Servicio</label>
                                <input type="text" class="form-control" id="horario" v-model="nuevoRestaurante.horario" placeholder="Ej: L-D 11:00 AM - 10:00 PM">
                            </div>

                            <div class="col-md-6">
                                <label for="estado_proveedor" class="form-label">Estado Proveedor</label>
                                <select id="estado_proveedor" class="form-select" v-model="nuevoRestaurante.estado_proveedor" required>
                                    <option value="Activo">Activo</option>
                                    <option value="Inactivo">Inactivo</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="fecha_registro" class="form-label">Fecha de Registro</label>
                                <input type="date" class="form-control" id="fecha_registro" v-model="nuevoRestaurante.fecha_registro" readonly>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-naranja-principal mt-4 w-100">
                            <i :class="restauranteEditandoId ? 'bi bi-save-fill' : 'bi bi-egg-fried'" class="me-2"></i>
                            {{ restauranteEditandoId ? 'Guardar Cambios' : 'Registrar Restaurante' }}
                        </button>
                        
                        <button v-if="restauranteEditandoId" @click="limpiarFormulario" type="button" class="btn btn-secondary-admin mt-2 w-100">
                            Cancelar Edición
                        </button>
                    </form>
                </div>
            </div>

            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white">
                    <h3 class="card-title mb-0">Listado de Restaurantes (Total: {{ listaRestaurantes.length }})</h3>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover tabla-datos">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Ciudad</th>
                                    <th>Contacto</th>
                                    <th>Teléfono</th>
                                    <th>Horario</th>
                                    <th>Estatus</th>
                                    <th>Registro</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="listaRestaurantes.length === 0">
                                    <td colspan="9" class="text-center text-muted">No hay restaurantes registrados aún.</td>
                                </tr>
                                <tr v-else v-for="restaurante in listaRestaurantes" :key="restaurante.id">
                                    <td>{{ restaurante.id }}</td>
                                    <td>{{ restaurante.nombreRestaurante }}</td>
                                    <td>{{ restaurante.ciudad }}</td>
                                    <td>{{ restaurante.contacto }}</td>
                                    <td>{{ restaurante.telefono }}</td>
                                    <td>{{ restaurante.horario }}</td>
                                    <td><span :class="{'badge bg-success': restaurante.estado_proveedor === 'Activo', 'badge bg-danger': restaurante.estado_proveedor === 'Inactivo'}">{{ restaurante.estado_proveedor }}</span></td>
                                    <td>{{ restaurante.fecha_registro }}</td>
                                    <td>
                                        <button @click="cargarParaEditar(restaurante)" class="btn btn-sm btn-warning me-2" title="Editar">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <button @click="eliminarRestaurante(restaurante.id)" class="btn btn-sm btn-danger" title="Eliminar">
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
        
        <FooterIni />
    </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import menu_ADMIN from './components/menu_ADMIN.vue';
import FooterIni from './components/footerIni.vue';

// Opciones y Simulación de BDD

// Opciones de Ciudades (reutilizadas de aerolíneas)
const opcionesCiudades = ['Caracas', 'Valencia', 'Barquisimeto', 'Maracaibo', 'Mérida', 'Porlamar-Margarita', 'Ciudad Bolívar'];

// Arreglo principal (simulación BDD)
const listaRestaurantes = reactive([
    {
        id: 1, 
        nombreRestaurante: 'El Sabor Tropical', 
        ciudad: 'Caracas', 
        direccion: 'Calle Los Jardines, El Rosal', 
        telefono: '+58 212-9998877', 
        correo: 'sabor.tropical@mail.com',
        contacto: 'Pedro Alfonzo',
        horario: 'L-S 12:00 PM - 10:00 PM',
        estado_proveedor: 'Activo',
        fecha_registro: '2025-09-25'
    },
    {
        id: 2, 
        nombreRestaurante: 'Sabores del Mar',
        ciudad: 'Archipiélago Los Roques',
        direccion: 'Frente al muelle principal, Gran Roque',
        telefono: '+58 414-5627890',
        correo: 'saboresdelmar@ecotours.com.ve',
        contacto: 'Luisana Rojas',
        horario: 'L-D 8:00 AM - 9:00 PM',
        estado_proveedor: 'Activo',
        fecha_registro: '2025-10-01'
    },
]);

// Contador e ID de edición
const siguienteId = ref(listaRestaurantes.length + 1);
const restauranteEditandoId = ref(null); 

// Objeto reactivo para el formulario
const nuevoRestaurante = reactive(inicializarRestaurante());

// Función de utilidad para limpiar el formulario y establecer valores por defecto
function inicializarRestaurante() {
    return {
        id: 0,
        nombreRestaurante: '',
        ciudad: '',
        direccion: '',
        telefono: '',
        correo: '',
        contacto: '',
        horario: '',
        estado_proveedor: 'Activo', // Estado por defecto
        fecha_registro: new Date().toISOString().substr(0, 10), 
    };
}




// Método para agregar o actualizar un restaurante
function agregarOActualizarRestaurante() {
    if (restauranteEditandoId.value) {
        // Lógica de EDICIÓN
        const index = listaRestaurantes.findIndex(r => r.id === restauranteEditandoId.value);
        if (index !== -1) {
            Object.assign(listaRestaurantes[index], nuevoRestaurante);
            alert(`Restaurante ${nuevoRestaurante.nombreRestaurante} actualizado con éxito.`);
        }
    } else {
        // Lógica de REGISTRO (Nuevo Restaurante)
        const nuevo = { ...nuevoRestaurante }; 
        nuevo.id = siguienteId.value; 
        listaRestaurantes.push(nuevo); 
        siguienteId.value++; 
        alert(`Restaurante ${nuevo.nombreRestaurante} registrado con éxito. ID: ${nuevo.id}`);
    }

    limpiarFormulario();
}

// Carga los datos de un restaurante seleccionado al formulario para edición
function cargarParaEditar(restaurante) {
    restauranteEditandoId.value = restaurante.id;
    // Se realiza una copia profunda
    Object.assign(nuevoRestaurante, JSON.parse(JSON.stringify(restaurante)));
}

// Resetea el formulario y el estado de edición
function limpiarFormulario() {
    Object.assign(nuevoRestaurante, inicializarRestaurante());
    restauranteEditandoId.value = null;
}

// Método para eliminar un restaurante por su ID
function eliminarRestaurante(id) {
    if (confirm('¿Está seguro de que desea eliminar este restaurante?')) {
        const index = listaRestaurantes.findIndex(r => r.id === id);
        if (index !== -1) {
            listaRestaurantes.splice(index, 1); 
            alert('Restaurante eliminado.');
            if (restauranteEditandoId.value === id) {
                limpiarFormulario();
            }
        }
    }
}
</script>

<style scoped>
/* ESTILOS ESPECÍFICOS PARA ALIMENTACIONPROV.VUE */

:root {
    --naranja-principal: #ff6600; 
    --naranja-oscuro: #e65c00;
    --naranja-claro: #ffad66; 
}

/* Fondo principal para ALIMENTACIÓN */
.pag-ADMIN-alimentacion {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    background: url('/img/fondo-admin.jpg') no-repeat center center fixed; 
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
    background-color: var(--naranja-principal) !important; 
    border-color: var(--naranja-principal) !important; 
    color: white !important; 
    opacity: 1 !important;
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