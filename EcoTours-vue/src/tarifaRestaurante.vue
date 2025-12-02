<template>
    <div class="pag-ADMIN-tarifas">
        <menu_ADMIN />

        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Menú y Tarifas</h1>
            <h2 class="text-center mb-4 sub-titulo-secundario">
                Tarifas para: {{ nombreProveedor || 'Cargando Restaurante...' }}
            </h2>

            <div v-if="message" :class="['alert mb-5', messageType === 'success' ? 'alert-success' : 'alert-danger']" role="alert">
                {{ message }}
            </div>

            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div class="card-header bg-naranja-principal text-white"> 
                    <h3 class="card-title mb-0">
                        {{ isEditing ? 'Editar Tarifa' : 'Registrar Nuevo Producto' }}
                    </h3>
                </div>
                <div class="card-body">
                    <form @submit.prevent="handleSubmit">
                        <div class="row g-3">
                            <input type="hidden" v-model="form.restaurante_id">

                            <div class="col-md-4">
                                <label for="tipo" class="form-label">Tipo de Producto</label>
                                <select id="tipo" class="form-select" v-model="form.tipo" required>
                                    <option value="" disabled>-- Seleccione un tipo --</option>
                                    <option value="Plato Principal">Plato Principal</option>
                                    <option value="Entrada">Entrada</option>
                                    <option value="Bebida">Bebida</option>
                                    <option value="Postre">Postre</option>
                                </select>
                            </div>

                            <div class="col-md-5">
                                <label for="nombre" class="form-label">Nombre del Producto</label>
                                <input type="text" class="form-control" id="nombre" v-model="form.nombre" required placeholder="Ej: Pasta Carbonara">
                            </div>

                            <div class="col-md-3">
                                <label for="precio" class="form-label">Precio Neto (USD)</label>
                                <input type="number" step="0.01" class="form-control" id="precio" v-model.number="form.precio" required min="0.01" placeholder="Ej: 15.50">
                            </div>

                        </div>

                        <div class="mt-4">
                            <button type="submit" class="btn btn-naranja-principal w-100 mb-2">
                                <i :class="isEditing ? 'bi bi-save-fill' : 'bi bi-plus-circle-fill'" class="me-2"></i>
                                {{ isEditing ? 'Guardar Cambios del Producto' : 'Registrar Producto al Menú' }}
                            </button>

                            <button v-if="isEditing" @click="resetForm" type="button" class="btn btn-secondary-admin w-100">
                                Cancelar Edición
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white"> 
                    <h3 class="card-title mb-0">Listado de Productos del Menú ({{ tarifas.length }})</h3>
                </div>
                <div class="card-body p-0">
                    
                    <div v-if="loading" class="text-center py-5 text-muted">
                        Cargando tarifas...
                    </div>
                    
                    <div v-else-if="error" class="text-center py-5 text-danger">
                        <p class="font-weight-bold">⚠️ Error al cargar las tarifas: {{ error }}</p>
                    </div>

                    <div v-else-if="tarifas.length === 0" class="text-center py-5 text-muted">
                        No hay productos registrados para este restaurante.
                    </div>

                    <div v-else class="table-responsive">
                        <table class="table table-striped table-hover tabla-datos">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th class="text-center">ID</th>
                                    <th>Tipo</th>
                                    <th>Producto</th>
                                    <th class="text-end">Precio (USD)</th>
                                    <th class="text-center">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="tarifa in tarifas" :key="tarifa.id">
                                    <td class="text-center">{{ tarifa.id }}</td>
                                    <td>{{ tarifa.tipo }}</td>
                                    <td>{{ tarifa.nombre }}</td>
                                    <td class="text-end fw-bold">${{ tarifa.precio.toFixed(2) }}</td>
                                    <td class="text-center">
                                        <button @click="startEdit(tarifa)" class="btn btn-sm btn-warning me-2" title="Editar">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <button @click="deleteTarifa(tarifa.id)" class="btn btn-sm btn-danger" title="Eliminar">
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
import { ref, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import axios from 'axios';
import menu_ADMIN from './components/menu_ADMIN.vue'; 
import Footer_Cliente from './components/Footer_Cliente.vue';

// --- Lógica de la API y Estados ---
const route = useRoute();
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000/api';

const proveedorId = computed(() => route.params.id);
const nombreProveedor = ref('');

const tarifas = ref([]);
const loading = ref(true);
const error = ref(null);
const message = ref('');
const messageType = ref('success');
const isEditing = ref(false);
const currentTarifaId = ref(null);

const form = ref({
    tipo: '',
    nombre: '',
    precio: 0,
    restaurante_id: proveedorId.value
});

// Función para obtener el nombre del restaurante
const fetchNombreProveedor = async () => {
    try {
        const response = await axios.get(`${API_URL}/restaurantes/${proveedorId.value}`); 
        nombreProveedor.value = response.data.nombre_restaurante || `Restaurante ID: ${proveedorId.value}`;
    } catch (e) {
        console.error("Error al obtener nombre de proveedor:", e);
        nombreProveedor.value = 'ERROR: No Encontrado';
    }
};

// 1. Obtener todas las tarifas del restaurante
const fetchTarifas = async () => {
    loading.value = true;
    error.value = null;
    try {
        const response = await axios.get(`${API_URL}/tarifasRestaurante/${proveedorId.value}`);
        tarifas.value = response.data;
    } catch (e) {
        console.error("Error al obtener las tarifas del restaurante:", e);
        error.value = 'Error al cargar las tarifas del restaurante.';
    } finally {
        loading.value = false;
    }
};

// 2. Enviar (Crear o Editar) Tarifa
const handleSubmit = async () => {
    form.value.restaurante_id = proveedorId.value;
    
    if (form.value.precio <= 0) {
        showMessage('El precio debe ser un valor positivo.', 'error');
        return;
    }

    try {
        if (isEditing.value) {
            await axios.put(`${API_URL}/tarifasRestaurante/${currentTarifaId.value}`, form.value);
            showMessage('Tarifa actualizada exitosamente.', 'success');
        } else {
            await axios.post(`${API_URL}/tarifasRestaurante`, form.value);
            showMessage('Tarifa creada exitosamente.', 'success');
        }
        
        await fetchTarifas();
        resetForm();
        
    } catch (e) {
        console.error("Error al enviar la tarifa:", e);
        showMessage(`Error al guardar la tarifa: ${e.response?.data?.message || e.message}`, 'error');
    }
};

// 3. Iniciar Edición
const startEdit = (tarifa) => {
    isEditing.value = true;
    currentTarifaId.value = tarifa.id;
    Object.assign(form.value, {
        tipo: tarifa.tipo,
        nombre: tarifa.nombre,
        precio: parseFloat(tarifa.precio), 
        restaurante_id: tarifa.restaurante_id
    });
    window.scrollTo({ top: 0, behavior: 'smooth' });
};

// 4. Eliminar Tarifa
const deleteTarifa = async (id) => {
    if (!confirm('¿Está seguro de que desea eliminar este producto del menú?')) {
        return;
    }
    
    try {
        await axios.delete(`${API_URL}/tarifasRestaurante/${id}`);
        showMessage('Producto eliminado exitosamente.', 'success');
        await fetchTarifas();
        if (currentTarifaId.value === id) {
            resetForm();
        }
    } catch (e) {
        console.error("Error al eliminar la tarifa:", e);
        showMessage(`Error al eliminar la tarifa: ${e.response?.data?.message || e.message}`, 'error');
    }
};

// 5. Resetear el formulario y estado de edición
const resetForm = () => {
    isEditing.value = false;
    currentTarifaId.value = null;
    form.value = {
        tipo: '',
        nombre: '',
        precio: 0,
        restaurante_id: proveedorId.value
    };
};

// 6. Mostrar mensaje temporal 
const showMessage = (msg, type) => {
    message.value = msg;
    messageType.value = type;
    setTimeout(() => {
        message.value = '';
    }, 4000);
};

// --- Ciclo de Vida ---
onMounted(() => {
    if (proveedorId.value) {
        fetchNombreProveedor();
        fetchTarifas();
    } else {
        error.value = "ID del restaurante no proporcionado en la URL.";
        loading.value = false;
    }
});
</script>

<style scoped>


.pag-ADMIN-tarifas {
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

.titulo-admin {
   color: #fff; 
   text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.8);
   font-weight: 700;
}
.sub-titulo-secundario {
    color: #e65c00; 
    font-weight: 600;
}
.tarjeta-transparente {
    background-color: rgba(255, 255, 255, 0.9);
    border-radius: 12px;
}
/* Colores de Marca */
.bg-naranja-principal { background-color: #ff6600 !important; }
.bg-naranja-oscuro { background-color: #e65c00 !important; }
.bg-naranja-claro { 
    background-color: #ffad66 !important; 
    color: #333 !important;
}

/* Botones */
.btn-naranja-principal { 
    background-color: #ff6600;
    border-color: #ff6600; 
    color: white; 
    transition: background-color 0.3s, transform 0.2s;
}
.btn-naranja-principal:hover {
     background-color: #e65c00;
     border-color: #e65c00;
     color: white;
}
.btn-secondary-admin {
    background-color: #6c757d;
    border-color: #6c757d;
    color: white;
    opacity: 1;
}


.alert-success {
    color: #0f5132;
    background-color: #d1e7dd;
    border-color: #badbcc;
}
.alert-danger {
    color: #842029;
    background-color: #f8d7da;
    border-color: #f5c2c7;
}


.form-control:focus, .form-select:focus {
    border-color: #ff6600;
    box-shadow: 0 0 0 0.25rem rgba(255, 102, 0, 0.25);
}
</style>