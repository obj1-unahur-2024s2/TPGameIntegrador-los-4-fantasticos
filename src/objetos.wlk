import personaje.*
import wollok.game.*
class Objeto {
    var property position = game.at(0.randomUpTo(game.width()-1), game.height()-1)
   // var velocidad

    method image()
    method colisionar() 
    method aparecer() {
        game.addVisual(self)
        self.caer()
    }
    method caer() {
        game.onTick(300, "objetoCayendo",{position = game.at(position.x(),position.y()-1)
                                        if (position.y()<0) game.removeVisual(self)})
    }
}

class MonedaOro inherits Objeto  {
    override method image() = "moneda.png"
    override method colisionar () {
        personaje.aumentarPuntos(5)
        game.removeVisual(self)
    }
}
class Cofre inherits Objeto {
    override method image() = "cofre.png"
    override method colisionar () {
        personaje.aumentarPuntos(10)
        game.removeVisual(self)
    }
}
class Bomba inherits Objeto { 
    override method image() = "bomba.png"
    override method colisionar() {
        personaje.descontarVida(1)
        game.say(personaje, "Me quedan " + personaje.vidas() + " vidas")
        personaje.image("pirataDaño.png")
    }
}

class Pulpo inherits Objeto {
    override method image() = "pulpo.png"
    override method colisionar() {
      
    }
}