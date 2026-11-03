# Requested roleplay features

Deploy the maintained QBCore txAdmin recipe linked in the main README. Its current resource list includes the following systems. txAdmin downloads the third-party code during deployment; this kit keeps Code Zero's own code under `[local]`.

| Feature | Main recipe resources | What they give you |
| --- | --- | --- |
| Police | `qb-policejob`, `qb-prison`, `qb-storerobbery`, `qb-bankrobbery` | Police job, arrests and jail, and crime scenarios |
| EMS | `qb-ambulancejob`, `hospital_map` | Medical job and hospital/death systems |
| Mechanic and towing | `qb-mechanicjob`, `qb-towjob`, `qb-garages`, `qb-vehiclekeys` | Repair, towing, garages, and vehicle access |
| Businesses and work | `qb-management`, `qb-banking`, `qb-shops`, `qb-vehicleshop`, `qb-vehiclesales`, `qb-vineyard`, `qb-hotdogjob`, `qb-taxijob`, `qb-busjob`, `qb-newsjob` | Boss and employee management, banking, shops, dealerships, and starter work roles |
| Housing | `qb-houses`, `qb-apartments`, `qb-interior`, `qb-houserobbery` | Player housing, apartments, interior shells, and house robberies |
| Gangs | `qb-management` | Gang boss management and member grades, configured through QBCore gang data and the management resource |
| Racing and events | `qb-lapraces`, `qb-streetraces`, `czs_basics` | Lap races, street races, and staff event announcements with `/czevent` |
| Vehicles | `qb-vehicleshop`, `qb-vehiclesales`, `qb-garages`, `qb-vehiclekeys` | Vehicle purchasing, player sales, storage, and keys |
| Maps and interiors | `hospital_map`, `dealer_map`, `prison_map`, `qb-interior` | Starter map changes and reusable interiors |

The recipe also installs core features such as characters, inventory, player HUD, radio/voice, target interactions, admin tools, clothing, banking, and shops. Its maintainers can change the resource list, so check the recipe and each resource's license before updating or adding assets.

## Things to configure after installation

1. Add the Code Zero ACE line from `server-data/server.cfg.additions.cfg` so your admins can use reports and event announcements.
2. Review the job and gang names in QBCore's shared data. Give jobs and gangs the ranks, pay, and permissions your friend group wants.
3. Set the locations in each resource's config. The default locations work as a starting point, but should be checked in game.
4. Keep add-on vehicles, clothing, and extra interiors in their own category folders. Install one pack at a time and check its license and dependencies.
5. Enable txAdmin's whitelist for the private friend group, then add each friend there.

