import "graphics" for ImageData, Point, Canvas, Color
import "audio" for AudioEngine
// A set of common classes that we can use to make life easier

class Sprite {
	// An image that can be displayed on the screen.
	construct new(filename, center) {
		_center = center
		sprite = filename
	}
	construct new(filename) {
		_center = false
		sprite = filename
	}

	sprite=(filename) { _sprite = ImageData.loadFromFile(filename) }
	width { _sprite.width }
	height { _sprite.height }

	draw (x, y) {
		if (_center) {
			x = x - (_sprite.width / 2)
			y = y - (_sprite.height / 2)
		}

		_sprite.draw(x, y)
		// Store this so that we know the co-ordinates that refer to this sprite
		_loc = Point.new(x, y)
	}

	getSize() {
		if (_loc != null) {
			return [_loc, Point.new(_loc.x + _sprite.width, _loc.y + _sprite.height)]
		}
	}
}

class Button is Sprite {
	// An interactable button, including a sprite.
	construct new(image, action, center) {
		super(image, center)
		this.action = action
	}
	construct new(image, action) {
		super(image, false)
		this.action = action
	}

	action=(function) {
		if (function is Fn) {
			_action = function
		} else {
			_action = Fn.new { System.print(function) }
		}
	}

	onClick() {
		_action.call()
	}

	hover=(func) {
		_hover = func
	}

	onHover() {
		if (_hover != null) {
			_hover.call()
		} else {
			System.print("Hovering!")
		}
	}
}

class Scene {
	// The core class for scenes. Will do little on its own, other than managing the
	// draw loop.
	// Subclass to create a scene.

	construct init() {
		_toDraw = []
		_tempDraw = []
		_toUpdate = []
		_bgColour = Color.black
	}

	static run() {
		// We use the static function run for all scenes instead of their constructors,
		// as this means that when we're done with the scene all memory associated with
		// it is freed automatically.
		return init()
	}

	update() {
		_tempDraw = []
		for (item in _toUpdate) { item.update() }
	}

	draw(dt) {
		Canvas.cls()
		Canvas.rectfill(0, 0, Canvas.width, Canvas.height, _bgColour)
		for (item in _toDraw) {
			item[0].draw(item[1].x, item[1].y)
		}
		for (item in _tempDraw) {
			item[0].draw(item[1].x, item[1].y)
		}
	}

	addCanvasItem(item, x, y) { _toDraw.add([item, Point.new(x,y)]) }
	addTempCanvasItem(item, x, y) { _tempDraw.add([item, Point.new(x,y)]) }
	bgColour=(value) { _bgColour = value }
	addUpdatedItem(item) { _toUpdate.add(item) }

	mouseHandler() {}
	keyboardHandler() {}
	gamepadHandler() {}
}

class CanvasString {
	construct new(string) {
		_string = string
		_center = false
	}
	construct new(string, center) {
		_string = string
		_center = center
	}

	draw(x, y) {
		if (_center) {
			x = x - (4 * _string.count)
			// Imperfect, but we shouldn't be using any multi-byte characters
		}
		Canvas.print(_string, x, y, Color.white)
	}
}

class Fading {
	static init(audioMap) {
		for (item in audioMap.keys) {
			AudioEngine.load(item, audioMap[item])
		}
		__fadeIn = []
		__fadeOut = []
	}

	static play(trackname) {
		var channelID = AudioEngine.play(trackname, 0, true)
		System.print("Now fading in %(trackname) on channel %(channelID)")
		__fadeIn.add(channelID)
		__fadeIn.add(0)
		return __fadeIn[0]
	}

	static stop(channelID) {
		__fadeOut.add(channelID)
		if (__fadeIn.count > 0 && __fadeIn[0] == channelID) {
			__fadeOut.add(__fadeIn[1])
			__fadeIn = []
		} else {
			__fadeOut.add(1)
		}
	}

	static update() {
		if (__fadeIn.count > 0) {
			__fadeIn[1] = __fadeIn[1] + 0.01
			AudioEngine.setChannelVolume(__fadeIn[0], __fadeIn[1])
			if (__fadeIn[1] >= 1.0) {
				__fadeIn = []
			}
		}

		if (__fadeOut.count > 0) {
			__fadeOut[1] = __fadeOut[1] - 0.01
			AudioEngine.setChannelVolume(__fadeOut[0], __fadeOut[1])
			if (__fadeOut[1] <= 0) {
				AudioEngine.stopChannel(__fadeOut[0])
				__fadeOut = []
			}
		}
	}

	static isPlaying(channelID) { AudioEngine.isPlaying(channelID) }
	static stopAllChannels() { AudioEngine.stopAllChannels() }
}

class AnimatedSprite is Sprite {
	construct new(filenames, center) {
		_center = center
		setAnimation(filenames)
	}

	construct new(filenames) {
		_center = false
		setAnimation(filenames)
	}

	setAnimation(filenames) {
		_count = 0
		speed = 5
		_frameNumber = 0
		_animationFrames = []
		for (file in filenames) {
			_animationFrames.add(Sprite.new(file, _center))
		}
	}

	draw(x,y) {
		_animationFrames[_frameNumber].draw(x,y)
		_loc = Point.new(x, y)
	}

	speed=(speed) { _speed = speed }
	getSpeed { _speed }
	update() {
		_count = _count + 1
		if (_count == getSpeed) {
			_frameNumber=_frameNumber+1
			if (_frameNumber == _animationFrames.count) { _frameNumber = 0 }
			_count = 0
		}
	}

	getSize() {
		if (_loc != null) {
			return [_loc, Point.new(_loc.x + _animationFrames[_frameNumber].width, _loc.y + _animationFrames[_frameNumber].height)]
		}
	}
}

class Maths {
	static arange(start, stop, size) {
		var step = (stop-start)/size
		return range(start, stop, step)
	}

	static range(stop) {
		return range(0, stop, 1)
	}

	static range(start, stop) {
		return range(start, stop, 1)
	}

	static range(start, stop, step) {
		var out = []
		var i = 0
		while (i < stop) {
			out.add(step*i + start)
			i = i + 1
		}
		return out
	}
}
