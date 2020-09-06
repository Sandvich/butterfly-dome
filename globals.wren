import "random" for Random 

var Generator = Random.new()

class Config {
    static init() {
        __width = 1920
        __height = 1080
        __moveModes = {}
    }
    static width { __width }
    static height { __height }
    static addMoveMode(name, mode) { __moveModes[name] = mode }
    static getMoveMode(name) { __moveModes[name] }
}

class MoveMode {
    construct new(maxAccel, maxVel, boostMultiplier) {
        _maxAccel = maxAccel
        _maxVel = maxVel
        _boostMultiplier = boostMultiplier
    }
    maxAccel { _maxAccel }
    maxVel { _maxVel }
    maxVelocity { _maxVel }
    boostMultiplier { _boostMultiplier }
}

Config.init()
Config.addMoveMode("normal", MoveMode.new(3,15,2))
