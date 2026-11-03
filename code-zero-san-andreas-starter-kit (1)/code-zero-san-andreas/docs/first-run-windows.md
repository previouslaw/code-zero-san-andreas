# First run on Windows

This is a learning setup for a small server on your own PC. Your PC and internet connection need to stay on while friends are playing. Start with local connections; make it reachable from outside your home only after the local server works.

## 1. Install FXServer and open txAdmin

Follow the [official Cfx txAdmin setup guide](https://docs.fivem.net/docs/server-manual/setting-up-a-server-txadmin/). Download a recommended FXServer artifact, extract it to a simple path such as `C:\FXServer\server`, and run `FXServer.exe` to open the txAdmin setup page in your browser.

Create a server profile named `CodeZeroSanAndreas`. Use a strong txAdmin password and keep it private.

## 2. Deploy QBCore

In txAdmin, use the Server Deployer and choose the maintained QBCore recipe. Check that the recipe points to [qbcore-fivem/txAdminRecipe](https://github.com/qbcore-fivem/txAdminRecipe). Give the server the name `Code Zero: San Andreas` and follow txAdmin's prompts for the Cfx license key and database connection.

Create your Cfx key in the [Cfx Portal](https://portal.cfx.re/). Keep the key and database password in the local txAdmin setup. Never paste them into this chat or commit them to GitHub.

The recipe downloads QBCore and its dependencies, including common roleplay systems for characters, jobs, vehicles, housing, inventory, and administration. The exact resource list can change as maintainers update the recipe. Review the license and README for each added resource before using it.

## 3. Add the Code Zero resource

After txAdmin finishes, stop the server. Copy the `czs_basics` folder from this kit into the deployed server's `resources\[local]\` folder. Create `[local]` if it does not exist.

Use `assets\server-icon.png` as the server icon in the Cfx Portal settings. It is prepared at 96 × 96 pixels. The older `load_server_icon` config command is deprecated.

Open the generated `server.cfg` and append the lines in `server-data\server.cfg.additions.cfg`. Keep the existing recipe configuration and secrets in place. Start the server again from txAdmin.

## 4. Personalize it

Open `resources\[local]\czs_basics\config.lua` and change:

- `DiscordInvite` is already set to the invite you provided. Update it if the invite changes.
- `Rules` to the rules your group agrees on.
- `ServerDescription` and `WelcomeMessage` to match the server.

The Discord invite is already filled in. You can update it later in `config.lua`. In FiveM, connect to `localhost` to try it on the same PC. Try `/czshelp`, `/rules`, `/discord`, `/serverinfo`, and `/report`. Staff can announce an event with `/czevent <message>`.

## 5. Let friends connect

For friends outside your home network, the server needs to be reachable over the internet. That usually means configuring your router and Windows Firewall for the server's game port, and your internet provider must allow inbound connections. Do this after the local setup works. Share only the server address, never your Cfx key or txAdmin password.

Cloudflare Pages can host a website for the community. Pages and Workers are not a place to run FXServer itself: FiveM needs an always-on game server process and UDP game traffic.

