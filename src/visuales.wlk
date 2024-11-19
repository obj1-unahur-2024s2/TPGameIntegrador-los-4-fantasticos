import pirata.*
import niveles.*

object puntaje {
	method image() = ("barra" + pirata.puntos() +".png")
	method position() = game.at(game.width()-4, game.height()-4)
}

object vidas{
	method image() = ("corazon" + pirata.vidas() +".png")
	method position() = game.at(game.width()-4, game.height()-3)
}

object gameOver {
	method position() = game.at(2, 2)
	method image() = "gameOver.png"
}

class Titulo {
	const image = "nivelUnoChico.png"
	method image() = image
	method position() = game.at(0, 7)
	method parpadear() {
	  	game.onTick(80, "EncendidoLvl", {game.addVisual(self)})
		game.onTick(160, "ApagadoLvl", {game.removeVisual(self)})
		game.schedule(5000, {game.removeTickEvent("EncendidoLvl")
							game.removeTickEvent("ApagadoLvl")
							game.removeVisual(self)})
	}
}
object titulo2 inherits Titulo(image="nivelDosChico.png"){}