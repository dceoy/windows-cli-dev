windows-cli-dev
===============

Configuration Files for CLI of Windows

Installation
------------

1.  Install packages.

    ```PowerShell
    winget upgrade --all
    winget install -e --id Microsoft.WindowsTerminal
    winget install -e --id Microsoft.PowerShell
    winget install -e --id Microsoft.VisualStudioCode
    winget install -e --id Microsoft.PowerToys --scope user
    winget install -e --id Python.Launcher
    winget install -e --id Google.Chrome
    winget install -e --id Google.ChromeRemoteDesktop
    winget install -e --id JohnMacFarlane.Pandoc
    winget install -e --id Anaconda.Anaconda3 --scope user
    winget install -e --id tailscale.tailscale
    winget install -e --id Amazon.AWSCLI
    winget install -e --id Amazon.SessionManagerPlugin
    winget install -e --id Cloudflare.cloudflared
    winget install -e --id Google.CloudSDK
    winget install -e --id Datadog.Agent
    winget install -e --id RealVNC.VNCViewer
    ```

2.  Copy [Git for Windows SDK](https://github.com/git-for-windows/build-extra).
