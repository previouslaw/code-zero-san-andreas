# Deployment

This public repository includes a txAdmin recipe that installs the QBCore base, database schema, Code Zero resources, and supplied-logo server icon.

## Requirements

- FXServer with txAdmin on Windows or Linux.
- A Cfx.re server registration key.
- A MySQL-compatible database reachable by FXServer.

## Install

1. Start FXServer without a server config so txAdmin can initialize, then create a server profile.
2. Choose **Popular Recipes → Custom Recipe**.
3. Paste the Code Zero recipe URL:
   `https://raw.githubusercontent.com/previouslaw/code-zero-san-andreas/main/recipes/code-zero-qbcore.yaml`
4. Enter the Cfx key and database connection in txAdmin's setup prompts. Use an empty database dedicated to this server.
5. Run the recipe and wait for it to finish downloading resources and creating the QBCore tables.
6. Start the server from txAdmin. Configure its public name, description, tags, and optional banner in the Cfx Portal.

The recipe downloads the Code Zero resources from this public repository. The supplied icon is placed in the server data root and loaded by the generated `server.cfg`.

## Updates

The recipe installs a complete server on first deployment. For later Code Zero updates:

1. Stop FXServer.
2. Pull the latest `main` branch into your local repository clone.
3. Run `scripts/install-codezero.ps1` on Windows or `scripts/install-codezero.sh` on Linux, passing the txAdmin profile folder containing `server.cfg` and `resources`.
4. Start the server and check the txAdmin console.

See [Local sync](LOCAL-SYNC.md) for cloning the repository and syncing it with your PC.

## Secret handling

- Never commit a live `server.cfg`, Cfx key, database password, Discord token, or API token.
- Enter the Cfx key and database string through txAdmin's setup prompts.
- URL-encode reserved characters in a database connection string.
- Restrict the database user to this server's database and do not expose the database port publicly.
- Use txAdmin's Admin Manager to grant staff only the permissions they need.
- Back up the QBCore database before changing upstream resources.

The software and custom resources are free. Server hardware, internet service, and hosted database services may have separate costs.
