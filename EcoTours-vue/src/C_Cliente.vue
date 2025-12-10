<template>
    <div class="pag-ADMIN-clientes">
        <Sidebar_Admin />
        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Nuevo cliente</h1>
                <div class="card shadow-lg mb-5 tarjeta-transparente">
                    <div class="card-body">
                        <form>
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="cedula" class="form-label">Cédula</label>
                                    <input type="text" class="form-control" id="cedula" required>
                                </div>

                                <div class="col-md-15">
                                    <label for="nombre" class="form-label">Nombre y apellido</label>
                                    <input type="text" class="form-control" id="nombre" required>
                                </div>

                                <div class="col-md-15">
                                    <label for="nombre" class="form-label">Dirección</label>
                                    <input type="text" class="form-control" id="direccion" required>
                                </div>

                                <div class="col-md-3">
                                    <label for="email" class="form-label">Correo Electrónico</label>
                                    <input type="email" class="form-control" id="email" required>
                                </div>

                                <div class="col-md-2">
                                    <label for="telefono" class="form-label">Teléfono</label>
                                    <input type="tel" class="form-control" id="telefono" required>
                                </div>

                                <div class="col-md-3">
                                    <label for="usuario" class="form-label">Usuario</label>
                                    <input type="text" class="form-control" id="usuario" required>
                                </div>

                                <div class="col-md-4">
                                    <label for="contrasena" class="form-label">Contraseña</label>
                                    <input type="password" class="form-control" id="contrasena" required>
                                </div>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1">
                                <label class="form-check-label" for="gridRadios1">Administrador</label>
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
import { reactive, ref } from 'vue';
import Sidebar_Admin from './components/Sidebar_Admin.vue';
import Footer_Admin from './components/Footer_Admin.vue';
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