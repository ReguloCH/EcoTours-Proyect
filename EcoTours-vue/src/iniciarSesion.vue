<template>
  <div class="pag-principal">
    <!-- Menú principal -->
    <menuPrincipal1 />

    <!-- Contenedor del login -->
    <div class="contenedor-login">
      <div class="login-box">
        <h1>Iniciar sesión</h1>

        <form @submit.prevent="iniciarSesion">
          <div class="campo">
            <label>Correo electrónico</label>
            <input
              v-model="email"
              type="email"
              required
              placeholder="ejemplo@correo.com"
            />
          </div>

          <div class="campo">
            <label>Contraseña</label>
            <input
              v-model="password"
              type="password"
              required
              placeholder="••••••••"
            />
          </div>

          <button type="submit" class="btn-entrar">Entrar</button>
        </form>

        <p class="texto-secundario">
          ¿No tienes cuenta?
          <button @click="irARegistro" class="enlace">Regístrate</button>
        </p>
      </div>
    </div>

    <!-- Footer -->
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
