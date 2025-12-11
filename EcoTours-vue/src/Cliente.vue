<template>
    <div class="pag-ADMIN-clientes">
        <Sidebar_Admin />
        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Clientes</h1>
            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white">
                    <h3 class="card-title mb-0">Clientes Registrados</h3>
                </div>
                <div class="card-body p-0">
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
                                    <th>Administrador</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="usuario in usuarios" :key="usuario.id_usuario || usuario.cedula_usuario">
                                    <td>{{ usuario.cedula_usuario }}</td>
                                    <td>{{ usuario.nombre_usuario }}</td>
                                    <td>{{ usuario.direccion_usuario }}</td>
                                    <td>{{ usuario.correo_usuario }}</td>
                                    <td>{{ usuario.telefono_usuario }}</td>
                                    <td>{{ usuario.user_usuario }}</td>
                                    <td>{{ usuario.admin_usuario ? 'Sí' : 'No' }}</td>
                                    <td>
                                                <button class="btn btn-sm btn-warning me-2" title="Editar" @click="editCliente(usuario.cedula_usuario)">
                                                    <i class="bi bi-pencil-square"></i>
                                                </button>
                                        <button class="btn btn-sm btn-danger" title="Eliminar"
                                                @click="deleteCliente(usuario.cedula_usuario)">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>
                                    </td>                                   
                                </tr>
                            </tbody>
                            <button class="btn btn-naranja-principal mt-2 w-80" title="" style="margin-left: 10px;" href="/C_Cliente">
                                <i class="bi bi-person-plus-fill me-2"></i><router-link to="/C_Cliente" class="dropdown-item">Crear cliente</router-link>
                            </button>
                        </table>
                    </div>
                </div>
            </div>
        </main>
        <Footer_Admin/>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import Footer_Admin from './components/Footer_Admin.vue';
import Sidebar_Admin from './components/Sidebar_Admin.vue';

const usuarios = ref([])
const router = useRouter()

const axiosInstance = axios.create({
    baseURL: "http://localhost:3000/api",
}); 

async function initApp() {
    try {
        const res = await axiosInstance.get("/usuario");
        usuarios.value = res.data;
    } catch (error) {
        console.error("Error cargando usuarios:", error);
    }
};

onMounted(initApp);

// Navegar a la página de edición pasando la cédula en query
function editCliente(cedula) {
    if (!cedula) return;
    router.push({ path: '/E_Cliente', query: { cedula } });
}

// Función para eliminar cliente por cédula
async function deleteCliente(cedula) {
    if (!cedula) return;
    if (!confirm(`Eliminar cliente con cédula ${cedula}?`)) return;

    try {
        const res = await axiosInstance.delete(`/usuarios/${cedula}`);
        // actualizar lista local
        usuarios.value = usuarios.value.filter(u => u.cedula_usuario !== cedula);
        console.log('Cliente eliminado:', res.data);
    } catch (error) {
        if (error.response) {
            console.error('Error status:', error.response.status, 'data:', error.response.data);
        } else {
            console.error('Error:', error.message);
        }
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
    background-color: rgba(255, 255, 255, 0.9);
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
    color: rgb(235, 124, 34);
    transition: background-color 0.3s, transform 0.2s;
}

.btn-naranja-principal:hover {
    background-color: var(--naranja-oscuro) !important;
    border-color: var(--naranja-oscuro) !important;
    transform: translateY(-1px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3); 
}

/* 4. Estilos de Formulario y Título */
.titulo-admin {
    color: #fff; 
    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.8);
    font-weight: 700;
}

.form-label {
    font-weight: 600;
}

/* 5. Estilos de la Tabla */
.tabla-clientes {
    background-color: transparent; 
}

.tabla-clientes tbody tr:nth-child(odd) {
    background-color: rgba(255, 102, 0, 0.05); 
}

.tabla-clientes th, .tabla-clientes td {
    vertical-align: middle;
}
</style>