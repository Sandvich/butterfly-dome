import "./api" for Scene
import "./player" for Player

class MainScene is Scene {
	construct init(parent) {
		super()
		_parent = parent

		setupDrawLoop()
		var test = []

		_player = Player.new(this)
		addTempCanvasItem(_player, _player.x, _player.y)

		draw(0)
	}

	update() {
		super()
		_player.update()
	}

	mouseHandler() { _player.mouseHandler() }

	// Boilerplate + functions
	static run(parent) {
		return init(parent)
	}
}