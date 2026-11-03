# Learn the basics as you build

## The three pieces

- **FXServer** is the always-on program that runs the game server.
- **txAdmin** is the browser dashboard used to manage the server and deploy recipes.
- A **resource** is a plugin folder, usually made of Lua scripts and an `fxmanifest.lua` manifest.

## How a resource starts

The `fxmanifest.lua` file describes the resource. `config.lua` holds the settings you are meant to customize. `client.lua` runs on each player's game client. `server.lua` runs on the server and is where player-submitted data must be checked before it is trusted.

The `ensure czs_basics` line in `server.cfg` tells FXServer to start that resource. If you add a folder or resource while FXServer is already open, use the server console command `refresh`, then `ensure resource-name`.

## Commands to learn

- `ensure name` starts a resource or restarts it if it is already running.
- `stop name` stops a resource.
- `restart name` reloads a resource after an edit.
- `status` lists connected players.

## A good learning loop

1. Change one setting in `config.lua`.
2. Restart `czs_basics` from the server console.
3. Test the related command in game.
4. Read the server console if something does not work.
5. Save a backup before changing framework or database resources.

Start by editing the rules and welcome message. Later, you can make a resource for one feature at a time, such as a friend-group job, a custom location, or a simple event system.

