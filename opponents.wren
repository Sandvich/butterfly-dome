import "input" for Mouse
import "graphics" for Canvas, Color, Point
import "./racer" for Racer
import "./globals" for Generator
import "./api" for Maths

class AIOpponent is Racer {
    construct new(parent, x) {
        _aim = Point.new(x, Generator.int(Canvas.height))
        super(x, _aim.y, Racer.White)
        _parent = parent
    }

    changeAim() {
        _aim.y = _aim.y + Generator.int(-10, 11)
        if (_aim.y >= Canvas.height) {
            _aim.y = _aim.y - 100
        } else if (_aim.y <= 0) {
            _aim.y = _aim.y + 100
        }
        _aim.x = _aim.x + Generator.int(-10, 11)
        if (_aim.x >= Canvas.width) {
            _aim.x = _aim.x - 100
        } else if (_aim.x <= 0) {
            _aim.x = _aim.x + 100
        }
    }

    update() {
        super()
        changeAim()
        move(_aim)
        _parent.addTempCanvasItem(this, x, y)
    }

    draw(x, y) {
        super(x, y)
        Canvas.circlefill(_aim.x, _aim.y, 1, Color.red)
    }
}
