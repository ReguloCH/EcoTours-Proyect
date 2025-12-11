<template>
    <div class="pag-ADMIN-clientes">
        <Sidebar_Admin />
        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Nuevo cliente</h1>
                <div class="card shadow-lg mb-5 tarjeta-transparente">
                    <div class="card-body">
                        <form @submit.prevent="addItem">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="cedula_usuario" class="form-label">Cédula</label>
                                    <input v-model.number="newItem.cedula_usuario" type="number" class="form-control" id="cedula_usuario" required>
                                </div>

                                <div class="col-md-15">
                                    <label for="nombre_usuario" class="form-label">Nombre y apellido</label>
                                    <input v-model="newItem.nombre_usuario" type="text" class="form-control" id="nombre_usuario" required>
                                </div>

                                <div class="col-md-15">
                                    <label for="direccion_usuario" class="form-label">Dirección</label>
                                    <input v-model="newItem.direccion_usuario" type="text" class="form-control" id="direccion_usuario" required>
                                </div>

                                <div class="col-md-2">
                                    <label for="telefono_usuario" class="form-label">Teléfono</label>
                                    <input v-model="newItem.telefono_usuario" type="tel" class="form-control" id="telefono_usuario" required>
                                </div>

                                <div class="col-md-3">
                                    <label for="correo_usuario" class="form-label">Correo Electrónico</label>
                                    <input v-model="newItem.correo_usuario" type="email" class="form-control" id="correo_usuario" required>
                                </div>

                                <div class="col-md-3">
                                    <label for="user_usuario" class="form-label">Usuario</label>
                                    <input v-model="newItem.user_usuario" type="text" class="form-control" id="user_usuario" required>
                                </div>

                                <div class="col-md-4">
                                    <label for="contrasena_usuario" class="form-label">Contraseña</label>
                                    <input v-model="newItem.contrasena_usuario" type="password" class="form-control" id="contrasena_usuario" required>
                                </div>
                            </div>
                            <br>
                            <div class="form-check">
                                <input v-model="newItem.admin_usuario" class="form-check-input" type="checkbox" id="admin_usuario">
                                <label class="form-check-label" for="admin_usuario">Administrador</label>
                            </div>                
                            <button type="submit" class="btn btn-naranja-principal mt-4 w-100">
                            <i class="bi bi-person-plus-fill me-2"></i>Agregar
                            </button>
                        </form>
                    </div>
                </div>
            </main>
        <Footer_Admin />
    </div>
</template>

<script setup>
// IMPORTS
import axios from 'axios';
import { ref, reactive } from 'vue';
import Sidebar_Admin from './components/Sidebar_Admin.vue';
import Footer_Admin from './components/Footer_Admin.vue';

axios.defaults.baseURL = 'http://localhost:3000'; // mover baseURL aquí

const items = ref([]);

const newItem = reactive({
    cedula_usuario: null,
    nombre_usuario: '',
    direccion_usuario: '',
    telefono_usuario: '',
    correo_usuario: '',
    user_usuario: '',
    contrasena_usuario: '',
    admin_usuario: false
});

function resetForm() {
    newItem.cedula_usuario = null;
    newItem.nombre_usuario = '';
    newItem.direccion_usuario = '';
    newItem.telefono_usuario = '';
    newItem.correo_usuario = '';
    newItem.user_usuario = '';
    newItem.contrasena_usuario = '';
    newItem.admin_usuario = false;
}

async function addItem() {
    // construir payload con tipos y claves exactas (nota la ñ en contraseña)
    const payload = {
        nombre_usuario: String(newItem.nombre_usuario).trim(),
        cedula_usuario: parseInt(newItem.cedula_usuario, 10) || 0,
        direccion_usuario: newItem.direccion_usuario || '',
        telefono_usuario: newItem.telefono_usuario || '',
        correo_usuario: newItem.correo_usuario || '',
        user_usuario: newItem.user_usuario || '',
        admin_usuario: Boolean(newItem.admin_usuario)
    };
    // clave con ñ
    payload['contraseña_usuario'] = newItem.contrasena_usuario || '';

    // guardar local (opcional)
    items.value.push({ ...payload });

    try {
        const res = await axios.post('/api/usuarios', payload);
        console.log('Success:', res.data);
    } catch (error) {
        // mostrar info útil de error 400
        if (error.response) {
            console.error('Error status:', error.response.status, 'data:', error.response.data);
        } else {
            console.error('Error:', error.message);
        }
    }
    resetForm();
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
</style>