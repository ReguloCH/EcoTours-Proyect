<template>
    <div class="pag-ADMIN">
<!-- meti -->
    <!-- a partir de aqui, vas a comenzar-->
     <!-- Contenedor del login -->
    <div class="contenedor-login">
      <div class="login-box">
        <h1>MODULO ADMINISTRADOR </h1>

        <form @submit.prevent="iniciarSesion">
          <div class="campo">
            <label>Correo Electronico o usuario</label>
            <input
              v-model="identifier"
              type="text"
              required
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

          <div v-if="errorMessage" style="color: #b00020; margin-bottom: 12px; text-align: left">{{ errorMessage }}</div>

          <div class="d-grid">
            <button type="submit" class="btn-entrar">Acceder</button>
          </div>
        </form>

       <!-- <p class="texto-secundario">¿No tienes cuenta?
          <button @click="irARegistro" class="nav-link action-button text-center">Regístrate</button>
        </p>-->
      </div>
    </div>
    <!-- aqui se va a mostrar en la vista el footer entonces esta es la ultima parte del codigo-->
    <Footer_Admin />
    </div>
    

</template>

<script>
//ESTE SCRIPT TIENE COMO FIN definir y controlar la lógica central dE ESTA VISTA, EXPLICA QUE OTROS COMPONENTES ESTAN INCLUIDOS
// 1. Los imports van primero
import Footer_Admin from './components/Footer_Admin.vue';

export default {
    // 2. El nombre del componente
    name: 'adminLOGIN',
    
    // 3. Los componentes usados (menú)
    components: {
        Footer_Admin
    },  
    data() {
    return {
      identifier: '', // correo o usuario
      password: '',
      errorMessage: ''
    };
  },
  methods: {
    async iniciarSesion() {
      this.errorMessage = '';
      if (!this.identifier || !this.password) {
        this.errorMessage = 'Por favor completa todos los campos.';
        return;
      }

      try {
        const res = await fetch('http://localhost:3000/api/usuario/login', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ identifier: this.identifier, password: this.password })
        });

        const data = await res.json();

        if (!res.ok) {
          // manejar 403 separado
          if (res.status === 403) {
            this.errorMessage = data.error || 'No tienes permisos de administrador.';
            return;
          }
          this.errorMessage = data.error || 'Error en autenticación.';
          return;
        }

        // Si el usuario existe y es admin, servidor ya lo validó
        this.$router.push('/iniADMIN');
      } catch (err) {
        this.errorMessage = 'No se pudo conectar al servidor.';
      }
    }
  }
};
</script>

<style>
.pag-ADMIN {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background: url('/img/fondo-admin.jpg') no-repeat center center fixed;
  background-size: cover;
  color: #fff;
}

.contenedor-login {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 60px 20px;
  backdrop-filter: blur(6px);
}

.login-box {
  background: rgba(255, 255, 255, 0.92);
  color: #333;
  padding: 3.5rem 3rem;
  border-radius: 24px;
  width: 100%;
  max-width: 520px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
  text-align: center;
  transform: scale(1.02);
  transition: transform 0.3s ease;
}

.login-box:hover {
  transform: scale(1.04);
}

.login-box h1 {
  font-size: 2.2rem;
  color: #ff6600;
  margin-bottom: 2rem;
  font-weight: bold;
  letter-spacing: 1px;
}
.campo {
  text-align: left;
  margin-bottom: 1.6rem;
}

.campo label {
  display: block;
  font-size: 1rem;
  color: #333;
  margin-bottom: 8px;
  font-weight: 500;
}

.campo input {
  width: 100%;
  padding: 14px 16px;
  border: 1px solid #ccc;
  border-radius: 12px;
  font-size: 1.1rem;
  outline: none;
  transition: border 0.2s, box-shadow 0.2s;
}

.campo input:focus {
  border-color: #ff6600;
  box-shadow: 0 0 0 4px rgba(255, 102, 0, 0.3);
}

.btn-entrar {
  width: 100%;
  padding: 14px;
  background-color: #ff6600;
  color: white;
  border: none;
  border-radius: 12px;
  font-size: 1.1rem;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;
  margin-top: 10px;
}

.btn-entrar:hover {
  background-color: #e65c00;
  transform: scale(1.03);
}

.texto-secundario {
  margin-top: 1.5rem;
  font-size: 1rem;
  color: #333;
}

.enlace {
  color: #ff6600;
  text-decoration: none;
  font-weight: 600;
}

.enlace:hover {
  text-decoration: underline;
}

@media (max-width: 600px) {
  .login-box {
    padding: 2rem;
    max-width: 90%;
  }

  .login-box h1 {
    font-size: 1.8rem;
  }

  .campo input {
    font-size: 1rem;
  }

  .btn-entrar {
    font-size: 1rem;
  }
}



</style>