<template>
    <div class="pag-ADMINini">
        <menu_ADMIN />
        <main class="admin-dashboard-main container-xl py-5">
            <h1 class="dashboard-title text-center mb-5">
                Bienvenido Administrador
            </h1>

            <!-- TARJETAS DE RESUMEN DE: Clientes Registrados, Paquetes Activos, Reservas, Proveedores Registrados -->


            <div class="row g-4">
                <div class="col-xl-3 col-md-6">
                    <div class="dashboard-card shadow-sm h-100 p-4">
                        <div class="card-icon mb-3">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <h3 class="card-title">Clientes Registrados</h3>
                        <p class="card-metric">{{ metrics.totalClients }}</p>
                        <div class="card-footer-info">
                            <span v-if="metrics.clientGrowthRate > 0" class="text-success me-2">
                                ▲ {{ metrics.clientGrowthRate }}% desde la semana pasada
                            </span>
                            <span v-else class="text-danger me-2">
                                ▼ {{ Math.abs(metrics.clientGrowthRate) }}% desde la semana pasada
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6">
                    <div class="dashboard-card shadow-sm h-100 p-4">
                        <div class="card-icon mb-3">
                            <i class="bi bi-briefcase-fill"></i>
                        </div>
                        <h3 class="card-title">Paquetes Activos</h3>
                        <p class="card-metric">{{ metrics.activePackages }}</p>
                        <div class="card-footer-info">
                            <span class="text-warning me-2">● {{ metrics.newPackages }} nuevos</span> este mes
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6">
                    <div class="dashboard-card shadow-sm h-100 p-4">
                        <div class="card-icon mb-3">
                            <i class="bi bi-calendar-check-fill"></i>
                        </div>
                        <h3 class="card-title">Reservas</h3>
                        <p class="card-metric">
                            {{ metrics.pendingBookings }} Pendientes / {{ metrics.confirmedBookings }} Confirmadas
                        </p>
                        <div class="card-footer-info">
                            <span v-if="metrics.pendingBookings > 0" class="text-primary me-2">
                                ★ {{ metrics.pendingBookings }} recientes
                            </span>
                            <span v-else class="text-success me-2">
                                ✓ Todas al día
                            </span>
                            por confirmar
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6">
                    <div class="dashboard-card shadow-sm h-100 p-4">
                        <div class="card-icon mb-3">
                            <i class="bi bi-shop"></i>
                        </div>
                        <h3 class="card-title">Proveedores Registrados</h3>
                        <p class="card-metric">{{ metrics.registeredSuppliers }}</p>
                        <div class="card-footer-info">
                            <span class="text-info me-2">▲ 2%</span> de crecimiento anual
                        </div>
                    </div>
                </div>
            </div>



            <!-- GRAFICO DE BARRA -->


            <div class="row g-4 mt-5">
                <div class="col-lg-6">
                    <div class="dashboard-chart-card shadow-sm h-100 p-4">
                        <h4 class="chart-title mb-4">Registro de Clientes por Mes</h4>
                        <div class="chart-placeholder bar-chart">
                            <div class="bar-item" 
                                v-for="(data, index) in monthlyRegistration"
                                :key="index"
                                :style="`height: ${data.value}%; background-color: ${data.color};`">
                                <span class="bar-value">{{ data.count }}</span> 
                                <span class="bar-label">{{ data.month }}</span>
                            </div>
                        </div>
                    </div>
                </div>



                <!-- GRAFICO DE TORTA -->

                <div class="col-lg-6">
                    <div class="dashboard-chart-card shadow-sm h-100 p-4">
                        <h4 class="chart-title mb-4">Estado General de Reservas</h4>
                        <div class="chart-placeholder pie-chart" :style="pieChartStyle">
                            <div class="pie-chart-content">
                                <span class="pie-center-value">{{ bookingStatus.confirmedPercent }}%</span>
                                <span class="pie-center-label">Confirmadas</span>
                            </div>
                        </div>
                        <div class="pie-chart-labels">
                            <span class="pie-label confirmed">Confirmadas ({{ bookingStatus.confirmedPercent }}%)</span>
                            <span class="pie-label pending">Pendientes ({{ bookingStatus.pendingPercent }}%)</span>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        
        <FooterIni />
    </div>
</template>

<script setup>
//  IMPORTS
import { ref, reactive, computed } from 'vue'; 
import menu_ADMIN from './components/menu_ADMIN.vue';
import FooterIni from './components/footerIni.vue';

// DECLARACIÓN DE VARIABLES REACTIVAS (Simulación de BDD)
// Uso de reactive() para un objeto de métricas (simulación de registro de BDD)
const metrics = reactive({
    totalClients: 1250,
    activePackages: 45,
    pendingBookings: 15,
    confirmedBookings: 280,
    registeredSuppliers: 80,
    clientGrowthRate: 12, 
    newPackages: 3,
});

// ARREGLO PARA GRAFICAS DE BARRA (Registro de Clientes por Mes)
// 'count' es el valor real, 'value' es el % de altura (el maximo es 100) para la simulación visual.
const monthlyRegistration = reactive([
    { month: 'Enero', count: 120, value: 60, color: '#ff6600' },
    { month: 'Febrero', count: 150, value: 75, color: '#ff8533' },
    { month: 'Marzo', count: 100, value: 50, color: '#ffad66' },
    { month: 'Abril', count: 180, value: 90, color: '#ff6600' },
    { month: 'Mayo', count: 130, value: 65, color: '#ff8533' },
    { month: 'Junio', count: 160, value: 80, color: '#ffad66' },
    { month: 'Julio', count: 120, value: 60, color: '#ff6600' },
    { month: 'Agosto', count: 100, value: 50, color: '#ffad66' },
    { month: 'Septiembre', count: 160, value: 80, color: '#ffad66' },


]);

// GRAFICO TORTA Calcula los porcentajes de reservas y genera el estilo para el gráfico de torta.
const bookingStatus = computed(() => {
    const totalBookings = metrics.confirmedBookings + metrics.pendingBookings;
    const confirmedPercent = Math.round((metrics.confirmedBookings / totalBookings) * 100);
    const pendingPercent = 100 - confirmedPercent;

    return {
        confirmedPercent,
        pendingPercent,
    };
});
// Propiedad calculada para generar el estilo dinámico del gráfico de torta (v-bind)
const pieChartStyle = computed(() => {
    const { confirmedPercent } = bookingStatus.value;
    // Genera el estilo del conic-gradient para el v-bind:style
    return `background: conic-gradient(
        var(--primary-orange) 0% ${confirmedPercent}%,
        var(--light-orange) ${confirmedPercent}% 100%
    );`;
});
</script>

<style>

/* Contenedor de toda la vista con fondo de imagen */
.pag-ADMINini {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    background: url('/img/FONDOiniADD.jpg') no-repeat center center fixed;
    background-size: cover;
    color: #333; 
}

/*============ESTILOS ESPECÍFICOS PARA EL DASHBOARD DE ADMINISTRACIÓN (iniADMIN.vue)===========*/
@import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css");
:root {
    --primary-orange: #ff6600; 
    --light-orange: #ffad66;   
    --bg-admin: #f0f2f5;      
}

/* Contenedor principal del dashboard */
.admin-dashboard-main {
    min-height: calc(100vh - 120px); 
}

.dashboard-title {
    color: #fff; 
    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
    font-weight: 700;
    font-size: 2.5em;
}

/* Estilo de las tarjetas de métricas - con transparencia */
.dashboard-card {
    background-color: rgba(255, 255, 255, 0.9); 
    border-radius: 12px;
    text-align: left;
    position: relative;
    overflow: hidden;
    border: 1px solid #e0e0e0;
}

/* Estilo para las tarjetas de gráficos*/
.dashboard-chart-card {
    background-color: rgba(255, 255, 255, 0.9); 
    border-radius: 12px;
    border: 1px solid #e0e0e0;
    height: 400px; 
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
    padding: 25px !important;
}

/* --- SIMULACIÓN DE GRÁFICOS --- */
.chart-placeholder {
    width: 100%;
    height: 250px; 
    display: flex;
    justify-content: center;
    align-items: flex-end; 
    padding: 10px;
    gap: 10px;
}

/* Gráfico de Barras */
.bar-chart {
    align-items: flex-end;
}
.bar-chart .bar-item {
    width: 40px;
    border-radius: 5px 5px 0 0;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    color: #fff;
    font-size: 0.8em;
    padding-top: 5px;
    position: relative;
    transition: all 0.3s ease-out;
}
.bar-chart .bar-item .bar-value {
    position: absolute;
    top: -20px; 
    color: #333; 
    font-weight: bold;
    font-size: 0.8em;
}
.bar-chart .bar-item .bar-label {
    position: absolute;
    bottom: -20px; 
    color: #555;
    font-size: 0.7em;
}

/* Gráfico de Torta/Pastel */
.pie-chart {
    position: relative;
    width: 180px; 
    height: 180px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 20px auto 10px auto; 
}
.pie-chart::before {
    content: '';
    position: absolute;
    background: white;
    width: 100px; 
    height: 100px;
    border-radius: 50%;
    z-index: 2; 
}

.pie-chart-content {
    position: absolute;
    z-index: 3;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 100px; 
    height: 100px;
}

.pie-chart-content .pie-center-value {
    font-size: 1.6em;
    font-weight: 700;
    color: var(--primary-orange);
    line-height: 1;
}

.pie-chart-content .pie-center-label {
    font-size: 0.8em;
    color: #555;
    text-align: center;
}


.pie-chart-labels {
    width: 100%;
    margin-top: 15px; 
    text-align: center;
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
}
.pie-chart-labels .pie-label {
    display: flex;
    align-items: center;
    font-size: 0.9em;
    color: #555;
    margin: 5px 15px; 
}
.pie-chart-labels .pie-label::before {
    content: '';
    display: inline-block;
    width: 10px;
    height: 10px;
    border-radius: 50%;
    margin-right: 5px;
}
.pie-chart-labels .pie-label.confirmed::before { background-color: var(--primary-orange); }
.pie-chart-labels .pie-label.pending::before { background-color: var(--light-orange); }
</style>