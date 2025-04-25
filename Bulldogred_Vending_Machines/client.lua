local vendingItems = {
    { name = "water", label = "Water", price = 15 },
  --  { name = "kurkakola", label = "Cola", price = 20 },
  --  { name = "sprunk", label = "Sprunk", price = 20 },
}

-- Function to open the vending machine menu
local function openVendingMenu()
    local options = {}

    for _, item in ipairs(vendingItems) do
        table.insert(options, {
            title = item.label,
            description = "Price: $" .. item.price,
            event = 'vending_machine:purchaseItem',
            args = item
        })
    end

    lib.registerContext({
        id = 'vending_machine_menu',
        title = 'Vending Machine',
        options = options
    })

    lib.showContext('vending_machine_menu')
end

-- Set up ox_target for vending machine models
local vendingMachineModels = {
    `prop_vend_soda_01`, `prop_vend_soda_02`, `prop_vend_soda_03`, `prop_vend_water_01`
}

for _, model in ipairs(vendingMachineModels) do
    exports.ox_target:addModel(model, {
        {
            name = 'vending_machine',
            icon = 'fas fa-shopping-cart',
            label = 'Use Vending Machine',
            onSelect = function()
                openVendingMenu()
            end
        }
    })
end

-- Event to trigger server-side purchase
RegisterNetEvent('vending_machine:purchaseItem', function(item)
    print("Attempting to purchase item:", item.name) -- Debug message
    TriggerServerEvent('vending_machine:handlePurchase', item)
end)
