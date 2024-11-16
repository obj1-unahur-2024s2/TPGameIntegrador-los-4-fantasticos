
object config {

	method configurarTeclas() {
		keyboard.left().onPressDo({ pepita.irA(pepita.position().left(1))})
		keyboard.right().onPressDo({ pepita.irA(pepita.position().right(1))})
		keyboard.up().onPressDo({pepita.irA(pepita.position().up(1))})
		keyboard.down().onPressDo({pepita.irA(pepita.position().down(1))})
		keyboard.m().onPressDo({
			
		})
	}
}