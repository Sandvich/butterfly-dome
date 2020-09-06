import "input" for Mouse
import "graphics" for Canvas, Color, Point
import "./racer" for Racer

class Player is Racer {
    construct new(parent) {
        super(300, 400, Racer.Green)
        _parent = parent
    }

    update() {
        super()
        move(Point.new(Mouse.x, Mouse.y))
        _parent.addTempCanvasItem(this, x, y)
    }

    draw(x, y) {
        super(x, y)
        Canvas.rectfill(Canvas.width-50, 20, 30, Canvas.height-40, Color.red)
        Canvas.rectfill(Canvas.width-47, 23, 24, Canvas.height-46, Color.white)
        super(x, y)
        var energyBar = energyLevel/maxEnergyLevel * (Canvas.height - 46)
        if (energyBar > 0) { Canvas.rectfill(Canvas.width-47, Canvas.height-23 - energyBar, 24, energyBar, Color.red) }
    }
}
