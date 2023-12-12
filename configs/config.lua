Config = {}

--If you wanna use this resource for version checking, put resource name correctly or you are doomed. Then have a link as a text file with the latest version, update that one.

Config.ShowOnStart =  true -- If you want to show the UI on resource start.
Config.UseCommand = true -- If you want to use command to show the UI, set this to true
Config.Command = "versionCheck" -- Command to show the UI
Config.UseKeybind = false -- If you want to use keybind to show the UI, set this to true
Config.Keybind = "F5" -- Keybind to show the UI
Config.UseEvent = true -- If you want to use event to show the UI, set this to true

Config.resourceData = {
    {
        resourceName = "pacificBankRobbery",
        placeholderName = "Pacific Bank Robbery",
        link = "https://specialstos.github.io/versionCheck/PacificBankRobbery.txt"
    },
    {
        resourceName = "realisticVehicleSystem",
        placeholderName = "TCVS",
        link = "https://specialstos.github.io/versionCheck/TCVS.txt"
    },
    {
        resourceName = "surveillanceSystem",
        placeholderName = "Surveillance System",
        link = "https://specialstos.github.io/versionCheck/SurveillanceSystem.txt"
    },
    {
        resourceName = "BetterFight",
        placeholderName = "BetterFight",
        link = "https://specialstos.github.io/versionCheck/BetterFight.txt"
    },
    {
        resourceName = "paletoBankRobbery",
        placeholderName = "Paleto Bank Robbery",
        link = "https://specialstos.github.io/versionCheck/PaletoBankRobbery.txt"
    },
    -- Add other resource information here
}
