<template>
    <div class="pag-ADMIN-clientes">
        <Sidebar_Admin />
        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Clientes</h1>
            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white">
                    <h3 class="card-title mb-0">Clientes Registrados</h3>
                </div>
                <div class="card-body p-3">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover tabla-clientes">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th>Cédula</th>
                                    <th>Nombre y apellido</th>
                                    <th>Dirección</th>
                                    <th>Correo</th>
                                    <th>Teléfono</th>
                                    <th>Usuario</th>
                                    <th>Rol</th>
                                    <th class="text-center">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="usuarios.length === 0">
                                    <td colspan="8" class="text-center text-muted">No hay clientes registrados.</td>
                                </tr>
                                <tr v-else v-for="usuario in usuarios" :key="usuario.cedula_usuario">
                                    <td>{{ usuario.cedula_usuario }}</td>
                                    <td>{{ usuario.nombre_usuario }}</td>
                                    <td>{{ usuario.direccion_usuario }}</td>
                                    <td>{{ usuario.correo_usuario }}</td>
                                    <td>{{ usuario.telefono_usuario }}</td>
                                    <td>{{ usuario.user_usuario }}</td>
                                    <td>
                                        <span :class="['badge', usuario.admin_usuario ? 'bg-danger' : 'bg-primary']">
                                            {{ usuario.admin_usuario ? 'Admin' : 'Usuario' }}
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <!-- Botones de Acción -->
                                        <div class="btn-group" role="group">
                                            <!-- Editar -->
                                            <button class="btn btn-sm btn-outline-warning me-1" title="Editar" @click="editCliente(usuario.cedula_usuario)">
                                                <i class="bi bi-pencil-square"></i>
                                            </button>
                                            
                                            <!-- Eliminar -->
                                            <button class="btn btn-sm btn-outline-danger" title="Eliminar"
                                                    @click="deleteCliente(usuario.cedula_usuario)">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </div>
                                    </td>                                   
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer border-0">
                    <router-link to="/C_Cliente" class="btn btn-naranja-principal w-100 text-black">
                        <i class="bi bi-person-plus-fill me-2 text-black"></i>Registrar Nuevo Cliente
                    </router-link>
                </div>
            </div>
        </main>
        <Footer_Admin />
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';
import Sidebar_Admin from './components/Sidebar_Admin.vue';
import Footer_Admin from './components/Footer_Admin.vue';

const usuarios = ref([]);
const router = useRouter();

// Configuración axios local si no es global
axios.defaults.baseURL = 'http://localhost:3000';

// Cargar usuarios al montar
onMounted(async () => {
    await cargarUsuarios();
});

async function cargarUsuarios() {
    try {
        const res = await axios.get('/api/usuario');
        usuarios.value = res.data;
    } catch (error) {
        console.error("Error cargando usuarios:", error);
    }
}

// Navegar a la página de edición pasando la cédula en query
function editCliente(cedula) {
    if (!cedula) return;
    router.push({ path: '/E_Cliente', query: { cedula } });
}

// Función para eliminar cliente por cédula
async function deleteCliente(cedula) {
    if (!cedula) return;
    
    // Nota: window.confirm es bloqueante, idealmente usar modal custom
    if (!confirm(`¿Estás seguro de que deseas eliminar al usuario con Cédula ${cedula}?`)) return;

    try {
        await axios.delete(`/api/usuario/${cedula}`);
        // Actualizar lista local eliminando el item
        usuarios.value = usuarios.value.filter(u => u.cedula_usuario !== cedula);
        alert('Usuario eliminado correctamente.');
    } catch (error) {
        console.error('Error al eliminar:', error);
        alert('Error al eliminar el usuario.');
    }
}
</script>

<style scoped>
@import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css");

/* ESTILOS ESPECÍFICOS PARA LA VISTA DE ADMINISTRACIÓN DE CLIENTES */

:root {
    --naranja-principal: #ff6600; 
    --naranja-oscuro: #e65c00;
    --naranja-claro: #ffad66; 
}

/* Fondo principal transparente sobre imagen */
.pag-ADMIN-clientes {
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

/* Estilos para la Transparencia (Tarjetas) */
.tarjeta-transparente {
    background-color: rgba(255, 255, 255, 0.95);
    border: 1px solid rgba(255, 255, 255, 0.6);
    border-radius: 12px;
}

/* Colores Temáticos (Naranja) */
.bg-naranja-principal {
    background-color: var(--naranja-principal) !important;
    border-color: var(--naranja-principal) !important;
    color: white !important;
}

.bg-naranja-oscuro {
    background-color: var(--naranja-oscuro) !important;
    border-color: var(--naranja-oscuro) !important;
}

.bg-naranja-claro {
    background-color: var(--naranja-claro) !important;
    color: #333 !important;
}

.btn-naranja-principal {
    background-color: var(--naranja-principal);
    border-color: var(--naranja-principal);
    color: white;
    font-weight: 600;
    transition: background-color 0.3s, transform 0.2s;
}

.btn-naranja-principal:hover {
    background-color: var(--naranja-oscuro) !important;
    border-color: var(--naranja-oscuro) !important;
    transform: translateY(-1px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3); 
}

/* Título */
.titulo-admin {
    color: var(--naranja-oscuro); 
    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
    font-weight: 700;
    background-color: rgba(255, 255, 255, 0.8);
    padding: 10px;
    border-radius: 8px;
    display: inline-block;
}

/* Tabla */
.tabla-clientes th, .tabla-clientes td {
    vertical-align: middle;
}
.tabla-clientes thead th {
    font-weight: 700;
    text-transform: uppercase;
    font-size: 0.9rem;
}
</style>