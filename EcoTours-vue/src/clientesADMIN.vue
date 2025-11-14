<template>
    <div class="pag-ADMIN-clientes">
        <menu_ADMIN />

        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Clientes</h1>

            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div class="card-header bg-naranja-principal text-white">
                    <h3 class="card-title mb-0">Registrar Nuevo Cliente</h3>
                </div>
                <div class="card-body">
                    <form @submit.prevent="agregarCliente">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" v-model="clienteNuevo.nombre" required>
                            </div>
                            <div class="col-md-4">
                                <label for="apellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="apellido" v-model="clienteNuevo.apellido" required>
                            </div>
                            <div class="col-md-4">
                                <label for="cedula" class="form-label">Cédula</label>
                                <input type="text" class="form-control" id="cedula" v-model="clienteNuevo.cedula" required>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label">Correo Electrónico</label>
                                <input type="email" class="form-control" id="email" v-model="clienteNuevo.correo" required>
                            </div>
                            <div class="col-md-6">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="tel" class="form-control" id="telefono" v-model="clienteNuevo.telefono" required>
                            </div>
                            <div class="col-12">
                                <label for="direccion" class="form-label">Dirección</label>
                                <input type="text" class="form-control" id="direccion" v-model="clienteNuevo.direccion" required>
                            </div>
                            <div class="col-md-4">
                                <label for="fechaRegistro" class="form-label">Fecha de Registro</label>
                                <input type="date" class="form-control" id="fechaRegistro" v-model="clienteNuevo.fechaRegistro" required>
                            </div>
                            <div class="col-md-4">
                                <label for="usuario" class="form-label">Usuario</label>
                                <input type="text" class="form-control" id="usuario" v-model="clienteNuevo.usuario" required>
                            </div>
                            <div class="col-md-4">
                                <label for="contrasena" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="contrasena" v-model="clienteNuevo.contrasena" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-naranja-principal mt-4 w-100">
                            <i class="bi bi-person-plus-fill me-2"></i>Agregar
                        </button>
                    </form>
                </div>
            </div>




            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white">
                    <h3 class="card-title mb-0">Clientes Registrados (Total: {{ listaClientes.length }})</h3>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover tabla-clientes">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre Completo</th>
                                    <th>Cédula</th>
                                    <th>Correo</th>
                                    <th>Teléfono</th>
                                    <th>Dirección</th>
                                    <th>Fecha Reg.</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="listaClientes.length === 0">
                                    <td colspan="8" class="text-center text-muted">No hay clientes registrados aún.</td>
                                </tr>
                                <tr v-else v-for="(cliente, index) in listaClientes" :key="cliente.id">
                                    <td>{{ cliente.id }}</td>
                                    <td>{{ cliente.nombre }} {{ cliente.apellido }}</td>
                                    <td>{{ cliente.cedula }}</td>
                                    <td>{{ cliente.correo }}</td>
                                    <td>{{ cliente.telefono }}</td>
                                    <td>{{ cliente.direccion }}</td>
                                    <td>{{ cliente.fechaRegistro }}</td>
                                    <td>
                                        <button @click="cargarParaEditar(cliente)" class="btn btn-sm btn-warning me-2" title="Editar">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <button @click="eliminarCliente(cliente.id)" class="btn btn-sm btn-danger" title="Eliminar">
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
// ESTE SCRIPT UTILIZA VUE 3 COMPOSITION API (<script setup>) PARA MEJOR ORGANIZACIÓN.

// IMPORTS
import { reactive, ref } from 'vue';
import menu_ADMIN from './components/menu_ADMIN.vue';
import FooterIni from './components/footerIni.vue';

// DECLARACIÓN DE VARIABLES Y ARREGLOS (SIMULACIÓN DE BDD) //

// Arreglo principal que simula la Base de Datos de clientes
const listaClientes = reactive([
    {
        id: 1, nombre: 'Ana', apellido: 'García', cedula: '12345678', correo: 'ana@mail.com', 
        telefono: '555-1234', direccion: 'Av. Sol #10', fechaRegistro: '2024-01-10', 
        usuario: 'anag', contrasena: '1234'
    },
    {
        id: 2, nombre: 'Luis', apellido: 'Pérez', cedula: '87654321', correo: 'luis@mail.com', 
        telefono: '555-5678', direccion: 'Calle Luna #5', fechaRegistro: '2024-03-20', 
        usuario: 'luisp', contrasena: '5678'
    },
]);

// Objeto reactivo para capturar los datos del formulario de registro/edición
// Usamos 'ref' para el ID del cliente que estamos editando
const siguienteId = ref(listaClientes.length + 1);
const idClienteEditando = ref(null); // Guarda el ID del cliente que se está editando (null si es nuevo)
// Objeto reactivo para el formulario (usado con v-model)
const clienteNuevo = reactive(inicializarCliente());

// Función de utilidad para limpiar el formulario y establecer valores por defecto
function inicializarCliente() {
    return {
        id: 0,
        nombre: '',
        apellido: '',
        cedula: '',
        correo: '',
        telefono: '',
        direccion: '',
        fechaRegistro: new Date().toISOString().substr(0, 10), // Fecha actual por defecto
        usuario: '',
        contrasena: ''
    };
}


//  MÉTODOS (LÓGICA DE GESTIÓN)// 

// Método para agregar o actualizar un cliente
function agregarCliente() {
    if (idClienteEditando.value) {
        // Lógica de EDICIÓN
        const index = listaClientes.findIndex(c => c.id === idClienteEditando.value);
        if (index !== -1) {
            // Reemplaza el objeto antiguo con los nuevos datos del formulario
            Object.assign(listaClientes[index], clienteNuevo);
            alert(`Cliente ${clienteNuevo.nombre} actualizado con éxito.`);
        }
    } else {
        // Lógica de REGISTRO (Nuevo cliente)
        const nuevo = { ...clienteNuevo }; // Copia los datos del formulario
        nuevo.id = siguienteId.value; // Asigna el ID incremental
        listaClientes.push(nuevo); // Agrega el nuevo objeto al arreglo (simulando INSERT)
        siguienteId.value++; // Incrementa el ID para el próximo cliente
        alert(`Cliente ${nuevo.nombre} registrado con éxito. ID: ${nuevo.id}`);
    }
    // Limpia el formulario y resetea el modo edición
    limpiarFormulario();
}

// Carga los datos de un cliente seleccionado al formulario para edición
function cargarParaEditar(cliente) {
    // Establece el ID del cliente que se va a editar
    idClienteEditando.value = cliente.id;
    // aqui estamos asignando todos los valores del cliente al objeto clienteNuevo
    Object.assign(clienteNuevo, cliente);
}

// Resetea el formulario y el estado de edición
function limpiarFormulario() {
    // Restablece el formulario a su estado inicial
    Object.assign(clienteNuevo, inicializarCliente());
    // Sale del modo edición
    idClienteEditando.value = null;
}

// Método para eliminar un cliente por su ID
function eliminarCliente(id) {
    if (confirm('¿Está seguro de que desea eliminar este cliente?')) {
        // Filtra la lista, manteniendo solo los clientes cuyo ID no coincida con el ID a eliminar
        const index = listaClientes.findIndex(c => c.id === id);
        if (index !== -1) {
            listaClientes.splice(index, 1); // Simula que elimina al cliente
            alert('Cliente eliminado.');
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