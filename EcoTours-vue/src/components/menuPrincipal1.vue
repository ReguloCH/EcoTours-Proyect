<!-- PRIMER COMPONENTE, EL MENU/HEADER -->
<template>
  <header class="main-header">
    <div class="logo-container">
      <img src="/img/EcoToursLOGO.png" alt="Logo de EcoTours" class="logo">
    </div>
    <nav class="main-nav">
      <div class="d-flex flex-wrap align-items-center justify-content-center">
          <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
            <li><router-link to="/PagPrincipal" class="nav-link px-2 text-black">Inicio</router-link></li>
            <li><router-link to="/quienesSomos" class="nav-link px-2 text-black">¿Quienes Somos?</router-link></li>
            <li><router-link to="/contactanos" class="nav-link px-2 text-black">Contactanos</router-link></li>
          </ul>
        <router-link to="/iniciar-sesion" class="nav-link action-button">Iniciar Sesión</router-link>
      </div>
    </nav>
  </header>
</template>

<script>
export default {name: 'menuPrincipal1',}
</script>