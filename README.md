# Color Picker

##Se utiliza Flutter para una app simple, que funcione en celular/chrome y windows/macos.

- Elegir un color cambia el fondo de la ui. Los colores son guardado en un map
- La app conoce la plataforma utilizada mediante Platform.operatingSystem
- La eleccion de color es guardada en localstorage. Se utiliza  async/await SharedPreferences.getInstance() para conocer el localstorage del dispositivo y 
setter y getter.

- Compatible con android, macos, windows y chrome.
 

