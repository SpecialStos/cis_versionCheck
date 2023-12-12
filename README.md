# Documentation for Resource Version Check

##Preview

![versionCheck](https://github.com/SpecialStos/cis_versionCheck/assets/52541868/1963815d-5a5a-4a52-ab71-005e712821b4)

## Overview

This resource is designed to check the version of your server's resources against the versions available on their respective websites. It uses semantic versioning to compare versions and provides a status for each resource: "UP TO DATE", "OUTDATED", or "PRE-RELEASE".

## Configuration

To configure the resource, you need to modify the `Config` table in the `config.lua` file. Here's an example of what a resource entry looks like:

```lua
{
    resourceName = "es_extended",  -- The name of the resource in your server
    placeholderName = "ESX",  -- The name you want to display in the UI
    link = "https://raw.githubusercontent.com/esx-framework/es_extended/main/version"  -- The link to the resource's version file
}
```

You can add as many resource entries as you need. Each entry should be a table with the following fields:

- `resourceName`: The name of the resource as it appears in your server's resource directory. This is case-sensitive.
- `placeholderName`: The name you want to display in the UI for this resource. This can be anything you like.
- `link`: The URL to a plain text file that contains the current version of the resource. This is typically hosted on the resource's GitHub repository.

## How It Works

When the resource starts, it loops through each entry in the `Config` table. For each entry, it fetches the current version of the resource from the provided URL and compares it with the version installed on your server.

The comparison is done using semantic versioning. This means that versions are compared part by part, from left to right. For example, version "1.2.3" is greater than version "1.2.2", but less than "1.3.0".

The result of the comparison is one of three statuses:

- "UP TO DATE": The server's version is the same as the website's version.
- "OUTDATED": The server's version is less than the website's version.
- "PRE-RELEASE": The server's version is greater than the website's version.

The status for each resource is then sent to the UI, which displays it in a list. The UI can be hidden or shown using the `hideUI` property in the `SendNUIMessage` function.

## Troubleshooting

If a resource's status is "OUTDATED" but you believe it should be "UP TO DATE", check the following:

- Make sure the `resourceName` in the `Config` table matches the name of the resource in your server's resource directory exactly.
- Check the URL in the `link` field. It should point to a plain text file that contains the current version of the resource. You can test this by opening the URL in a web browser.
- If the resource's version file on the website is not a plain text file, or if it contains additional text besides the version, the resource will always appear as "OUTDATED". Contact the resource's author for help in this case.
