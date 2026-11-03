# Deployment

This private repository contains the custom Code Zero resources and a post-install script. txAdmin cannot anonymously download resources from a private GitHub repository, so the install uses the public QBCore recipe for the base server and copies Code Zero files from your authenticated local checkout.

## Requirements

- FXServer with txAdmin on Windows or Linux.
- A free Cfx.re server registration key.
- A MySQL-compatible database reachable by FXServer.
- An authenticated local checkout of this repository on the machine that holds the server profile.

## Install the QBCore base

1. Start FXServer without a server config so txAdmin can initialize, then create a new profile.
2. In txAdmin, choose **Popular Recipes → Custom Recipe**.
3. Paste the official public recipe URL:
   `https://raw.githubusercontent.com/qbcore-fivem/txAdminRecipe/main/qbcore.yaml`
4. Enter the Cfx key and database connection string in txAdmin's setup prompts. Use an empty database dedicated to this server.
5. Run the recipe and wait for the QBCore resources and database schema to finish installing.

## Install Code Zero resources

1. Stop the server in txAdmin.
2. Check the generated server profile path. It must contain both `server.cfg` and `resources/[qb]/qb-core`.
3. Make this private repository available on the host using your normal GitHub sign-in, GitHub Desktop, or another authenticated checkout. Do not paste a GitHub token into this project.
4. Run the script from the repository root, passing the server profile folder (the folder that contains `server.cfg` and `resources`).

   **Windows PowerShell**
   ```powershell
   .\scripts\install-codezero.ps1 -ServerDataPath "C:/FXServer/txData/CodeZero"
   ```

   **Linux**
   ```bash
   bash scripts/install-codezero.sh /path/to/txData/CodeZero
   ```

The script is safe to run again. It copies the two Code Zero resources and the supplied-logo icon, adds `ensure [codezero]` if missing, and points `load_server_icon` at `server-icon.png`. It does not replace the generated server config or its key/database values.

## Finish setup

1. Open the generated `server.cfg` in txAdmin and confirm it contains `ensure [codezero]` and `load_server_icon "server-icon.png"`.
2. Configure the server name, description, tags, and optional banners in the Cfx Portal.
3. Start the server and review the txAdmin console for resource errors.
4. Connect through FiveM, create a character, and try the City Hall jobs.
5. For dispatch, use `/911 test call` with an on-duty police/EMS character online, or `/311 service request` with an on-duty mechanic/tow character online.

## Secret handling

- Never commit a live `server.cfg`, Cfx key, database password, Discord token, or API token.
- Enter the key and database string through txAdmin's private prompts. For manual setup, create a local-only config file and keep it out of Git.
- URL-encode reserved characters in a database connection string.
- Restrict the database account to this server's database and do not expose the database port publicly.
- Use txAdmin's Admin Manager to grant staff only the permissions they need.
- Back up the QBCore database before updating resources.

## Hosting and listing

The server icon is copied to the FXServer data root and loaded from `server-icon.png`. Configure the public server name, description, tags, and optional banners in Cfx Portal. The software and included custom resources are free; server hardware, internet service, and a hosted database may have separate costs.
