QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-fishing:server:RemoveBait', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if exports['qb-inventory']:RemoveItem(Player.PlayerData.source, 'fishingbait', 1, false) then
        TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items['fishingbait'], 'remove', 1)
    end
end)

RegisterNetEvent('qb-fishing:server:ReceiveFish', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local random = math.random(100) -- Random number from 1 to 100
    local item

    if random >= 1 and random <= 4 then -- 30%
        item = 'mackerel'
    elseif random >= 4 and random <= 7 then -- 7%
        item = 'grouper'
    elseif random >= 7 and random <= 10 then -- 7%
        item = 'largemouthbass'
    elseif random >= 10 and random <= 13 then -- 7%
        item = 'marlin'
    elseif random >= 13 and random <= 16 then -- 7%
        item = 'trout'
    elseif random >= 16 and random <= 19 then -- 7%
        item = 'shrimp'
    elseif random >= 19 and random <= 22 then -- 7%
        item = 'caimon'
    elseif random >= 22 and random <= 25 then -- 7%
        item = 'frog'
    elseif random >= 25 and random <= 28 then -- 7%
        item = 'carp'
    elseif random >= 28 and random <= 31 then -- 7%
        item = 'catfish'
    elseif random >= 31 and random <= 34 then -- 7%
        item = 'perch'
    elseif random >= 34 and random <= 37 then -- 7%
        item = 'bluegill'
    elseif random >= 37 and random <= 40 then -- 7%
        item = 'rainbowtrout'
    elseif random >= 40 and random <= 43 then -- 7%
        item = 'piranha'
    elseif random >= 43 and random <= 46 then -- 7%
        item = 'smallmouthbass'
    elseif random >= 46 and random <= 49 then -- 7%
        item = 'crawdad'
    elseif random >= 49 and random <= 52 then -- 7%
        item = 'bullfrog'
    elseif random >= 52 and random <= 55 then -- 7%
        item = 'northernpike'
    elseif random >= 55 and random <= 58 then -- 7%
        item = 'angelfish'
    elseif random >= 58 and random <= 61 then -- 7%
        item = 'angler'
    elseif random >= 61 and random <= 64 then -- 7%
        item = 'butterflyfish'
    elseif random >= 64 and random <= 67 then -- 7%
        item = 'lionfish'
    elseif random >= 67 and random <= 70 then -- 7%
        item = 'triggerfish'
    elseif random >= 70 and random <= 73 then -- 7%
        item = 'turtle'
    elseif random >= 73 and random <= 76 then -- 7%
        item = 'softshellturtle'
    elseif random >= 76 and random <= 79 then -- 7%
        item = 'eel'
    elseif random >= 79 and random <= 94 then -- 7%
        item = 'bass'

        -- exotic
    elseif random >= 94 and random <= 95 then -- 1%
        item = 'whale'
    elseif random >= 95 and random <= 96 then -- 1%
        item = 'whale2'

   
    elseif random >= 96 and random <= 97 then -- 7%
        item = 'shark'
    elseif random >= 97 and random <= 98 then -- 7%
        item = 'lemonshark'
    elseif random >= 98 and random <= 99 then -- 7%
        item = 'sandshark'
    elseif random >= 99 and random <= 100 then -- 7%
        item = 'tigershark'
   
    
    end

    if exports['qb-inventory']:AddItem(Player.PlayerData.source, item, 1, false) then
        TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items[item], 'add', 1)
        TriggerEvent('qb-log:server:CreateLog', 'fishing', 'Received Fish', 'blue', "**"..Player.PlayerData.name .. " (citizenid: "..Player.PlayerData.citizenid.." | id: "..Player.PlayerData.source..")** received 1x "..QBCore.Shared.Items[item].label)
    else
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, 'Your inventory is full already..', 'error', 2500)
    end
end)

QBCore.Functions.CreateUseableItem('fishingrod', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not Player.Functions.GetItemByName('fishingrod') then return end
    TriggerClientEvent('qb-fishing:client:FishingRod', src)
end)
