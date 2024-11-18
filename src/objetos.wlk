import personaje.*
import wollok.game.*
class Objeto {
    var property position = game.at(0.randomUpTo(game.width()-1), game.height()-1)
    var velocidad =300

    method image()
    method colisionar() 
    method velocidad() = velocidad
    method aumentarVelocidadEn(unaCantidad) {
      velocidad +=unaCantidad
    } 
    method aparecer() {
        game.addVisual(self)
        self.caer()
    }
    method caer() {
        game.onTick(self.velocidad(), "objetoCayendo",{position = game.at(position.x(),position.y()-1)
                                        if (position.y()<0) game.removeVisual(self)})
    }
}

//OBJETOS BUENOS
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

class GemaDeLosMares inherits Objeto {
    var seEstaMoviendoDerecha = true
    override method image() = "pirataDer1.png"//Buscar Imagen
    override method colisionar() {
      personaje.aumentarPuntos(10)
        game.removeVisual(self)
    }
    override method caer(){
        game.onTick(self.velocidad(),"GemaCayendo",{
            self.aumentarVelocidadEn(100)
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
        personaje.descontarVida(1)
        game.say(personaje, "Me quedan " + personaje.vidas() + " vidas")
        personaje.image("pirataDaño.png")
    }
}
class Espada inherits Objeto { 
    override method image() = "bomba.png"//Buscar imagen
    
    override method colisionar() {
        personaje.disminuirPuntos(10)
        game.say(personaje, "He perdido 10 puntos")
        personaje.image("pirataDaño.png")
    }
    
    override method caer(){
        game.onTick(self.velocidad(), "EspadaCayendo", {
            position = game.at(position.x() + 1, position.y() - 1)

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
      personaje.descontarVida(1)
        game.say(personaje, "Me quedan " + personaje.vidas() + " vidas")
        personaje.image("pirataDaño.png")
    }
    override method caer(){
        game.onTick(self.velocidad(),"PulpoCayendo",{
            
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
class AnclaOxidada inherits Objeto { 
    override method image() = "pirataIzq1.png"//buscar imagen
    override method colisionar() {
        
        personaje.image("pirataDaño.png")
    }
}


/*
 else if (position.x() < 0) { // Si sale por la izquierda, reaparece por la derecha
            position = game.at(game.width(), position.y())
        }



override method caerr() {
    game.onTick(300, "objetoCayendo", {
        position = game.at(position.x() + 1, position.y() - 1) // Cambia tanto en x como en y
        if (position.y() < 0 || position.x() > game.width()) { // Si se sale de la pantalla
            game.removeVisual(self)
        }
    })
     position = if (position.x() == game.width()) {game.at(0,position.y())}
    else {game.at(position.x()+1,position.y())}
    }
*/