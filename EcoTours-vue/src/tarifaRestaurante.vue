<template>
    <div class="pag-ADMIN-tarifas">
        <menu_ADMIN />

        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Tarifas por Restaurante</h1>
            
            <div v-if="message" :class="['alert mb-5', messageType === 'success' ? 'alert-success' : 'alert-danger']" role="alert">
                {{ message }}
            </div>

            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div class="card-header bg-naranja-principal text-white"> 
                    <h3 class="card-title mb-0">
                        {{ isEditing ? 'Editar Tarifa Diaria' : 'Registrar Nueva Tarifa Diaria' }}
                    </h3>
                </div>
                <div class="card-body">
                    <form @submit.prevent="handleSubmit">
                        <div class="row g-3"> 
                            
                            <div class="col-md-6 col-lg-4">
                                <label for="restaurante_id" class="form-label">Restaurante</label>
                                <select id="restaurante_id" class="form-select" v-model="form.restaurante_id" required>
                                    <option value="" disabled>-- Seleccione un Restaurante --</option>
                                    <option v-for="restaurante in listaRestaurantes" :key="restaurante.id" :value="restaurante.id">
                                        {{ restaurante.nombre_restaurante }}
                                    </option>
                                </select>
                            </div>

                            <div class="col-md-6 col-lg-8">
                                <label for="direccion" class="form-label">Dirección</label>
                                <input type="text" class="form-control" id="direccion" v-model="form.direccion" required placeholder="Ingrese la dirección del restaurante">
                            </div>

                            <div class="col-12 col-lg-6"> 
                                <label for="precio_dia" class="form-label">Precio por Día</label>
                                <input type="number" step="0.01" class="form-control" id="precio_dia" v-model.number="form.precio_dia" required min="0.01" placeholder="Ej: 50.00">
                            </div>
                        </div>

                        <div class="mt-4 row g-3">
                            <div class="col-12"> 
                                <button type="submit" class="btn btn-naranja-principal w-100">
                                    <i :class="isEditing ? 'bi bi-save-fill' : 'bi bi-plus-circle-fill'" class="me-2"></i>
                                    {{ isEditing ? 'Guardar Cambios' : 'Registrar' }}
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </main>
        
        <Footer_Cliente />
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import menu_ADMIN from './components/menu_ADMIN.vue'; 
import Footer_Cliente from './components/Footer_Cliente.vue';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000/api';

const listaRestaurantes = ref([]);
const message = ref('');
const messageType = ref('success');
const isEditing = ref(false); 

const form = ref({
    restaurante_id: '',
    direccion: '',
    precio_dia: 0,
});

// Función para obtener la lista de restaurantes para el select
const fetchRestaurantes = async () => {
    try {
        const response = await axios.get(`${API_URL}/restaurantes`); 
        listaRestaurantes.value = response.data;
    } catch (e) {
        console.error("Error al obtener la lista de restaurantes:", e);
        showMessage('Error al cargar la lista de restaurantes.', 'error');
    }
};

// Función para cargar la tarifa existente (si la hay) para el restaurante seleccionado
const fetchTarifaExistente = async (restauranteId) => {
    try {
        const response = await axios.get(`${API_URL}/tarifasDiarias/${restauranteId}`);
        const tarifa = response.data; 
        if (tarifa) {
            Object.assign(form.value, {
                direccion: tarifa.direccion,
                precio_dia: parseFloat(tarifa.precio_dia),
            });
            isEditing.value = true;
        } else {
            resetForm();
        }
    } catch (e) {
        resetForm();
    }
};

// Enviar (Crear o Editar) Tarifa
const handleSubmit = async () => {
    
    if (form.value.precio_dia <= 0) {
        showMessage('El Precio por Día debe ser un valor positivo.', 'error');
        return;
    }

    try {
        const dataToSend = {
            restaurante_id: form.value.restaurante_id,
            direccion: form.value.direccion,
            precio_dia: form.value.precio_dia,
        };

        if (isEditing.value) {
            await axios.put(`${API_URL}/tarifasDiarias/${form.value.restaurante_id}`, dataToSend);
            showMessage('Tarifa por Restaurante actualizada exitosamente.', 'success');
        } else {
            await axios.post(`${API_URL}/tarifasDiarias`, dataToSend);
            showMessage('Tarifa por Restaurante registrada exitosamente.', 'success');
        }
        
    } catch (e) {
        console.error("Error al enviar la tarifa:", e);
        showMessage(`Error al guardar la tarifa: ${e.response?.data?.message || e.message}`, 'error');
    }
};


// 5. Resetear el formulario y estado de edición
const resetForm = () => {
    isEditing.value = false;
    form.value.direccion = '';
    form.value.precio_dia = 0;
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
    fetchRestaurantes();
});
</script>

<style scoped>
/* Las clases de estilo se mantienen igual */
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