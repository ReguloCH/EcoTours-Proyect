

import { createApp } from 'vue'
import './style.css'
import './QuienesSomos.css'
import App from './App.vue'


import router from './router' 

const app = createApp(App)

app.use(router) 

// Monta la aplicación
app.mount('#app')

