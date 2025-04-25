local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('vending_machine:handlePurchase', function(item)
    local src = source
    print("Server: Received purchase request for", item.name, "from player ID", src) -- Confirmation debug message

    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then
        print("Server: Failed to get player object for", src)
        return
    end

    local playerMoney = exports.ox_inventory:Search(src, 'count', 'money')
    print("Player money count:", playerMoney) -- Debug message

    if playerMoney >= item.price then
        local moneyRemoved = exports.ox_inventory:RemoveItem(src, 'money', item.price)
        
        if moneyRemoved then
            local itemAdded = exports.ox_inventory:AddItem(src, item.name, 1)
            
            if itemAdded then
                TriggerClientEvent('QBCore:Notify', src, "You purchased " .. item.label, "success")
                print("Purchase successful - Gave item:", item.name)
            else
                print("Failed to add item:", item.name)
                TriggerClientEvent('QBCore:Notify', src, "Failed to add item.", "error")
            end
        else
            print("Error removing money for player:", src)
            TriggerClientEvent('QBCore:Notify', src, "Error removing money", "error")
        end
    else
        print("Not enough money - Player has:", playerMoney, "and item price is:", item.price)
        TriggerClientEvent('QBCore:Notify', src, "Not enough money", "error")
    end
end)
