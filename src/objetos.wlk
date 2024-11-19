import pirata.*
import wollok.game.*
class Objeto {
    var property position = game.at(0.randomUpTo(game.width()-1), game.height()-1)
    var lentitud = 300

    method image()
    method colisionar() 
    method lentitud() = lentitud
    method aumentarlentitudEn(unaCantidad) {
      lentitud +=unaCantidad
    } 
    method aparecer() {
        game.addVisual(self)
        self.caer()
    }
    method caer() {
        game.onTick(self.lentitud(), "objetoCayendo",{position = game.at(position.x(),position.y()-1)
                                        if (position.y()<0) game.removeVisual(self)})
    }
}

//OBJETOS BUENOS
class MonedaOro inherits Objeto  {
    override method image() = "moneda.png"
    override method colisionar () {
        game.sound("sonidobueno.mp3").play()
        pirata.aumentarPuntos(5)
        game.removeVisual(self)
    }
}
class Cofre inherits Objeto {
    override method image() = "cofre.png"
    override method colisionar () {
        game.sound("sonidobueno.mp3").play()
        pirata.aumentarPuntos(10)
        game.removeVisual(self)
    }
}

class Perla inherits Objeto {
    var seEstaMoviendoDerecha = true
    override method image() = "perla.png"
    override method colisionar() {
        game.sound("bonus.mp3").play()
<<<<<<< HEAD
        personaje.aumentarPuntos(10)
=======
        pirata.aumentarPuntos(10)
>>>>>>> 495bf01e9256378d2672880cfb0a75e4ce3dabd4
        game.removeVisual(self)
    }
    override method caer(){
        game.onTick(self.lentitud(),"GemaCayendo",{
            self.aumentarlentitudEn(100)
            if(seEstaMoviendoDerecha){
                position = game.at(position.x() + 1, position.y() - 1)
            }
            else{
                position = game.at(position.x() - 1, position.y() - 1)
            }

            if(position.x() >= game.width()){
                seEstaMoviendoDerecha = false
            }
            else if(position.x() <= 0){
                seEstaMoviendoDerecha = true
            }
            if (position.y()<0){ game.removeVisual(self)}
        })
    }
}

//OBJETOS MALOS
class Bomba inherits Objeto { 
    override method image() = "bomba.png"
    override method colisionar() {
        game.sound("daño.mp3").play()
        pirata.descontarVida(1)
        pirata.image("pirataDaño.png")
    }
}
class Espada inherits Objeto { 
    override method image() = "espada.png"
    
    override method colisionar() {
        game.sound("daño.mp3").play()
        pirata.disminuirPuntos(10)
        pirata.image("pirataDaño.png")
    }
    
    override method caer(){
        game.onTick(self.lentitud(), "EspadaCayendo", {
            position = game.at(position.x()+1, position.y() - 1)
            if (position.y() < 0) { 
            game.removeVisual(self)
            } else if (position.x() > game.width()) { // le agregue el efecto pacman 
            position = game.at(0, position.y())
            }
        }) 
    }  
}

class Pulpo inherits Objeto {
    var seEstaMoviendoDerecha = false
    override method image() = "pulpo.png"
    override method colisionar() {
<<<<<<< HEAD
        game.sound("danio.mp3").play()
        personaje.descontarVida(1)
        game.say(personaje, "Me quedan " + personaje.vidas() + " vidas")
        personaje.image("pirataDaño.png")
=======
        game.sound("daño.mp3").play()
        pirata.descontarVida(1)
        pirata.image("pirataDaño.png")
>>>>>>> 495bf01e9256378d2672880cfb0a75e4ce3dabd4
    }
    override method caer(){
        game.onTick(self.lentitud(),"PulpoCayendo",{
            
            if(seEstaMoviendoDerecha){
                position = game.at(position.x() + 1, position.y() - 1)
            }
            else{
                position = game.at(position.x() - 1, position.y() - 1)
            }

            if(position.x() >= game.width()){
                seEstaMoviendoDerecha = false
            }
            else if(position.x() <= 0){
                seEstaMoviendoDerecha = true
            }
            if (position.y()<0){ game.removeVisual(self)}
        })
    }
}
