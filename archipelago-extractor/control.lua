-- These are the keys that we care about exporting from each type.
-- See: https://lua-api.factorio.com/latest/index-runtime.html
local userdata_keys = {
    LuaPrototypes = {
        -- stuff
        "entity",
        "item",
        "fluid",
        "tile",
        -- making things
        "technology",
        "recipe",
        -- places
        "space_location",
        "space_connection",
    },

    LuaTechnologyPrototype = {
        "enabled", -- always true
        "upgrade",
        "research_unit_ingredients",
        "effects",
        "research_unit_count",
        "research_unit_energy",
        "level",
        "max_level",
        "research_unit_count_formula",
        "research_trigger",
        -- "allows_productivity", -- always true
        "*prerequisites",
    },
    LuaRecipePrototype = {
        "enabled", -- true for starter recipes and many hidden recipes, such as assembling-machine-1-recycling
        "unlock_results", -- usually true. false for unbarreling and non-scrap recycling.
        "hidden_from_player_crafting", -- true for non-scrap recycling, barreling/unbarreling, and fixed_recipe recipes (e.g. rocket-part)
        "category", -- matched against a crafting machine's .crafting_categories
        "additional_categories",
        "hidden_from_flow_stats",
        "energy",
        "group",
        "subgroup",
        "request_paste_multiplier", -- e.g. 1, 10, or 30
        -- "overload_multiplier", -- always 0
        -- "maximum_productivity", -- always 3
        -- "allowed_module_categories", -- always omitted
        -- "result_is_always_fresh", -- always false
        -- "trash", -- always empty
        "preserve_products_in_machine_output", -- true only for biter eggs from bioflux
        "surface_conditions",
        "allowed_effects", -- the .productivity and .quality properties are interesting
        "reset_freshness_on_craft", -- true for some breeding recipes
        "ingredients",
        "products",
    },

    LuaEntityPrototype = {
        -- resources, buildings, ...
        "mineable_properties",
        "items_to_place_this", -- if non-empty, always "count":1, except for curved rail entities
        "flags",

        -- resources
        "resource_category", -- it is this category.
        "minimum_resource_amount",
        "normal_resource_amount",
        "infinite_resource",
        "infinite_depletion_resource_amount",
        "autoplace_specification", -- used by world gen
        "loot", -- only used by egg rafts to drop pentapog eggs

        -- buildings in general
        "is_building",
        "energy_usage",
        "surface_conditions",
        "effect_receiver", -- e.g. .effect_receiver.base_effect.productivty is 0.5 for foundry and such.
        "burner_prototype",
        "electric_energy_source_prototype",
        "heat_energy_source_prototype",
        "fluid_energy_source_prototype",
        "void_energy_source_prototype", -- used by powerless entities that perhaps could be powered, such as offshore pump and spidertron.
        "heat_buffer_prototype",
        "heating_energy", -- 0 means never freezes.
        "tile_buildability_rules", -- "dangle" rules: offshore-pump, asteroid-collector, thruster, rail-ramp.

        -- crafting machines (assembling machine, foundry, silo, etc.)
        "crafting_categories", -- matched against a recipe's .category
        "fixed_recipe", -- "biter-egg" for captive biter spawner and "rocket-part" for rocket silo.
        "module_inventory_size",
        --"quality_affects_module_slots", -- always false
        "ingredient_count", -- 1 for furnaces, 65535 for all other crafting machines.
        "max_item_product_count", -- 1 for furnaces, 12 for recycler, 65535 for all other crafting machines.

        -- labs
        "lab_inputs", -- all 12 science packs for both labs.
        "science_pack_drain_rate_percent", -- 100 for lab, 50 for biolab.

        -- miners (burner, electric, big, pumpjack)
        "resource_categories", -- it mines these categories.
        "mining_drill_radius",
        --"quality_affects_mining_radius", -- always false
        "mining_speed",
        "resource_drain_rate_percent",
        "uses_force_mining_productivity_bonus",

        -- agricultural tower (which is *not* a miner)
        "agricultural_tower_radius", -- 3 for agricultural-tower
        --"accepted_seeds", -- always empty

        -- power generators and vehicles
        "effectivity",
        "consumption", -- vehicles only
        "grid_prototype", -- equipment grid
        "perceived_performance", -- used by fusion-reactor

        -- solar panel
        "solar_panel_performance_at_day", -- 1
        "solar_panel_performance_at_night", -- 0

        -- thruster
        "min_performance",
        "max_performance",

        -- other
        "time_to_live", -- used by corpses/remnants that despawn over time. (not related to spoilage.) 
        "cliff_explosive_prototype", -- "cliff-explosives" for the 4 types of cliffs.
        "*indexed_guns",
    },
    LuaBurnerPrototype = {
        "fuel_inventory_size", -- 3 for locomotive, 2 for heating tower, 1 otherwise
        "burnt_inventory_size", -- 1 for nuclear reactor, 2 for heating tower
        "fuel_categories", -- matched against an item's .fuel_category
    },

    LuaItemPrototype = {
        "flags",
        "stack_size",
        "fuel_category", -- matched against a entity's .burner_prototype.fuel_categories
        "*place_result",
        "*place_as_equipment_result",
        "*place_as_tile_result",
        "*spoil_result",
        "*plant_result",
        "*burnt_result",

        "equipment_grid",
        "provides_flight", -- true only for mech armor
        "ammo_category", -- if this is ammo, what kind is it?
        -- TODO: how can we connect rocket-launcher to captive-biter-spawner?

        -- rocket logistics info
        "weight",
        "ingredient_to_weight_coefficient",
        "*default_import_location", -- usually nauvis.
        "send_to_orbit_mode", -- only "manual" for raw fish (to trigger a legacy achievement). "not-sendable" otherwise.
        "moved_to_hub_when_building", -- if false, deconstructing a belt of this item in space deletes the items.

        -- blueprint-book
        --"inventory_size", -- 65535 for blueprint book
        --"*item_filters",
        --"item_group_filters",
        --"item_subgroup_filters",
        --"filter_mode",

        -- modules
        "module_effects",
        "category",
        "tier",
        "requires_beacon_alt_mode", -- meaning this module is not allowed in a beacon: productivity and quality modules.

        "infinite", -- false for repair packs and science packs.

        -- space platform starter pack
        --"trigger", -- only used in space platform starter pack
        --"surface",
        "create_electric_network", -- true only for space platform starter pack
        "*tiles", -- builds space platform foundations around the hub.
        "initial_items", -- stocks 10 space platform foundations in the hub.

        --"rocket_launch_products", -- always empty
        --"spoil_to_trigger_result", -- eggs spoiling into enemies. omit large data that probably doesn't matter here.
        --"destroyed_by_dropping_trigger", -- always empty
    },

    LuaTilePrototype = {
        "autoplace_specification",
        "mineable_properties",
        "*fluid",
        "*items_to_place_this",
        "is_foundation",
        "allows_being_covered",
        "destroys_dropped_items", -- probably just lava, right?
    },

    LuaSpaceLocationPrototype = {
        "solar_power_in_space",
        "asteroid_spawn_influence",
        "asteroid_spawn_definitions",
        "map_gen_settings",
        "entities_require_heating",
        "pollutant_type",
        "surface_properties",
    },
    LuaSpaceConnectionPrototype = {
        "*from",
        "*to",
        "length",
        "asteroid_spawn_definitions",
    },

    -- Just the name is useful.
    LuaGroup = {"name"},
    LuaAmmoCategoryPrototype = {"name"},
    LuaAirbornePollutantPrototype = {"name"},

    -- no interesting properties for these:
    LuaElectricEnergySourcePrototype = {},
    LuaHeatEnergySourcePrototype = {},
    LuaHeatBufferPrototype = {},
    LuaVoidEnergySourcePrototype = {},
    LuaEquipmentGridPrototype = {},
    LuaFluidPrototype = {},
}

local reported_missing_already = {}

function to_json_compatible(x, only_reference)
    local t = type(x)
    if t == "number" or t == "string" or t == "boolean" or t == "nil" then
        return x
    end

    -- userdata is a host-provided type that Lua cannot do reflection on,
    -- but the Factorio provides various means for us that we must use correctly.
    if t == "userdata" then
        t = x.object_name
        if t == "LuaCustomTable" then
            -- This is an optimized type that acts like a Lua table for our purposes.
            t = "table"
        end
    end

    if t == "table" then
        local r = {}
        for k, v in pairs(x) do
            r[k] = to_json_compatible(v, only_reference)
        end
        return r
    end

    local keys = nil
    if only_reference then
        -- pointer
        keys = {
            "object_name",
            "name",
        }
    else
        keys = userdata_keys[t]
        if keys == nil then
            if reported_missing_already[t] == nil then
                log("need handler for: " .. t)
                reported_missing_already[t] = true
            end
            return "<<<<TODO: " .. t .. ">>>>"
        end
    end

    local r = {}
    for _, k in pairs(keys) do
        if string.sub(k, 1, 1) == "*" then
            -- Do not recursively embed the entire object; just give enough information to be a pointer.
            k = string.sub(k, 2)
            r[k] = to_json_compatible(x[k], true)
        else
            r[k] = to_json_compatible(x[k], only_reference)
        end
    end
    return r
end

commands.add_command("ap-get-info-dump", "Dump Game Info, used by Archipelago.", function(call)
    local data_collection = to_json_compatible(prototypes, false)
    helpers.write_file("ap-dump.json", helpers.table_to_json(data_collection), false)
    game.print("Exported All Data")
    log("Exported All Data")
end)
