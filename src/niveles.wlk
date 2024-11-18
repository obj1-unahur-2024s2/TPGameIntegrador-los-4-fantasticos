import wollok.game.*
import personaje.*
import objetos.*

object config {
	method configurarTeclas() {
		keyboard.left().onPressDo({personaje.moverIzquierda()})
		keyboard.right().onPressDo({personaje.moverDerecha()})
		keyboard.space().onPressDo({game.stop()})
		/*keyboard.enter().onPressDo({if (not personaje.vivo())
									juego.reiniciar()})
		Averiguar como reinciar el juego cuando muere*/
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
		game.onTick(2000, "GenerarObjetosBuenos", {self.randomBuenos().aparecer()})
		game.onTick(3500, "GenerarObjetosMalos", {self.randomMalos().aparecer()})
	}

	method randomBuenos() {
		const objBuenos = [new MonedaOro(), new Cofre()]
		return
		objBuenos.get(0.randomUpTo(objBuenos.size()))
	}

	method randomMalos() {
		const objMalos = [new Bomba()/*, new Espada()*/]
		return
		objMalos.get(0.randomUpTo(objMalos.size()))
	}
	method objetivoCumplido()
}
object nivel1 inherits Nivel(siguiente=nivel2){
	override method objetivoCumplido() = personaje.puntos() == 50
}

object nivel2 inherits Nivel(siguiente=fin) {
	override method iniciar() {
		game.clear()
		game.onTick(2000, "GenerarObjetosBuenos", {self.randomBuenos().aparecer()})
		game.onTick(2000, "GenerarObjetosMalos", {self.randomMalos().aparecer()})
	}

	override method randomBuenos() {
		const objBuenos = [new MonedaOro(), new Cofre()/*,new GemaDeLosMares()*/]
		return
		objBuenos.get(0.randomUpTo(objBuenos.size()))
	}

	override method randomMalos() {
		const objMalos = [new Bomba(), new Pulpo()/*, new Espada()*/]
		return
		objMalos.get(0.randomUpTo(objMalos.size()))
	}

	override method objetivoCumplido() = personaje.puntos() == 100
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
