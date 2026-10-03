local pipecoverspictures = require('pipe-covers')

local recipe = table.deepcopy(data.raw["recipe"]["offshore-pump"])
recipe.name = "lava-pump"
recipe.ingredients = {
    { type = "item", name = "tungsten-carbide", amount = 3 },
    { type = "item", name = "iron-gear-wheel",  amount = 2 },
}
recipe.results = { { type = "item", name = "lava-pump", amount = 1 } }

local item = table.deepcopy(data.raw["item"]["offshore-pump"])
item.name = "lava-pump"
item.icon = "__passthrough-foundries__/graphics/lava-pump.png"
item.order = "b[fluids]-b[lava-pump]"
item.place_result = "lava-pump"

local entity = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
entity.name = "lava-pump"
entity.icon = "__passthrough-foundries__/graphics/lava-pump.png"
entity.minable.result = "lava-pump"
entity.fluid_box.pipe_connections[1].connection_category = "molten-fluid"
entity.tile_buildability_rules[2].required_tiles.layers = {lava_tile=true}

entity.fluid_box.pipe_covers = pipecoverspictures()

data:extend({ recipe, item, entity })
