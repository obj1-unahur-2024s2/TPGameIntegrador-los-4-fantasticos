import wollok.game.*
import personaje.*
import objetos.*

object config {
	method configurarTeclas() {
		keyboard.left().onPressDo({personaje.moverIzquierda()})
		keyboard.right().onPressDo({personaje.moverDerecha()})
		keyboard.space().onPressDo({game.stop()})
		keyboard.p().onPressDo({puntaje.alternarPuntaje()})
		/*keyboard.enter().onPressDo({if (not personaje.vivo())
									juego.reiniciar()})
		Averiguar como reinciar el juego cuando muere*/ //Agregue sugerencia en personaje.descontarVida()
	}
}

object juego {
	var property nivelActual = nivel1
	method iniciar() {
		game.title("Pirata")
		game.height(20)
		game.width(20)
		game.boardGround("playa.jpeg")
		config.configurarTeclas()
		game.addVisual(personaje)
		game.onCollideDo(personaje, {objeto => objeto.colisionar()})

		nivel1.iniciar()
	}

	method terminar() {
		game.stop()
		game.clear()
		game.addVisual(personaje)
		game.say(personaje, ":c")
		game.addVisual(gameOver)
		//game.onTick(4000,"Reiniciar Juego", {self.reiniciar()}) //eso para reiniciar el juego luego de 4seg de morirse?
	}

	method reiniciar() {
		game.clear()
		nivel1.iniciar()
		game.start()
	}
}

class Nivel {
	const property siguiente 

	method iniciar(){
		//config.configurarTeclas()
		//game.addVisual(personaje)
		//game.onCollideDo(personaje, {objeto => objeto.colisionar()})
		game.onTick(2000, "GenerarObjetosBuenos", {self.randomBuenos().aparecer()})
		game.onTick(3500, "GenerarObjetosMalos", {self.randomMalos().aparecer()})
	}

	method randomBuenos() {
		const objBuenos = [new MonedaOro(), new Cofre()]
		return
		objBuenos.get(0.randomUpTo(objBuenos.size()))
	}

	method randomMalos() {
		const objMalos = [new Bomba(), new Espada()]
		return
		objMalos.get(0.randomUpTo(objMalos.size()))
	}
	method objetivoCumplido()
}
object nivel1 inherits Nivel(siguiente=nivel2){
	override method objetivoCumplido() = personaje.puntos() >= 30 //tiene que ser >= y no == ya que si agarramos una moneda nos podemos pasar
}

object nivel2 inherits Nivel(siguiente=fin) {
	override method iniciar() {
		game.clear()//Con este clear borramos todo, tendriamos q encontrar otra forma de hacerlo,xq sino tenemos que hacer las config y todo devuelta
		tituloLvlDos.mostrarTitulo()
		config.configurarTeclas()
		game.addVisual(personaje)//agregue esto asi tenemos al personaje, pero no podemos moverlo
		game.onCollideDo(personaje, {objeto => objeto.colisionar()})
		game.onTick(3000, "GenerarObjetosBuenos", {self.randomBuenos().aparecer()})//le subi el tiempo xq me explotaba la compu
		game.onTick(5000, "GenerarObjetosMalos", {self.randomMalos().aparecer()})//le subi el tiempo xq me explotaba la compu
	}

	override method randomBuenos() {
		const objBuenos = [new MonedaOro(velocidad=700), new Cofre(),new GemaDeLosMares()]
		return
		objBuenos.get(0.randomUpTo(objBuenos.size()))
	}

	override method randomMalos() {
		const objMalos = [new Bomba(velocidad=700), new Pulpo(), new Espada()]
		return
		objMalos.get(0.randomUpTo(objMalos.size()))
	}

	override method objetivoCumplido() = personaje.puntos() >= 50
}

object fin{
	method position() = game.center()
	method image() = "youWin.png"
	method iniciar(){
		game.stop()
		game.addVisual(self)
	}
}

object gameOver {
	method position() = game.origin()
	method image() = "gameOver.png"
}
//MODELADO DE PUNTAJE
object puntaje {
    var puntajeVisible = false 
    method position()=game.at(18,19)
    method text()= "Puntaje: " + personaje.puntos() //Averiguar como cambiar el tamaño a los textos
    method textColor() = paleta.rojo()
	method textSize() = 100
    method alternarPuntaje() {
        if (puntajeVisible) {
            game.removeVisual(self) 
        } else {
            game.addVisual(self) 
        }
        puntajeVisible = not puntajeVisible 
    }
}
//MODELADO TITULO DE NIVEL DOS
object tituloLvlDos{
  var tiempo = 100
  method position() = game.at(10,18)
  method text() = "NIVEL 2"
  method textColor() = paleta.rojo()
  method textSize() = 100//Averiguar como cambiar el tamaño a los textos
  method mostrarTitulo(){
	game.addVisual(self)
	game.onTick(100,"Eliminar Texto",{
		tiempo -=1
		if(tiempo<=0){
			game.removeVisual(self)
		}
	})
  }
}
object paleta {
  const property verde = "00FF00FF"
  const property rojo = "FF0000FF"
  //agregar mas colores o colores mas lindos
}
