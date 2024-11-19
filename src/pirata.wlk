import wollok.game.*
import niveles.*

object pirata {
  var vidas = 3
  var property puntos = 0
  var property position = game.at(0, 0)
  var property image = "pirataDer1.png"
  method vidas() = vidas
  method image() = image
  method vivo() = vidas > 0

  method aumentarPuntos(cantidad) {
    puntos += cantidad
    if (juego.nivelActual().objetivoCumplido())
      juego.nivelActual().siguiente().iniciar()
  }
  method disminuirPuntos(cantidad) {
    puntos = 0.max(puntos-cantidad)
  }

  method moverDerecha() {
    position = if (position.x() == game.width()) {game.at(0,position.y())}
    else {game.at(position.x()+1,position.y())}
    image = "pirataDer1.png" 
    
  }

  method moverIzquierda() {
    position = if (position.x() == 0) {game.at(game.width()-1,position.y())}
    else {game.at(0.max(position.x()-1),position.y())}
    image = "pirataIzq1.png" 
    
  }

  method sumarVida(cantidad){
    vidas= 3.min(vidas + cantidad)
  }

  method descontarVida(cantidad){
    vidas -= cantidad
    if (not self.vivo()) 
      juego.terminar() 
  }
}