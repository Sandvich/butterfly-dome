import "input" for Mouse
import "graphics" for Canvas, Color, Point, ImageData
import "./globals" for Generator, Config
import "./api" for Maths

class Racer {
    construct new(x, y, colour) {
        // Movement stuff
        _loc = Point.new(x,y)
        _velocity = Point.new(0,0)
        _accel = Point.new(0,0)
        _moveMode = Config.getMoveMode("normal")
        _g = Point.new(0, 2)
        _generator = Generator
        // Animation stuff
        _image = ImageData.loadFromFile(colour)
        _rightFrames = []
        _leftFrames = []
        for (i in Maths.range(12)) {
            _rightFrames.add(_image.transform({"srcX": i*30, "srcY": 0,"srcW": 30, "srcH": 25}))
            _leftFrames.add(_image.transform({"srcX": i*30, "srcY": 0,"srcW": 30, "srcH": 25, "scaleX": -1}))
        }
        _frames = _rightFrames
        _currentFrameIndex = 0
        _count = 0
    }

    move(towardsVector) {
        _accel = (towardsVector - _loc) / 20
        if (_accel.length > _moveMode.maxAccel) {
            _accel = _accel.unit * _moveMode.maxAccel
        }
        var erratic = Point.new(_generator.float(-1,1), _generator.float(-1,1)).unit * _generator.float() * _moveMode.maxAccel
        _velocity = _velocity + _accel + _g + erratic
        if (_velocity.length > _moveMode.maxVel) {
            _velocity = _velocity.unit * _moveMode.maxVel
        }
        _loc = _loc + _velocity
    }

    update() {
        // Set which animations we're using: left or right
        if (_velocity.x >= 0) {
            _frames = _rightFrames
        } else {
            _frames = _leftFrames
        }
        // And up or down
        if (_accel.y < _moveMode.maxAccel/5) {
            var maxcount = 6
            if (_accel.y < 0) { maxcount = 2 }
            if (_count >= maxcount) {
                _currentFrameIndex = _currentFrameIndex + 1
                if (_currentFrameIndex == 12) { _currentFrameIndex = 0}
                _count = 0
            } else {
                _count = _count + 1
            }
        } else {
            _currentFrameIndex = 0
            _count = _count + 1
            if (_count >= 30) {
                _currentFrameIndex = 2
                _count = 0
            }
        }
    }

    draw(x, y) {
        _frames[_currentFrameIndex].draw(x-15, y-12)
    }

	loc { _loc }
	x { _loc.x }
	y { _loc.y }

    static Blue { "img/butterfly-blue-sheet.png" }
    static Green { "img/butterfly-green-sheet.png" }
    static Orange { "img/butterfly-orange-sheet.png" }
    static White { "img/butterfly-white-sheet.png" }
    static Yellow { "img/butterfly-yellow-sheet.png" }
}
