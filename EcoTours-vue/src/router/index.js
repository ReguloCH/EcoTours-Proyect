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
import Cliente from '../Cliente.vue';
import proveedoresADMIN from '../proveedoresADMIN.vue';
import aerolineasPROV from '../aerolineasPROV.vue';
import C_Aerolinea from '../C_Aerolinea.vue';
import C_Cliente from '../C_Cliente.vue';
import E_Cliente from '../E_Cliente.vue';
import E_Aerolinea from '../E_Aerolinea.vue';
import hospedajePROV from '../hospedajePROV.vue';
import alimentacionPROV from '../alimentacionPROV.vue';
import paquetesTurisADMIN from '../paquetesTurisADMIN.vue';
import tarifasHospedaje from '../tarifasHospedaje.vue';
import tarifasADMIN from '../tarifasADMIN.vue';
import tarifaPorDestino from '../tarifaPorDestino.vue';
import tarifaRestaurante from '../tarifaRestaurante.vue';
import movimientoscontables from '../movimientosContables.vue';
import historialdecompras from '../historialdecompras.vue';





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
      path: "/pago",
      name: "paginaPago",
      component: () => import("../paginaPago.vue")

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
      path: '/Clientes',
      name: 'Clientes',
      component: Cliente
    },
    {
      path: '/proveedoresADMIN',
      name: 'proveedoresADMIN',
      component: proveedoresADMIN
    },
    {
      path: '/aerolineasPROV',
      name: 'aerolineasPROV',
      component: aerolineasPROV
    },
    {
      path: '/hospedajePROV',
      name: 'hospedajePROV',
      component: hospedajePROV
    }
    ,
    {
      path: '/alimentacionPROV',
      name: 'alimentacionPROV',
      component: alimentacionPROV
    },
    {
      path: '/paquetesTurisADMIN',
      name: 'paquetesTurisADMIN',
      component: paquetesTurisADMIN
    },

    {
      path: '/C_Aerolinea',
      name: 'C_Aerolinea',
      component: C_Aerolinea
    },

    {
      path: '/C_Cliente',
      name: 'C_Cliente',
      component: C_Cliente
    },

    {
      path: '/E_Cliente',
      name: 'E_Cliente',
      component: E_Cliente
    },

    {
      path: '/E_Aerolinea',
      name: 'E_Aerolinea',
      component: E_Aerolinea
    },
    {
      path: '/tarifasHospedaje',
      name: 'tarifasHospedaje',
      component: tarifasHospedaje
    },
    {
      path: '/tarifasADMIN',
      name: 'tarifasADMIN',
      component: tarifasADMIN
    },
    {
      path: '/tarifaPorDestino',
      name: 'tarifaPorDestino',
      component: tarifaPorDestino
    },
    {
      path: '/tarifaRestaurante',
      name: 'tarifaRestaurante',
      component: tarifaRestaurante
    },
    {
      path: '/movimientoscontables',
      name: 'movimientoscontables',
      component: movimientoscontables
    },

    {
      path: '/historialdecompras',
      name: 'historialdecompras',
      component: historialdecompras
    }
  ]
});

export default router;