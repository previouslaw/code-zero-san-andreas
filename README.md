# Code Zero: San Andreas

![Code Zero: San Andreas logo](assets/server-icon.png)

A custom community roleplay server for FiveM built on QBCore. The public txAdmin recipe installs the free QBCore stack and adds the custom Code Zero resources and supplied logo.

## Included

- QBCore character creation, spawn selection, inventory, shops, banking, phone, housing, apartments, garages, clothing, vehicles, and admin tools.
- Police and EMS roleplay, plus civilian activities such as taxi, bus, tow, garbage, recycling, trucking, diving, crafting, and legal/illegal activities.
- pma-voice and QBCore radio.
- Code Zero dispatch: `/911 message` alerts on-duty police and EMS; `/311 message` alerts mechanics and tow.
- City Hall courier route: press **E** at the Code Zero clerk, deliver five parcels, and collect server-validated payouts. Use `/cancelroute` to stop a route.
- Server icon made from the supplied Code Zero logo.

No paid scripts, assets, Tebex dependency, or paid container are included. Upstream resources keep their own licenses. A computer/server host, Cfx registration key, and database are still needed; whether hosting costs money depends on where you run them.

## Install with txAdmin

The FXServer runtime is not stored in this GitHub repository. Cfx distributes it separately as a server artifact.

1. Download the **Latest recommended** artifact for your operating system from the [official Cfx Server Download page](https://docs.fivem.net/docs/server-download/), then extract it somewhere permanent (for example, `C:\FXServer\server` on Windows).
2. Start `FXServer.exe` on Windows or `run.sh` on Linux without a server config. This starts txAdmin; if it does not open automatically, visit `http://localhost:40120`. See Cfx's [txAdmin setup guide](https://docs.fivem.net/docs/server-manual/setting-up-a-server-txadmin/).
3. Link your Cfx account, create a txAdmin password, and create a server profile.
4. On the **Deployment Type** screen, choose **Remote URL Template** and paste this recipe URL:
   `https://raw.githubusercontent.com/previouslaw/code-zero-san-andreas/main/recipes/code-zero-qbcore.yaml`
5. Enter the Cfx server key and MySQL-compatible database connection in txAdmin's setup prompts. Keep them out of GitHub and chat.
6. Run the recipe and wait for the QBCore database and resources to install. Start the server in txAdmin.

The recipe downloads this public repository directly, so the first install does not require a separate resource-copy step.

## Keep your PC copy in sync with GitHub

1. Install GitHub Desktop and sign in.
2. Choose **File → Clone Repository**, select `previouslaw/code-zero-san-andreas`, and choose a folder on your PC.
3. When GitHub has new commits, choose **Fetch origin**, then **Pull origin**. That updates the files in your local clone.
4. To apply Code Zero resource changes to an installed server profile, stop FXServer and run this from the local clone:

   ```powershell
   .\scripts\install-codezero.ps1 -ServerDataPath "C:/FXServer/txData/CodeZero"
   ```

GitHub Desktop keeps the clone connected to GitHub, but a remote change does not automatically overwrite the FiveM server files. See [Local sync](docs/LOCAL-SYNC.md) for scheduled fetching and update details.

## First session

- Create a character at the multicharacter screen and choose a spawn.
- Use QBCore City Hall and job resources to choose activities.
- Visit the clerk outside City Hall at `(-266, -963, 31)`, press **E**, and follow the courier GPS route.
- Use `/911` or `/311` with a short message for fictional in-game dispatch. These are game roleplay commands, not real emergency services.

## Security and updates

- The recipe asks for the Cfx key and database string through txAdmin's private setup flow. Do not commit real secrets.
- Grant staff permissions through txAdmin's Admin Manager.
- Back up the QBCore database before refreshing upstream resources; the recipe follows upstream branch/release references, which may change.

See [Deployment](docs/DEPLOYMENT.md), [Free resource register](docs/FREE-RESOURCES.md), [Local sync](docs/LOCAL-SYNC.md), and [Licensing notes](docs/LICENSING.md).
