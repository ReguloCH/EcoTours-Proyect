<template>
    <div class="pag-principal">
<!-- meti -->

    <menuPrincipal1 />
    <!-- a partir de aqui, vas a comenzar-->
     <div class="contenedor-imgcontactanos">

        <div class="contenedor-tituloyparrafo">
            <h1 class="titulo-contactanos">¡Contáctanos!</h1>
            <p class="parrafo-contactanos">Estamos aquí para ayudarte. Rellena el formulario para comunicarte con nosotros o utiliza otros medios de contacto.</p>
        </div> 

        <div class="formyubicacion" style="margin-top: 100px;">
            <form class="contactForm">
                <label class="labelcontac" for="name">Nombre:</label>
                <input class="inputcontac" type="text" id="name" name="name" placeholder="Tu nombre completo" required>
                <div id="nameError" class="error"></div> <!-- Mensaje de error para nombre -->
                
                <label class="labelcontac" for="email">Email:</label>
                <input class="inputcontac" type="email" id="email" name="email" placeholder="tuemail@example.com" required>
                <div id="emailError" class="error"></div> <!-- Mensaje de error para email -->
                
                <label  class="labelcontac" for="message">Mensaje:</label>
                <textarea id="message" name="message" rows="5" placeholder="Escribe tu mensaje aquí" required></textarea>
                <div id="messageError" class="error"></div> <!-- Mensaje de error para mensaje -->
                
                <button class="btncontac" type="submit">Enviar Mensaje</button>
            </form>
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.3924967551798!2d-69.35874902674685!3d10.066890171883806!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e8766ed0e842e87%3A0x9750d6b83fe4bfdf!2sObelisco%20de%20Barquisimeto!5e0!3m2!1ses!2sve!4v1760558279212!5m2!1ses!2sve" width="600" height="570" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </div> 
</div>
    <!-- aqui se va a mostrar en la vista el footer entonces esta es la ultima parte del codigo-->
    <Footer_Cliente/>
</template>

<script>
//ESTE SCRIPT TIENE COMO FIN definir y controlar la lógica central dE ESTA VISTA, EXPLICA QUE OTROS COMPONENTES ESTAN INCLUIDOS
// 1. Los imports van primero
import menuPrincipal1 from './components/menuPrincipal1.vue';
import Footer_Cliente from './components/Footer_Cliente.vue';

export default {
    // 2. El nombre del componente
    name: 'contactanos',
    
    // 3. Los componentes usados (menú)
    components: {
        menuPrincipal1 ,
        Footer_Cliente
    },
};
</script>