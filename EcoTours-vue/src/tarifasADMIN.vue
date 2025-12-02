<template>
    <div class="pag-ADMIN-general">
        <Sidebar_Admin />

        <div class="header-proveedores d-flex align-items-center justify-content-center">
            <h1 class="header-titulo">Gestión de tarifas</h1>
        </div>

        <main class="container-xl py-5 main-content-admin">
            <h2 class="text-center mb-5 sub-titulo">Selecciona la Categoría a Administrar</h2>

            <div class="row g-4 justify-content-center">
                <!--ESTO POR AQUI SON LOS CONTENEDORES Y TARJETA 1  -->
                <div class="col-lg-4 col-md-6">
                    <router-link to="/tarifaPorDestino" class="card-link">
                        <div class="dashboard-card tarjeta-transparente-naranja shadow-lg h-100 p-4 text-center zoom-hover">
                            <div class="card-icon-lg mb-3">
                                <i class="bi bi-airplane-fill"></i>
                            </div>
                            <h3 class="card-title-lg">Aerolíneas</h3>
                            <p class="card-text text-muted">Administra tarifas aéreas.</p>
                        </div>
                    </router-link>
                </div>
                <!--ESTO POR AQUI SON LOS CONTENEDORES Y TARJETA 2  -->

                <div class="col-lg-4 col-md-6">
                    <router-link to="/tarifasHospedaje" class="card-link">
                        <div class="dashboard-card tarjeta-transparente-naranja shadow-lg h-100 p-4 text-center zoom-hover">
                            <div class="card-icon-lg mb-3">
                                <i class="bi bi-building-fill-check"></i>
                            </div>
                            <h3 class="card-title-lg">Hospedaje</h3>
                            <p class="card-text text-muted">Gestiona hoteles, *resorts* y alojamientos.</p>
                        </div>
                    </router-link>
                </div>
                <!--ESTO POR AQUI SON LOS CONTENEDORES Y TARJETA 3  -->

                <div class="col-lg-4 col-md-6">
                    <router-link to="/tarifaRestaurante" class="card-link">
                        <div class="dashboard-card tarjeta-transparente-naranja shadow-lg h-100 p-4 text-center zoom-hover">
                            <div class="card-icon-lg mb-3">
                                <i class="bi bi-egg-fried"></i>
                            </div>
                            <h3 class="card-title-lg">Alimentación</h3>
                            <p class="card-text text-muted">Control de restaurantes, catering y planes de comida.</p>
                        </div>
                    </router-link>
                </div>

            </div>
        </main>
        <!--COMPONENTE DEL FOOTER  -->

        <Footer_Admin />

    </div>
</template>

<script>
// IMPORTS
import Sidebar_Admin from './components/Sidebar_Admin.vue';
import Footer_Admin from './components/Footer_Admin.vue';
import aerolineasPROV from './aerolineasPROV.vue';
import hospedajePROV from './hospedajePROV.vue';
import alimentacionPROV from './alimentacionPROV.vue';

export default {
    //nombre del componente, esto nos ayuda con el tema de las rutas 
    name: 'proveedoresADMIN',
    //Los componentes usados, aqui observamos que hay mas de lo normal y es pq partiendo desde aqui, iremos a los proveedores de los paqutes 
    components: {
        Sidebar_Admin,
        Footer_Admin,
        aerolineasPROV,
        hospedajePROV,
        alimentacionPROV
    },
};
</script>

<style scoped>


/*  ESTILOS PARA PROVEEDORESADMIN.VUE */

:root {
    --naranja-principal: #ff6600; 
    --naranja-oscuro: #e65c00;
    --naranja-claro: #ffad66; 
}

/* Contenedor Principal (Hereda fondo global si existe) */
.pag-ADMIN-general {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    color: #333;
}

/* 2. Header de Imagen (Banner) */
.header-proveedores {
    height: 250px; 
    background: url('/img/proveedoresADMIN.png') no-repeat center center;
    background-size: cover;
    position: relative;
    overflow: hidden;
    z-index: 1;
}

.header-proveedores::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    /* Capa oscura/naranja sobre la imagen para mejorar contraste */
    background-color: rgba(0, 0, 0, 0.4); 
    z-index: 2;
}

.header-titulo {
    z-index: 3; /* Aseguramos que el título esté sobre la capa */
    color: white;
    font-size: 3rem;
    font-weight: 700;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.8);
    transition: all 0.5s ease-out; /* Prepara para la posible transición de entrada */
}

/* 3. Tarjetas de Categoría (Navegación) */

.sub-titulo {
    color: var(--naranja-oscuro);
    font-weight: 700;
}

.card-link {
    text-decoration: none; /* Quitamos el subrayado del enlace */
    color: inherit;
    display: block; /* Aseguramos que ocupe todo el espacio de la columna */
}

/* Estilo de la tarjeta transparente con borde naranja */
.tarjeta-transparente-naranja {
    background-color: rgba(255, 255, 255, 0.9);
    border: 3px solid var(--naranja-claro); /* Borde naranja claro */
    border-radius: 15px;
    transition: all 0.3s ease-in-out;
}

/* Efecto de Zoom al pasar el mouse */
.zoom-hover:hover {
    border-color: var(--naranja-principal); /* Borde más oscuro al hacer hover */
    transform: scale(1.03);
    box-shadow: 0 10px 20px rgba(255, 102, 0, 0.3) !important;
}

.card-icon-lg {
    color: var(--naranja-principal); /* Íconos en naranja principal */
    font-size: 4rem;
    line-height: 1;
}

.card-title-lg {
    font-weight: 700;
    color: #333;
    margin-bottom: 5px;
}
</style>