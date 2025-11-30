import { createRouter, createWebHistory } from 'vue-router';

// Importa todos los componentes (las "páginas" completas)
import Inicio from '../Inicio.vue';
import PagPrincipal1 from '../pagPrincipal1.vue';
import quienesSomos from '../quienesSomos.vue';
import Contactanos from '../contactanos.vue';
import Registrate from '../registrate.vue';
import IniciarSesion from '../iniciarSesion.vue';
import paginaClientes from '../paginaClientes.vue'; 
import paginaPago from '../paginaPago.vue';
import adminLOGIN from '../adminLOGIN.vue';
import iniADMIN from '../iniADMIN.vue';
import clientesADMIN from '../clientesADMIN.vue';
import proveedoresADMIN from '../proveedoresADMIN.vue';
import aerolineasPROV from '../aerolineasPROV.vue';
import C_Aerolinea from '../C_Aerolinea.vue';
import E_Aerolinea from '../E_Aerolinea.vue';
import hospedajePROV from '../hospedajePROV.vue';
import alimentacionPROV from '../alimentacionPROV.vue';
import paquetesTurisADMIN from '../paquetesTurisADMIN.vue';





const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Inicio 
    },
    {
      path: '/PagPrincipal',
      name: 'PagPrincipal',
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
    },
    {
      path: '/pagina-clientes',
      name: 'pagina-clientes',
      component: paginaClientes 
    },
    {
      path: '/pagina-pago',
      name: 'pagina-pago',
      component: paginaPago
    },
     {
      path: '/adminLOGIN',
      name: 'adminLOGIN',
      component: adminLOGIN
    },
     {
      path: '/iniADMIN',
      name: 'iniADMIN',
      component: iniADMIN
    },
     {
      path: '/clientesADMIN',
      name: 'clientesADMIN',
      component: clientesADMIN
    },
    {
      path: '/proveedoresADMIN',
      name: 'proveedoresADMIN',
      component: proveedoresADMIN
    },
    {
      path: '/aerolineasPROV',
      name: '/aerolineasPROV',
      component: aerolineasPROV
    },
    {
      path: '/hospedajePROV',
      name: '/hospedajePROV',
      component: hospedajePROV
    }
    ,
    {
      path: '/alimentacionPROV',
      name: '/alimentacionPROV',
      component: alimentacionPROV
    },
    {
      path: '/paquetesTurisADMIN',
      name: '/paquetesTurisADMIN',
      component: paquetesTurisADMIN
    },
    
    {
      path: '/C_Aerolinea',
      name: '/C_Aerolinea',
      component: C_Aerolinea
    },
    
    {
      path: '/E_Aerolinea',
      name: '/E_Aerolinea',
      component: E_Aerolinea
    },
  ]
});

export default router;