    <!-- SEGUNDO COMPONENTE, EL FOOTER -->
<template>
  <footer class="main-footer" style="background-image: url('/img/montana-fondo.jpg'); padding-top: 0px;">
    <div class="footer-overlay" style="padding-bottom: 0px;">
      <div class="footer-container">
        
        <div class="footer-column contact-column">
          <img src="/img/EcoToursLOGO.png" alt="EcoTours Logo" class="footer-logo">
          
          <p class="contact-info">
            <span class="info-label">Correo:</span> ecotoursagency@gmail.com
          </p>
          <p class="contact-info">
            <span class="info-label">Contacto:</span> +58 0424 418 80 89 / +58 044 349 98 48
          </p>
          <p class="contact-info">
            <span class="info-label">Ubicación:</span> Venezuela / Estados Unidos
          </p>

          <div class="social-links">
            <a href="#" class="social-icon">f</a> 
            <a href="#" class="social-icon">t</a>
          </div>
        </div>

        <div class="footer-column">
          <h4 class="column-title">Links Rápidos</h4>
          <ul class="footer-links">
            <li><a href="#">Empresa</a></li>
            <li><a href="#">Servicios</a></li>
            <li><a href="#">Contacto</a></li>
          </ul>
        </div>

        <div class="footer-column">
          <h4 class="column-title">Búsqueda</h4>
          <ul class="footer-links">
            <li><a href="#">Destinos</a></li>
            <li><a href="#">Boletos</a></li>
            <li><a href="#">Paquetes</a></li>
          </ul>
        </div>

        <div class="footer-column">
          <h4 class="column-title">Soporte</h4>
          <ul class="footer-links">
            <li><a href="#">Términos</a></li>
            <li><a href="#">Políticas de Privacidad</a></li>
            <li><a href="#">FAQ</a></li>
          </ul>
        </div>
      </div>
    </div>
    
    <div class="footer-copyright bg-white">
      © 2025 EcoTours. Todos los Derechos Reservados.
    </div>
  </footer>
</template>

<script>
export default {
  name: 'FooterIni',
  // Si deseas agregar lógica de Vue, iría aquí.
};
</script>