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

        <div class="formyubicacion">
            
                
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


    
    <!-- aqui se va a mostrar en la vista el footer entonces esta es la ultima parte del codigo-->
    <FooterIni />
    </div>
    

</template>



<script>
// ESTE SCRIPT TIENE COMO FIN definir y controlar la lógica central dE ESTA VISTA, EXPLICA QUE OTROS COMPONENTES ESTAN INCLUIDOS

// 1. Los imports van primero
import menuPrincipal1 from './components/menuPrincipal1.vue';
import FooterIni from './components/footerIni.vue';

export default {
    // 2. El nombre del componente
    name: 'contactanos',
    
    // 3. Los componentes usados (menú y footer)
    components: {
        menuPrincipal1, // Componente del menú principal
        FooterIni // Componente del pie de página (footer)
    },
    
    // 4. Ciclo de Vida: El código de manipulación del DOM (como el addEventListener) 
    // debe ir dentro del método 'mounted()' para asegurar que el formulario ya existe en el DOM.
    mounted() {
        // En este punto, el componente <template> ya fue renderizado y podemos acceder a sus elementos del DOM.
        
        // --- Declaración de variables y referencias al DOM ---
        const form = document.querySelector('.contactForm');
        // NOTA: Para obtener referencias más robustas en Vue, se recomienda usar 'ref' en el template.
        // Pero para mantener tu lógica JS pura, usamos 'getElementById'.
        const nameInput = document.getElementById('name');
        const emailInput = document.getElementById('email');
        const messageTextarea = document.getElementById('message');

        // --- Funciones para mostrar/ocultar errores ---
        function showError(element, message) {
            // Se asume que los <div> de error tienen el ID: [id_del_input] + 'Error'
            document.getElementById(element.id + 'Error').textContent = message;
        }

        function clearError(element) {
            document.getElementById(element.id + 'Error').textContent = '';
        }

        // --- Funciones de Validación Específicas ---

        function validateName() {
            const name = nameInput.value.trim();
            clearError(nameInput);
            if (name.length < 3) {
                showError(nameInput, 'El nombre debe tener al menos 3 caracteres.');
                return false;
            }
            if (name.length > 50) {
                showError(nameInput, 'El nombre no debe exceder los 50 caracteres.');
                return false;
            }
            return true;
        }

        function validateEmail() {
            const email = emailInput.value.trim();
            // Expresión regular para email
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; 
            clearError(emailInput);
            if (!emailRegex.test(email)) {
                showError(emailInput, 'Por favor, introduce un correo electrónico válido.');
                return false;
            }
            return true;
        }

        function validateMessage() {
            const message = messageTextarea.value.trim();
            clearError(messageTextarea);
            if (message.length < 10) {
                showError(messageTextarea, 'El mensaje es demasiado corto (mínimo 10 caracteres).');
                return false;
            }
            if (message.length > 500) {
                showError(messageTextarea, 'El mensaje es demasiado largo (máximo 500 caracteres).');
                return false;
            }
            return true;
        }

        // --- Manejo del Evento Submit ---

        // Se verifica que el formulario exista antes de añadir el listener.
        if (form) {
            form.addEventListener('submit', function(event) {
                // Ejecuta todas las validaciones
                const isNameValid = validateName();
                const isEmailValid = validateEmail();
                const isMessageValid = validateMessage();

                // Si alguna validación falla, previene el envío del formulario
                if (!isNameValid || !isEmailValid || !isMessageValid) {
                    event.preventDefault(); // Detiene el envío
                    alert('Por favor, corrige los errores antes de enviar.');
                } 
                // Si la validación es exitosa, por defecto, el formulario se enviaría 
                // a la URL especificada o a sí mismo. Aquí podrías añadir un 'event.preventDefault()'
                // para enviar los datos vía AJAX (fetch/axios) a un servidor.
            });
            
            // Añadir validación en tiempo real al perder el foco (blur), 
            // solo si los elementos existen.
            if (nameInput) nameInput.addEventListener('blur', validateName);
            if (emailInput) emailInput.addEventListener('blur', validateEmail);
            if (messageTextarea) messageTextarea.addEventListener('blur', validateMessage);
        }
    }
};
</script>