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
        Canvas.rect(Canvas.width-50, 20, 30, Canvas.height-40, Color.red)
        Canvas.rect(Canvas.width-49, 21, 28, Canvas.height-42, Color.red)
        Canvas.rect(Canvas.width-48, 22, 26, Canvas.height-44, Color.red)
        super(x, y)
        var energyBar = energyLevel/maxEnergyLevel * (Canvas.height - 46)
        if (energyBar > 0) { Canvas.rectfill(Canvas.width-47, Canvas.height-23 - energyBar, 24, energyBar, Color.red) }
    }
}
