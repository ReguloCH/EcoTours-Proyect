<template>
    <div class="pag-principal">
<!-- meti -->

    <menuPrincipal1 />
    <!-- a partir de aqui, vas a comenzar-->
      <!-- Contenedor del login -->
    <div class="contenedor-login">
      <div class="login-box">
        <h1>Iniciar sesión</h1>

        <form @submit.prevent="login">
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
          <a href="#" class="enlace">Regístrate</a>
        </p>
      </div>
    </div>


    <!-- aqui se va a mostrar en la vista el footer entonces esta es la ultima parte del codigo-->
    <FooterIni />
    </div>
    

</template>



<script>
//ESTE SCRIPT TIENE COMO FIN definir y controlar la lógica central dE ESTA VISTA, EXPLICA QUE OTROS COMPONENTES ESTAN INCLUIDOS
// 1. Los imports van primero
import menuPrincipal1 from './components/menuPrincipal1.vue';
import FooterIni from './components/footerIni.vue';

export default {
    // 2. El nombre del componente
    name: 'iniciarSesion',
    
    // 3. Los componentes usados (menú)
    components: {
        menuPrincipal1 ,
        FooterIni
    },
    
  
};
</script>