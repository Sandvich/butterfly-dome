import "graphics" for Color
import "./api" for Scene, Maths
import "./player" for Player
import "./opponents" for AIOpponent

class MainScene is Scene {
	construct init(parent) {
		// Boilerplate, needed for every Scene
		super()
		_parent = parent
		bgColour = Color.white

		// Create the player
		_player = Player.new(this)
		addTempCanvasItem(_player, _player.x, _player.y)
		addUpdatedItem(_player)

		// Create 3 AIs
		var numOpponents = 3
		_opponents = []
		for (i in Maths.range(numOpponents)) {
			_opponents.add(AIOpponent.new(this, 100))
			addUpdatedItem(_opponents[-1])
		}

		draw(0)
	}

	// Boilerplate + functions
	static run(parent) {
		return init(parent)
	}
}