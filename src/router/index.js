import { createRouter, createWebHistory } from 'vue-router';

// Importa todos los componentes (las "páginas" completas)
import PagPrincipal1 from '../pagPrincipal1.vue';
import quienesSomos from '../quienesSomos.vue';
import Contactanos from '../contactanos.vue';
import Registrate from '../registrate.vue';
import IniciarSesion from '../iniciarSesion.vue';


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: PagPrincipal1 
    },
    {
      path: '/quienesSomos',
      name: 'quienesSomos',
      component: quienesSomos
    },
    {
      path: '/contactanos',
      name: 'contactanos',
      component: Contactanos
    },
    {
      path: '/registrate',
      name: 'registrate',
      component: Registrate
    },
    {
      path: '/iniciar-sesion',
      name: 'iniciar-sesion',
      component: IniciarSesion
    }
  ]
});

export default router;