-- Declare an array to hold resource status data
local resourceStatusArray = {}

-- Register a network event that receives resource status data from the server
RegisterNetEvent("sendResourceStatusToClient")
AddEventHandler("sendResourceStatusToClient", function(receivedResourceStatus)
    -- Update the resource status array with the received data
    resourceStatusArray = receivedResourceStatus
end)

-- Create a new thread
Citizen.CreateThread(function()
    -- Trigger a server event to check the versions of the resources
    TriggerServerEvent("checkResourceVersions")

    Citizen.Wait(1000)

    hideUI = true

    if Config.ShowOnStart then
        hideUI = not hideUI
        -- Send a message to the HTML UI with the resource status data
        -- The data is encoded as a JSON string
        SendNUIMessage({
            type = "show_resource_status",
            resourceStatusData = json.encode(resourceStatusArray),
            hideUI = hideUI
        })
    end

    -- If the use of a command is enabled in the config
    if Config.UseCommand then
        -- Register a command that shows the resource status in the UI
        RegisterCommand(Config.Command, function()
            -- Send a message to the HTML UI with the resource status data
            -- The data is encoded as a JSON string
            hideUI = not hideUI
            SendNUIMessage({
                type = "show_resource_status",
                resourceStatusData = json.encode(resourceStatusArray),
                hideUI = hideUI
            })
        end)
    end
    
    -- If the use of a keybind is enabled in the config
    if Config.UseKeybind then
        -- Register a keybind that shows the resource status in the UI
        RegisterKeyMapping("showResourceStatus", "Show Resource Status", "keyboard", Config.Keybind)
        RegisterCommand("showResourceStatus", function()
            -- Send a message to the HTML UI with the resource status data
            -- The data is encoded as a JSON string
            hideUI = not hideUI
            SendNUIMessage({
                type = "show_resource_status",
                resourceStatusData = json.encode(resourceStatusArray),
                hideUI = hideUI
            })
        end)
    end

    -- If the use of an event is enabled in the config
    if Config.UseEvent then
        -- Register a network event that shows the resource status in the UI
        RegisterNetEvent("showResourceStatus")
        AddEventHandler("showResourceStatus", function(hideUI)
            -- Send a message to the HTML UI with the resource status data
            -- The data is encoded as a JSON string
            SendNUIMessage({
                type = "show_resource_status",
                resourceStatusData = json.encode(resourceStatusArray),
                hideUI = hideUI
            })
        end)
    end
end)