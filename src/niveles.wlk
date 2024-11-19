import wollok.game.*
import pirata.*
import objetos.*
import visuales.*

object config {
	method configurarTeclas() {
		keyboard.left().onPressDo({pirata.moverIzquierda()})
		keyboard.right().onPressDo({pirata.moverDerecha()})
		keyboard.space().onPressDo({game.stop()
									juego.nivelActual().musica().stop()})
	}
}

object juego {
	var property nivelActual = nivel1
	method iniciar() {
		game.title("Pirata")
		game.height(20)
		game.width(20)
		game.boardGround("playa.png")
		config.configurarTeclas()
		inicio.iniciar()
	}
	method terminar() {
		nivelActual.pararMusica()
		game.sound("gameOver.mp3").play()
		game.clear()
		game.addVisual(pirata)
		game.addVisual(gameOver)
		game.schedule(8000,{self.reiniciar()}) 
	}

	method reiniciar() {
		game.clear()
		pirata.sumarVida(3)
		nivel1.iniciar()
	}
}

object inicio {
	var image = "inicio1.png"
	method image() = image
	method position() = game.origin()

	method iniciar() {
		game.addVisual(self)
		game.schedule(10000, {	game.removeVisual(self)
								image = "inicio2.png"
								game.addVisual(self)})
		game.schedule(20000, {	game.removeVisual(self)
								nivel1.iniciar()})
	}
}

class Nivel {
	const property siguiente 
	const property musica = game.sound("lvl1.mp3")
	method iniciar(){
		pirata.puntos(0) 
		pirata.vidas(3)
		new Titulo().parpadear()
		self.prepararNivel()
		game.onTick(1500, "GenerarObjetos", {self.randomObjetos().aparecer()})
	}
	method reproducirMusica(){
		musica.shouldLoop(true)
		musica.volume(0.5)
		musica.play()
	}

	method prepararNivel(){
		juego.nivelActual(self)
		self.reproducirMusica()
		game.addVisual(vidas)
		game.addVisual(puntaje)
		config.configurarTeclas()
		game.addVisual(pirata)
		game.onCollideDo(pirata, {objeto => objeto.colisionar()})
	}

	method pararMusica(){
		musica.stop()
	}

	method randomObjetos() {
		//Manejo Probabilidad por lista
		const objetos = [new MonedaOro(lentitud = 300), new MonedaOro(lentitud = 300), new MonedaOro(lentitud = 300), new MonedaOro(lentitud = 300), new MonedaOro(lentitud = 300), new MonedaOro(lentitud = 300), /* 60% */
    					new Cofre(lentitud = 400), new Cofre(lentitud = 400), new Cofre(lentitud = 400), /* 25% */
    					new Bomba(lentitud = 250), new Bomba(lentitud = 250), /* 10% */
    					new Espada(lentitud = 350)] /* 5% */
		return
		objetos.get(0.randomUpTo(objetos.size()))
	}

	method objetivoCumplido()
	
}

object nivel1 inherits Nivel(siguiente=nivel2){
	override method objetivoCumplido() = pirata.puntos() >= 40
}

object nivel2 inherits Nivel(siguiente=fin, musica=game.sound("lvl2.mp3")) {
	override method iniciar() {
		game.clear()
		titulo2.parpadear()
		nivel1.pararMusica()
		self.prepararNivel()
		game.onTick(1000, "GenerarObjetos", {self.randomObjetos().aparecer()})
	}

	override method randomObjetos() {
		//Manejo Probabilidad por lista
		const objBuenos = [	new MonedaOro(lentitud = 250), new MonedaOro(lentitud = 250), new MonedaOro(lentitud = 250), new MonedaOro(lentitud = 250), /* 40% */
   							new Cofre(lentitud = 350), new Cofre(lentitud = 350), /* 20% */
    						new Perla(lentitud = 200), /* 5% */
   							new Bomba(lentitud = 200), new Bomba(lentitud = 200), new Bomba(lentitud = 200), new Bomba(lentitud = 200), /* 20% */
    						new Espada(lentitud = 300), new Espada(lentitud = 300), /* 10% */
    						new Pulpo(lentitud = 250)] /* 5% */
		return
		objBuenos.get(0.randomUpTo(objBuenos.size()))
	}

	override method objetivoCumplido() = pirata.puntos() >= 100
}

object fin{
	method position() = game.at(5,6)
	method image() = "youWin.png"
	method iniciar(){
		juego.nivelActual(self)
		nivel2.pararMusica()
		game.sound("victory.mp3").play()
		game.clear()
		game.addVisual(self)
		game.schedule(10000, {
			game.clear()
			nivel1.iniciar()})
	}
}


