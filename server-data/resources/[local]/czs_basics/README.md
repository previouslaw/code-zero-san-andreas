# czs_basics

A small QBCore resource for Code Zero: San Andreas.

## Commands

- `/czshelp` — list the commands.
- `/rules` — show the rules configured in `config.lua`.
- `/discord` — display the invite configured in `config.lua`.
- `/serverinfo` — show the server name and description.
- `/report <message>` — send a short report to online admins or the server console.
- `/czevent <message>` — announce an event to everyone; staff only.

The `/report` event checks its input on the server and limits each player to one report every 45 seconds. The `add_ace group.admin czs.staff allow` line grants the QBCore recipe's `group.admin` permission group access to reports.

