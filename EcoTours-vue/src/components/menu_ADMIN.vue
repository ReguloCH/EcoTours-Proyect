   <!-- TERCER COMPONENTE, EL MENU DEL ADMINISTRADOR -->
<template>
  <header class="main-header">
    <div class="logo-container">
      <img src="/img/EcoToursLOGO.png" alt="Logo de EcoTours" class="logo">
    </div>
    <nav class="main-nav">
      <ul class="nav-links">
        <li><router-link to="/iniADMIN" class="nav-link">Inicio</router-link></li>
        <li><router-link to="/clientesADMIN" class="nav-link">Clientes</router-link></li>
        <li><router-link to="proveedoresADMIN" class="nav-link">Proveedores</router-link></li>
        <li><router-link to="/paquetesTurisADMIN" class="nav-link">Paquetes Turisticos</router-link></li>
        <li><router-link to="/adminLOGIN" class="nav-link">Salir</router-link></li>
      </ul>
    </nav>
  </header>
</template>

<script>
export default {
  name: 'menu_ADMIN',
}
</script>

<style scoped>
.main-header {
  background-color: #fff3cd; 
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 40px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.logo {
  height: 60px;
}

.main-nav .nav-links {
  list-style: none;
  display: flex;
  gap: 20px;
  margin: 0;
  padding: 0;
}

.nav-link {
  text-decoration: none;
  color: #b85c00; /* tono naranja oscuro */
  font-weight: 500;
  transition: color 0.3s ease;
}

.nav-link:hover {
  color: #ff7b00; /* tono más brillante al pasar el mouse */
}

.action-button {
  background-color: #ff7b00;
  color: white !important;
  padding: 8px 14px;
  border-radius: 6px;
  transition: background-color 0.3s ease;
}

.action-button:hover {
  background-color: #e66900;
}
</style>
