    <!-- PRIMER COMPONENTE, EL MENU/HEADER -->
<template>
  <header class="main-header">
    <div class="logo-container">
      <img src="/img/EcoToursLOGO.png" alt="Logo de EcoTours" class="logo">
    </div>
    <nav class="main-nav">
      <ul class="nav-links">
        
        <li><router-link to="/" class="nav-link">Inicio</router-link></li>
        
        <li><router-link to="/quienesSomos" class="nav-link">¿Quienes Somos?</router-link></li>
        
        <li><router-link to="/contactanos" class="nav-link">Contactanos</router-link></li>
        
        <li><router-link to="/registrate" class="nav-link action-button">Registrate</router-link></li>
        
        <li><router-link to="/iniciar-sesion" class="nav-link action-button">Iniciar Sesión</router-link></li>
        
      </ul>
    </nav>
  </header>
  
</template>

<script>
export default {
  name: 'menuPrincipal1',
}
</script>