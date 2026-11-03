# Deployment

This project is a ready-to-install server pack. txAdmin downloads FXServer resources, creates the QBCore database tables, copies the Code Zero config and resources, and starts the server. It does not host the server or supply a Cfx registration key or database.

## What you need

- FXServer with txAdmin on Windows or Linux.
- A free Cfx.re server registration key.
- A MySQL-compatible database reachable by FXServer.
- GitHub access to this repository while the install recipe downloads its custom resources.

## Install

1. Start FXServer without a server config so txAdmin can initialize, then create a new profile.
2. In txAdmin, choose **Popular Recipes**, then **Custom Recipe**.
3. Paste the raw recipe URL:
   `https://raw.githubusercontent.com/previouslaw/code-zero-san-andreas/main/recipes/code-zero-qbcore.yaml`
4. Enter the Cfx key and database connection string into txAdmin's private recipe inputs. Use an empty database dedicated to this server.
5. Run the recipe and wait for it to install the framework/resources and apply the QBCore SQL schema.
6. Review the generated `server.cfg`, save it in txAdmin, and start the server.
7. Configure server listing details in the Cfx Portal and share the connection address with your community.

If you are using this project before the recipe is merged into `main`, use the raw URL for the branch that contains the recipe instead. The install recipe downloads custom resources from `main`, so merge the project branch before starting deployment.

## Secret handling

- Never commit a live `server.cfg`, Cfx key, database password, Discord token, or API token.
- Enter the key and database string through txAdmin's recipe prompts. For manual hosting, create a local-only config file and keep it out of Git.
- If a database password contains reserved characters, URL-encode it in the connection string.
- Restrict the database user to the server database. Do not expose the database port publicly.
- Use txAdmin's Admin Manager for people and permissions. Do not give every staff member full command access.
- Keep backups of the QBCore database before updates.

## First boot checks

- The txAdmin console should show `oxmysql`, `qb-core`, QBCore resources, and the two Code Zero resources starting without errors.
- Connect with FiveM using the server address, create a character, and try a QBCore civilian job.
- Use `/911 test call` and `/311 service request` while police/EMS or mechanic/tow characters are on duty to check dispatch.
- Visit the City Hall clerk and complete a courier route. Each stop is checked on the server before money is paid.

## Server listing and branding

The included `assets/server-icon.png` is copied to the FXServer data root and loaded as the server icon. Configure the public server name, description, tags, and optional banners in Cfx Portal. The Cfx Portal controls server listing metadata for current FXServer setups.
