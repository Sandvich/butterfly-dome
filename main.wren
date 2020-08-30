import "dome" for Window
import "./api" for Fading
import "./game" for MainScene

class Game {

    static init() {
	    // DOME setup stuff
        Window.title = "Butterfly DOME"
        Window.lockstep = true
        Window.resize(800, 600)

        // Load scenes into a dict
        __scenes = {
            "moveTest": MainScene
        }

        // Initialise the Audio
        Fading.init({})

        // Open the menu
        // loadScene("menu")
        loadScene("moveTest")
    }

	static update() {
		Fading.update()
		__currentScreen.update()
		__currentScreen.mouseHandler()
		__currentScreen.keyboardHandler()
		__currentScreen.gamepadHandler()
	}

	static draw(dt) { // Technically this is called alpha now. Doesn't really change anything though.
		__currentScreen.draw(dt)
	}

	static loadScene(sceneClass) {
		System.print("Trying to load %(sceneClass)")
		if (__scenes.containsKey(sceneClass)) { __currentScreen = __scenes[sceneClass].run(this) }
	}

	static loadScene(sceneClass, args) {
		if (__scenes.containsKey(sceneClass)) { __currentScreen = __scenes[sceneClass].run(this, args) }
	}
}
