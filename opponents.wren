import "input" for Mouse
import "graphics" for Canvas, Color, Point
import "./racer" for Racer
import "./globalRandom" for Generator
import "./api" for Maths

class AIOpponent is Racer {
    construct new(parent, x) {
        _aim = Point.new(x, Generator.int(1080))
        super(x, _aim.y)
        _parent = parent
    }

    changeAim() {
        _aim.y = _aim.y + Generator.int(-10, 11)
        if (_aim.y >= 1080) { _aim.y = _aim.y - 100 }
        if (_aim.y <= 0) { _aim.y = _aim.y + 100 }
        _aim.x = _aim.x + Generator.int(-10, 11)
        if (_aim.x >= 1920) { _aim.x = _aim.x - 100 }
        if (_aim.x <= 0) { _aim.x = _aim.x + 100 }
    }

    update() {
        changeAim()
        move(_aim)
        _parent.addTempCanvasItem(this, x, y)
    }

    draw(x, y) {
        Canvas.circlefill(x, y, 5, Color.green)
        Canvas.circlefill(_aim.x, _aim.y, 1, Color.red)
    }
}
