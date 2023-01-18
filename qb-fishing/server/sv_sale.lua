local moneyType = 'cash'
local priceTable = {
    mackerel = math.random(50,80),
    grouper = math.random(50,80),
    largemouthbass = math.random(50,100),
    marlin = math.random(100,150),
    trout = math.random(50,70),
    shrimp = math.random(10,30),
    caimon = math.random(50,80),
    frog = math.random(10,30),
    carp = math.random(50,80),
    perch = math.random(30,50),
    bluegill = math.random(50,80),
    rainbowtrout = math.random(100,120),
    piranha = math.random(80,100),
    smallmouthbass = math.random(50,80),
    crawdad = math.random(20,40),
    bullfrog = math.random(20,30),
    northernpike = math.random(50,80),
    angelfish = math.random(50,80),
    angler = math.random(50,80),
    butterflyfish = math.random(50,80),
    lionfish = math.random(50,80),
    triggerfish = math.random(50,80),
    turtle = math.random(100,120),
    softshellturtle = math.random(50,100),
    eel = math.random(150,180),
    bass = math.random(40,60),
    whale = math.random(500,600),
    whale2 = math.random(500,600),
    shark = math.random(500,600),
    lemonshark = math.random(250,400),
    sandshark = math.random(250,400),
    tigershark = math.random(250,400),
    
  
}

RegisterNetEvent('qb-fishing:server:SellFish', function(fish, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(fish) ~= 'string' or type(amount) ~= 'number' then return end

    -- Distance Exploit Check
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.SellLocation.xyz) > 5.0 then
        exports['qb-core']:ExploitBan(src, 'fishing-sell-fish')
        return
    end

    local item = Player.Functions.GetItemByName(fish)
    if not item then return end
    if not priceTable[fish] then return end
    if item.amount >= amount then
        if exports['qb-inventory']:RemoveItem(Player.PlayerData.source, item.name, amount, false) then
            -- Item Box
            TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items[item.name], 'remove', amount)

            -- Wait to sync with animation
            Wait(3500)

            -- Give Cash
            Player.Functions.AddMoney(moneyType, amount * priceTable[item.name], "fishing")

            -- Log
            TriggerEvent('qb-log:server:CreateLog', 'fishing', 'Sale Fish', 'lightgreen', "**"..Player.PlayerData.name .. " (citizenid: "..Player.PlayerData.citizenid.." | id: "..Player.PlayerData.source..")** received $"..amount * priceTable[item.name].." for selling "..amount.."x "..QBCore.Shared.Items[item.name].label)

            -- Notification
            TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, 'You received $'..amount * priceTable[item.name]..' for selling your '..QBCore.Shared.Items[item.name].label, 'success', 2500)
            
        end
    end
end)

QBCore.Functions.CreateCallback('qb-fishing:server:CanSell', function(source, cb, fish, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(fish) ~= 'string' or type(amount) ~= 'number' then return end

    -- Distance Exploit Check
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.SellLocation.xyz) > 5.0 then
        exports['qb-core']:ExploitBan(src, 'fishing-can-sell')
        return
    end

    local item = Player.Functions.GetItemByName(fish)
    if not item then return end

    if item.amount >= amount then
        cb(true)
    else
        cb(false)
    end
end)
