-- Function to compare semantic versions
function compareVersions(version1, version2)
    -- If the versions are equal, return "UP TO DATE"
    if version1 == version2 then
        return "UP TO DATE"
    else
        -- Split the first version string into parts
        local v1 = {}
        for match in version1:gmatch("%d+[^%.]*") do
            table.insert(v1, match)
        end

        -- Split the second version string into parts
        local v2 = {}
        for match in version2:gmatch("%d+[^%.]*") do
            table.insert(v2, match)
        end

        -- Determine the maximum length between the two version arrays
        local maxLength = math.max(#v1, #v2)

        -- Compare each part of the version strings
        for i = 1, maxLength do
            local num1 = tonumber(v1[i]) or 0
            local num2 = tonumber(v2[i]) or 0

            -- If the part from the first version is greater, return "PRE-RELEASE"
            if num1 > num2 then
                return "PRE-RELEASE"
            -- If the part from the second version is greater, return "OUTDATED"
            elseif num1 < num2 then
                return "OUTDATED"
            end
        end

        -- If all parts are equal, return "UP TO DATE"
        return "UP TO DATE"
    end
end

-- Declare a table to hold resource status data
local resourceStatus = {}

-- Function to perform HTTP request to fetch version from the website
function fetchWebsiteVersion(resourceName, versionFromWebsite, websiteLink)
    -- Perform an HTTP request to the provided website link
    PerformHttpRequest(websiteLink, function(errorCode, resultData, resultHeaders)
        -- If the request was successful
        if errorCode == 200 then
            -- Convert the result data to a string and compare it with the local version
            local websiteVersion = tostring(resultData)
            local comparisonResult = compareVersions(versionFromWebsite, websiteVersion)
            -- Update the status of the resource in the resourceStatus table
            resourceStatus[resourceName] = {
                name = resourceName,
                status = comparisonResult,
                color = comparisonResult == "UP TO DATE" and "green" or
                        (comparisonResult == "PRE-RELEASE" and "lightblue" or "red"),
                version = versionFromWebsite  -- Update to display local version
            }
        else
            -- If the request was not successful, mark the resource as "OUTDATED"
            resourceStatus[resourceName] = {
                name = resourceName,
                status = "OUTDATED",
                color = "red",
                version = "Unknown"
            }
        end
    end)
end

-- Perform version comparison when the server starts
AddEventHandler("onResourceStart", function(resourceName)
    -- If the current resource is the one that started
    if GetCurrentResourceName() == resourceName then
        local resourceData = Config.resourceData

        -- Loop through each resource in the resourceData table
        for _, data in ipairs(resourceData) do
            -- Get the current version of the resource
            local currentVersion = GetResourceMetadata(data.resourceName, "version")
            -- If the version exists, fetch the website version and compare it with the local version
            if currentVersion then
                fetchWebsiteVersion(data.placeholderName, currentVersion, data.link)
            else
                -- If the version does not exist, mark the resource as "OUTDATED"
                print(data.placeholderName)
                resourceStatus[data.resourceName] = {
                    placeholderName = data.placeholderName, -- Update placeholderName field
                    status = "OUTDATED",
                    color = "red",
                    version = "Unknown"
                }
            end
        end
    end
end)

-- Register a server event that checks the versions of the resources
RegisterServerEvent("checkResourceVersions")
AddEventHandler("checkResourceVersions", function()
    -- Trigger a client event that sends the resource status data to the client
    TriggerClientEvent("sendResourceStatusToClient", source, resourceStatus)
end)

-- Register an event that is triggered when a player drops
AddEventHandler("playerDropped", function()
    -- Handle any necessary cleanup if needed
end)