   <!-- TERCER COMPONENTE, EL MENU DEL ADMINISTRADOR -->
<template>
  <header>
    <nav class="navbar bg-warning bg-opacity-50 fixed-rigth">
    <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#Navbar" aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="offcanvas offcanvas-start" tabindex="-1" id="Navbar" aria-labelledby="offcanvasNavbarLabel">
      <div class="offcanvas-header">
      <img src="/img/EcoToursLOGO.png" alt="Logo de EcoTours" class="logo fixed-left">
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">
        <ul class="navbar-nav justify-content-start flex-grow-1 pe-3">
          <li class="nav-item">
            <router-link to="/iniADMIN" class="nav-link">Inicio</router-link>
          </li>
          <li class="nav-item">
              <router-link to="/Clientes" class="nav-link">Clientes</router-link>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Proveedores
            </a>
            <ul class="dropdown-menu">
              <router-link to="/proveedoresADMIN" class="dropdown-item">Proveedores</router-link>
              <li><hr class="dropdown-divider"></li>
              <router-link to="/tarifasADMIN" class="dropdown-item">Tarifas de proveedores</router-link> 
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Paquetes turisticos
            </a>
            <ul class="dropdown-menu">
              <router-link to="/paquetesTurisADMIN" class="dropdown-item">Paquetes Turisticos</router-link>
              <li><hr class="dropdown-divider"></li>
              <router-link to="/paquetesTurisADMIN" class="dropdown-item">Tarifas de paquetes turisticos</router-link> 
            </ul>
          </li>
          <li class="nav-item">
            <router-link to="/adminLOGIN" class="nav-link">Salir</router-link>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>
  </header>
</template>

<script>
export default {
  name: 'Sidebar_Admin',
}
</script>