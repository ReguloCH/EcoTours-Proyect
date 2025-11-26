<template>
  <div class="pag-principal d-flex flex-column min-vh-100">
    <!-- Contenedor principal -->
    <div class="container flex-grow-1 d-flex align-items-center justify-content-center">
      <div class="row w-100 justify-content-center">
        <div class="col-md-6 col-lg-5">
          <!-- Contenedor usando lo de grid -->
          <div class="card border-0 shadow-lg p-4 rounded-4 login-box" style="background-color: rgba(255,255,255,0.92);margin-top: 40px;">
            <img src="/img/EcoToursLOGO.png" alt="Logo de EcoTours" class="img-fluid">
            <br>  
            <h1 class="text-center mb-4">Eligue tu rol</h1>
              <div class="d-grid">
                <router-link to="/PagPrincipal" class="btn btn-warning btn-lg fw-semibold text-white">Cliente</router-link>
              </div>
              <br>
              <div class="d-grid">
                <router-link to="/adminLOGIN" class="btn btn-warning btn-lg fw-semibold text-white">Administrador</router-link>
              </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import Footer_Cliente from './components/Footer_Cliente.vue';

export default {
  name: 'Inicio',
  components: {
    Footer_Cliente
  },
  data() {
    return {
      email: '',
      password: '',
    };
  },
  methods: {
    iniciarSesion() {
      if (this.email && this.password) {
        // Redirige a la página de clientes
        this.$router.push('/pagina-clientes');
      } else {
        alert('Por favor, completa todos los campos.');
      }
    },
    irARegistro() {
      // Redirige al formulario de registro
      this.$router.push('/registrate');
    },
  },
};
</script>