# Sync the repository with your PC

A GitHub repository can have a local clone on your computer. Changes pushed to GitHub do not instantly change files on your PC; you fetch and pull the remote commits into that clone.

## Clone it with GitHub Desktop

1. Install GitHub Desktop and sign in to the GitHub account that can access this public repository.
2. Choose **File → Clone Repository**.
3. Select `previouslaw/code-zero-san-andreas`.
4. Choose a local folder, for example `C:/Users/YourName/Documents/GitHub/code-zero-san-andreas`.

That folder is your connected working copy. You can open it in File Explorer or your editor.

## Pull new GitHub changes

In GitHub Desktop, choose **Fetch origin**, then **Pull origin**. The local clone updates to the latest commits from GitHub.

If you want the PC to check automatically while it is on, Windows Task Scheduler can run this Git command on a repeating schedule:

```powershell
git -C "C:/Users/YourName/Documents/GitHub/code-zero-san-andreas" pull --ff-only origin main
```

This updates the repository clone only. It does not copy files into an installed FiveM server profile or restart a live server.

## Apply updates to the FiveM server

1. Stop FXServer.
2. Pull the latest GitHub changes into your clone.
3. Run the installer from that clone, pointing it at the txAdmin profile folder containing `server.cfg` and `resources`:

   ```powershell
   .\scripts\install-codezero.ps1 -ServerDataPath "C:/FXServer/txData/CodeZero"
   ```

4. Start the server again.

Do not automatically overwrite a running server's resources. For a push-triggered deployment, a self-hosted GitHub Actions runner can run on the same PC, but it can execute workflow commands there; only enable it if you are comfortable granting that access and reviewing every workflow.
