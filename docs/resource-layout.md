# Keep resources organized

FiveM calls each add-on a **resource**. A resource is a folder with an `fxmanifest.lua` file that tells FXServer what code and files to load. Keep resources grouped by purpose so updates and troubleshooting stay manageable.

| Folder | What belongs there |
| --- | --- |
| `[qb]` | QBCore framework and QBCore roleplay resources from the recipe |
| `[standalone]` | Utilities that do not depend on a roleplay framework |
| `[voice]` | Voice resources and radio integrations |
| `[defaultmaps]` | The recipe's default hospital, dealership, and prison map resources |
| `[vehicles]` | Optional vehicle add-ons and handling packs you add later |
| `[clothing]` | Optional clothing and appearance resources you add later |
| `[local]` | Code Zero scripts you write or maintain, including `czs_basics` |

The QBCore recipe uses `[defaultmaps]` for its map add-ons. The bracket names are organization folders. A server config starts a resource by its resource name, for example `ensure czs_basics`. Put resources in one place only, and avoid renaming a resource if another resource depends on its name.

## Adding a resource safely

1. Read its README and license. Check which framework and dependencies it needs.
2. Back up the resource folder and database before changing a working server.
3. Put the resource in the matching category folder.
4. Add its `ensure resource-name` line after its dependencies in `server.cfg`.
5. Restart the server and read the console for missing dependencies or SQL errors.

Avoid downloading a random bundle just because it says “free.” Check the source, license, update history, and dependencies first.

