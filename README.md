# Butterfly Dome

Butterfly Dome is a game built for [A Game By Its Cover 2020](https://itch.io/jam/a-game-by-its-cover-2020), inspired by
the 2020 Famicase Exhibition.

The game was inspired by the following [entry](https://famicase.com/20/softs/016.html), made by GENIE:

<img src="https://famicase.com/20/softs/016_sample.jpg" alt="Butterfly Dome NES case" width="615">

## Building the Game

If you want to build the game yourself, you will need to install the development version of SDL2. Once you have done
that as appropriate for your system, simply clone the repo, pull the submodules, and build the dome repo:

```bash
git clone https://github.com/Sandvich/butterfly-dome
cd butterfly-dome
git submodule init
git submodule update
cd dome
make
cd ..
./butterfly-dome
```

Note: the executable `butterfly-dome` is simply a symlink to the executable `dome/dome`. If you don't have an executable,
eg if you haven't compiled the submodule, it will not run. Download the compiled version from [Itch.io](https://ttio.itch.io/butterfly-dome)
instead.
 