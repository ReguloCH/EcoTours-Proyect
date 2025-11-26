<template>
  <div class="pag-principal">
    <!-- Menú principal -->
    <menuPrincipal1 />

    <!-- Contenedor principal -->
    <div class="contenedor-registro">
      <div class="registro-box">
        <h1>Registro de usuario</h1>

        <form @submit.prevent="validarFormulario">

          <div class="campo">
            <label for="inputNombre">Nombre</label>
            <input
              id="inputNombre"
              v-model="nombre"
              @keydown="soloLetras"
              type="text"
              placeholder="Escribe tu nombre"
              required
            />
            <small v-if="errorNombre" class="error-text">{{ errorNombre }}</small>
          </div>

          <div class="campo">
            <label for="inputApellido">Apellido</label>
            <input
              id="inputApellido"
              v-model="apellido"
              @keydown="soloLetras"
              type="text"
              placeholder="Escribe tu apellido"
              required
            />
            <small v-if="errorApellido" class="error-text">{{ errorApellido }}</small>
          </div>

          <div class="campo">
            <label for="inputTelefono">Número de teléfono</label>
            <input
              id="inputTelefono"
              v-model="telefono"
              @keydown="soloNumeros"
              type="text"
              placeholder="Ej. 04141234567"
              required
            />
            <small v-if="errorTelefono" class="error-text">{{ errorTelefono }}</small>
          </div>

          <div class="campo">
            <label for="inputCorreo">Correo electrónico</label>
            <input
              id="inputCorreo"
              v-model="correo"
              type="email"
              placeholder="ejemplo@correo.com"
              required
            />
            <small v-if="errorCorreo" class="error-text">{{ errorCorreo }}</small>
          </div>
      
          <div class="campo">
            <label for="inputPass">Contraseña</label>
            <input
              id="inputPass"
              v-model="password"
              type="password"
              placeholder="••••••••"
              required
            />
            <small v-if="errorPassword" class="error-text">{{ errorPassword }}</small>
          </div>

          <div class="campo">
            <label for="inputPass2">Confirmar contraseña</label>
            <input
              id="inputPass2"
              v-model="password2"
              type="password"
              placeholder="Repite la contraseña"
              required
            />
            <small v-if="errorPassword2" class="error-text">{{ errorPassword2 }}</small>
          </div>

          <button type="submit" class="btn-registrar">Registrarse</button>

          <p v-if="mensajeExito" class="exito-text">{{ mensajeExito }}</p>
        </form>
      </div>
    </div>

    <!-- Footer -->
    <Footer_Cliente />
  </div>
</template>

<script>
import { ref } from "vue";
import menuPrincipal1 from "./components/menuPrincipal1.vue";
import Footer_Cliente from "./components/Footer_Cliente.vue";
import { soloLetras, soloNumeros, validarCorreo } from "./validacionesRegistro.js";

export default {
  name: "Registro",
  components: {
    menuPrincipal1,
    Footer_Cliente,
  },
  setup() {
    // Campos
    const nombre = ref("");
    const apellido = ref("");
    const telefono = ref("");
    const correo = ref("");
    const password = ref("");
    const password2 = ref("");

    // Errores
    const errorNombre = ref("");
    const errorApellido = ref("");
    const errorTelefono = ref("");
    const errorCorreo = ref("");
    const errorPassword = ref("");
    const errorPassword2 = ref("");
    const mensajeExito = ref("");

    const validarFormulario = () => {
      // Reiniciar errores
      errorNombre.value = "";
      errorApellido.value = "";
      errorTelefono.value = "";
      errorCorreo.value = "";
      errorPassword.value = "";
      errorPassword2.value = "";
      mensajeExito.value = "";

      let valido = true;

      // Validaciones básicas
      if (!nombre.value) {
        errorNombre.value = "El nombre es obligatorio.";
        valido = false;
      }

      if (!apellido.value) {
        errorApellido.value = "El apellido es obligatorio.";
        valido = false;
      }

      if (!telefono.value) {
        errorTelefono.value = "El teléfono es obligatorio.";
        valido = false;
      } else if (telefono.value.length < 10) {
        errorTelefono.value = "Debe tener al menos 10 dígitos.";
        valido = false;
      }

      if (!correo.value) {
        errorCorreo.value = "El correo es obligatorio.";
        valido = false;
      } else if (!validarCorreo(correo.value)) {
        errorCorreo.value = "El correo no tiene un formato válido.";
        valido = false;
      }

      if (!password.value) {
        errorPassword.value = "La contraseña es obligatoria.";
        valido = false;
      } else if (password.value.length < 6) {
        errorPassword.value = "Debe tener al menos 6 caracteres.";
        valido = false;
      }

      if (!password2.value) {
        errorPassword2.value = "Debes confirmar tu contraseña.";
        valido = false;
      } else if (password.value !== password2.value) {
        errorPassword2.value = "Las contraseñas no coinciden.";
        valido = false;
      }

      if (valido) {
        mensajeExito.value = "¡Registro exitoso! ";
        nombre.value = "";
        apellido.value = "";
        telefono.value = "";
        correo.value = "";
        password.value = "";
        password2.value = "";
      }
    };

    return {
      nombre,
      apellido,
      telefono,
      correo,
      password,
      password2,
      errorNombre,
      errorApellido,
      errorTelefono,
      errorCorreo,
      errorPassword,
      errorPassword2,
      mensajeExito,
      soloLetras,
      soloNumeros,
      validarFormulario,
    };
  },
};
</script>

