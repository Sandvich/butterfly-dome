import "./api" for Scene

class MainScene is Scene {
	construct init(parent) {
		_parent = parent

		setupDrawLoop()
		draw(0)
	}

	// Boilerplate + functions
	static run(parent) {
		return init(parent)
	}
}