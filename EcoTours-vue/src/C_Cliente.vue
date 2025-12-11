<template>
    <div class="pag-ADMIN-clientes">
        <Sidebar_Admin />
        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Clientes</h1>
            
            <!-- Mensaje de Notificación -->
            <div v-if="message" :class="['alert mb-5', messageType === 'success' ? 'alert-success' : 'alert-danger']" role="alert">
                {{ message }}
            </div>

            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div class="card-header bg-naranja-principal text-white">
                    <h3 class="card-title mb-0">Registrar Nuevo Cliente</h3>
                </div>
                <div class="card-body">
                    <form @submit.prevent="addItem">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label for="cedula_usuario" class="form-label">Cédula</label>
                                <input v-model.number="newItem.cedula_usuario" type="number" class="form-control" id="cedula_usuario" required placeholder="Solo números">
                            </div>

                            <div class="col-md-8">
                                <label for="nombre_usuario" class="form-label">Nombre y Apellido</label>
                                <input v-model="newItem.nombre_usuario" type="text" class="form-control" id="nombre_usuario" required>
                            </div>

                            <div class="col-md-12">
                                <label for="direccion_usuario" class="form-label">Dirección</label>
                                <input v-model="newItem.direccion_usuario" type="text" class="form-control" id="direccion_usuario" required>
                            </div>

                            <div class="col-md-3">
                                <label for="telefono_usuario" class="form-label">Teléfono</label>
                                <input v-model="newItem.telefono_usuario" type="tel" class="form-control" id="telefono_usuario" required placeholder="04141234567">
                            </div>

                            <div class="col-md-5">
                                <label for="correo_usuario" class="form-label">Correo Electrónico</label>
                                <input v-model="newItem.correo_usuario" type="email" class="form-control" id="correo_usuario" required>
                            </div>

                            <div class="col-md-4">
                                <label for="user_usuario" class="form-label">Usuario (Login)</label>
                                <input v-model="newItem.user_usuario" type="text" class="form-control" id="user_usuario" required>
                            </div>

                            <div class="col-md-6">
                                <label for="contrasena_usuario" class="form-label">Contraseña</label>
                                <input v-model="newItem.contrasena_usuario" type="password" class="form-control" id="contrasena_usuario" required minlength="6">
                            </div>
                            
                            <div class="col-md-6 d-flex align-items-center mt-5">
                                <div class="form-check">
                                    <input v-model="newItem.admin_usuario" class="form-check-input" type="checkbox" id="admin_usuario">
                                    <label class="form-check-label fw-bold" for="admin_usuario">¿Es Administrador?</label>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-naranja-principal mt-4 w-100">
                            <i class="bi bi-person-plus-fill me-2"></i>Agregar Cliente
                        </button>
                    </form>
                </div>
            </div>
        </main>
        <Footer_Admin />
    </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import axios from 'axios';
import Sidebar_Admin from './components/Sidebar_Admin.vue';
import Footer_Admin from './components/Footer_Admin.vue';

// Configuración de Axios para este componente (o global si ya lo tienes en main.js)
axios.defaults.baseURL = 'http://localhost:3000';

// Estado
const message = ref(null);
const messageType = ref('success');

const newItem = reactive({
    cedula_usuario: '',
    nombre_usuario: '',
    direccion_usuario: '',
    telefono_usuario: '',
    correo_usuario: '',
    user_usuario: '',
    contrasena_usuario: '',
    admin_usuario: false
});

function inicializarFormulario() {
    newItem.cedula_usuario = '';
    newItem.nombre_usuario = '';
    newItem.direccion_usuario = '';
    newItem.telefono_usuario = '';
    newItem.correo_usuario = '';
    newItem.user_usuario = '';
    newItem.contrasena_usuario = '';
    newItem.admin_usuario = false;
}

function mostrarMensaje(msg, type) {
    message.value = msg;
    messageType.value = type;
    setTimeout(() => message.value = null, 4000);
}

async function addItem() {
    try {
        // Construimos el payload exacto que espera el backend (usuarioController.js)
        const payload = {
            cedula_usuario: parseInt(newItem.cedula_usuario),
            nombre_usuario: newItem.nombre_usuario,
            direccion_usuario: newItem.direccion_usuario,
            telefono_usuario: newItem.telefono_usuario,
            correo_usuario: newItem.correo_usuario,
            user_usuario: newItem.user_usuario,
            contraseña_usuario: newItem.contrasena_usuario, // Importante: backend espera 'contraseña_usuario' con ñ
            admin_usuario: newItem.admin_usuario
        };

        const response = await axios.post('/api/usuario', payload);

        if (response.status === 201) {
            mostrarMensaje('Usuario registrado exitosamente.', 'success');
            inicializarFormulario();
        }
    } catch (error) {
        console.error('Error al registrar:', error);
        const msg = error.response?.data?.error || 'Error al conectar con el servidor';
        mostrarMensaje(msg, 'danger');
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
    color: white; /* Texto blanco puro */
    font-weight: 600;
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
    color: var(--naranja-oscuro); 
    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
    font-weight: 700;
    background-color: rgba(255, 255, 255, 0.8);
    padding: 10px;
    border-radius: 8px;
    display: inline-block;
}

.form-label {
    font-weight: 600;
    color: var(--naranja-oscuro);
}
</style>