# Code Zero: San Andreas

![Code Zero: San Andreas logo](assets/server-icon.png)

A custom, community roleplay server starter for FiveM built on QBCore. The install recipe brings in the free QBCore roleplay stack and the Code Zero resources in this repository.

## Included

- QBCore character creation, spawn selection, inventory, shops, banking, phone, housing, apartments, garages, clothing, vehicles, and admin tools.
- Police and EMS roleplay, plus civilian jobs and activities such as taxi, bus, tow, garbage, recycling, trucking, diving, crafting, and legal/illegal activities.
- pma-voice and QBCore radio resources.
- Custom Code Zero emergency and service dispatch: use `/911 message` for on-duty police and EMS, or `/311 message` for mechanics and tow.
- Custom City Hall courier route: press **E** at the Code Zero job clerk, deliver five parcels, and collect a server-validated cash payout. Use `/cancelroute` to stop a route.
- Code Zero server branding and a FiveM server icon made from the supplied logo.

The upstream resources are downloaded from their public repositories during installation instead of being copied into this repository. They remain subject to their own licenses. This starter includes no paid scripts, paid assets, Tebex dependency, or paid container.

## Install with txAdmin

1. Install FXServer and open txAdmin. Create a new server profile.
2. In the deployment page, choose **Popular Recipes → Custom Recipe** and use this recipe URL after the project is on the `main` branch:  
   `https://raw.githubusercontent.com/previouslaw/code-zero-san-andreas/main/recipes/code-zero-qbcore.yaml`
3. Create a free Cfx.re server registration key and enter it in txAdmin's private recipe prompt. Enter a MySQL-compatible database connection string there too. Do not put either secret in this repository.
4. Run the recipe and wait for resource downloads and the QBCore database setup to finish.
5. Configure the server name, description, tags, and banner in the Cfx Portal server settings, then start the server from txAdmin.

The recipe uses the current QBCore txAdmin install list and installs the server icon, config, and custom Code Zero resources. A computer or server host and a MySQL-compatible database still need to be available; whether those cost money depends on where you run them.

## First session

- Create a character at the multicharacter screen and choose a spawn.
- Use the QBCore City Hall and job resources to choose activities and get started.
- For a custom delivery route, visit the clerk outside City Hall at `(-266, -963, 31)`, press **E**, and follow the GPS route.
- Use `/911` or `/311` followed by a short message to send a fictional in-game dispatch alert to on-duty services. These are game roleplay commands, not real emergency services.

## Configuration and safety

- The deploy recipe asks for the Cfx key and database connection inside txAdmin. Keep them out of chat, source control, and screenshots.
- The included `server/server.cfg` is a txAdmin template. If you run FXServer outside the recipe, create a private local copy and replace the template values there; never commit real credentials.
- Give admins access through txAdmin's Admin Manager. Keep the master account secure and grant only the permissions each staff member needs.
- Keep a database backup before changing QBCore resources or updating upstream dependencies.

## Repository layout

```
assets/                      Code Zero server icon
docs/                        Setup and free-resource notes
recipes/                     txAdmin deployment recipe
resources/[codezero]/        Custom Code Zero resources
server/server.cfg            Secret-free txAdmin config template
```

See [Deployment](docs/DEPLOYMENT.md) and [Free resource register](docs/FREE-RESOURCES.md) for the full setup details and upstream links.
