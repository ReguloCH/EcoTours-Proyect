// solo letras para el nombre
export function soloLetras(evento) {
  const letra = evento.key;
  const regExp = /^[A-Za-zñÑáéíóúÁÉÍÓÚ\s.]+$/;

  // Permitir teclas especiales: Enter, Backspace, Tab, Espacio
  if ([13, 8, 9, 32].includes(evento.keyCode)) return true;

  if (!regExp.test(letra)) {
    evento.preventDefault();
    return false;
  }

  return true;
}

// solo números para el teléfono
export function soloNumeros(evento) {
  const numero = evento.key;
  const regExp = /^[0-9]+$/;

  if ([13, 8, 9, 32].includes(evento.keyCode)) return true;

  if (!regExp.test(numero)) {
    evento.preventDefault();
    return false;
  }

  return true;
}

// correo electrónico
export function validarCorreo(correo) {
  const expReg =
    /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return expReg.test(correo);
}
