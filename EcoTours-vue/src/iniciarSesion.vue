<template>
  <div class="pag-principal d-flex flex-column min-vh-100">
    <!-- Menú principal -->
    <menuPrincipal1 />

    <!-- Contenedor principal -->
    <div class="container flex-grow-1 d-flex align-items-center justify-content-center">
      <div class="row w-100 justify-content-center">
        <div class="col-md-6 col-lg-5">
          <!-- Contenedor usando lo de grid -->
          <div class="card border-0 shadow-lg p-4 rounded-4 login-box" style="background-color: rgba(255,255,255,0.92);">
            <h1 class="text-center mb-4">Iniciar sesión</h1>

            <form @submit.prevent="iniciarSesion">
              <div class="mb-3">
                <label class="form-label">Correo electrónico</label>
                <input
                  v-model="email"
                  type="email"
                  required
                  class="form-control form-control-lg"
                  placeholder="ejemplo@correo.com"
                />
              </div>

              <div class="mb-4">
                <label class="form-label">Contraseña</label>
                <input
                  v-model="password"
                  type="password"
                  required
                  class="form-control form-control-lg"
                  placeholder="••••••••"
                />
              </div>

              <!-- boton usado bootstrap -->
              <div class="d-grid">
                <button type="submit" class="btn btn-warning btn-lg fw-semibold text-white">
                  <i class="bi bi-box-arrow-in-right me-2"></i> Entrar
                </button>
              </div>
            </form>

            <div class="text-center mt-3 texto-secundario">
              ¿No tienes cuenta?
              <button @click="irARegistro" class="btn btn-link enlace p-0">
                Regístrate
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <FooterIni />
  </div>
</template>


<script>
import menuPrincipal1 from './components/menuPrincipal1.vue';
import FooterIni from './components/footerIni.vue';

export default {
  name: 'iniciarSesion',
  components: {
    menuPrincipal1,
    FooterIni,
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

<style scoped>
.texto-secundario {
  margin-top: 1rem;
  text-align: center;
}

.enlace {
  background: none;
  border: none;
  color: #ff6600;
  font-weight: bold;
  cursor: pointer;
  transition: color 0.3s;
}

.enlace:hover {
  color: #0055ff;
}
</style>
