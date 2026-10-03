local pipecoverspictures = require("pipe-covers")

local foundry = data.raw["assembling-machine"]["foundry"]
-- for _, fb in ipairs(foundry.fluid_boxes) do
-- 	fb.pipe_connections[1].flow_direction = "input-output"
-- end

-- local extra_input_1 = table.deepcopy(foundry.fluid_boxes[1])
-- extra_input_1.enable_working_visualisations = { "input-pipe-2" }
-- extra_input_1.pipe_connections[1].position = {2, -1}
-- extra_input_1.pipe_connections[1].direction = defines.direction.east
-- table.insert(foundry.fluid_boxes, extra_input_1)
-- local extra_input_2 = table.deepcopy(foundry.fluid_boxes[1])
-- extra_input_2.enable_working_visualisations = { "input-pipe-2" }
-- extra_input_2.pipe_connections[1].position = {2, 1}
-- extra_input_2.pipe_connections[1].direction = defines.direction.east
-- table.insert(foundry.fluid_boxes, extra_input_2)

-- local extra_output_1 = table.deepcopy(foundry.fluid_boxes[3])
-- extra_output_1.enable_working_visualisations = { "output-pipe-2" }
-- extra_output_1.pipe_connections[1].position = {-2, -1}
-- extra_output_1.pipe_connections[1].direction = defines.direction.west
-- table.insert(foundry.fluid_boxes, extra_output_1)
-- local extra_output_2 = table.deepcopy(foundry.fluid_boxes[3])
-- extra_output_2.enable_working_visualisations = { "output-pipe-2" }
-- extra_output_2.pipe_connections[1].position = {-2, 1}
-- extra_output_2.pipe_connections[1].direction = defines.direction.west
-- table.insert(foundry.fluid_boxes, extra_output_2)

-- local input_pipe_2_graphics = table.deepcopy(foundry.graphics_set.working_visualisations[2])
-- input_pipe_2_graphics.name = "input-pipe-2"
-- local rotate = input_pipe_2_graphics.north_animation
-- input_pipe_2_graphics.north_animation = input_pipe_2_graphics.west_animation
-- input_pipe_2_graphics.west_animation = input_pipe_2_graphics.south_animation
-- input_pipe_2_graphics.south_animation = input_pipe_2_graphics.east_animation
-- input_pipe_2_graphics.east_animation = rotate
-- input_pipe_2_graphics.west_secondary_draw_order = input_pipe_2_graphics.south_secondary_draw_order
-- input_pipe_2_graphics.south_secondary_draw_order = nil
-- table.insert(foundry.graphics_set.working_visualisations, 3, input_pipe_2_graphics)

-- local output_pipe_2_graphics = table.deepcopy(foundry.graphics_set.working_visualisations[1])
-- output_pipe_2_graphics.name = "output-pipe-2"
-- local rotate = output_pipe_2_graphics.north_animation
-- output_pipe_2_graphics.north_animation = output_pipe_2_graphics.west_animation
-- output_pipe_2_graphics.west_animation = output_pipe_2_graphics.south_animation
-- output_pipe_2_graphics.south_animation = output_pipe_2_graphics.east_animation
-- output_pipe_2_graphics.east_animation = rotate
-- output_pipe_2_graphics.east_secondary_draw_order = output_pipe_2_graphics.north_secondary_draw_order
-- output_pipe_2_graphics.north_secondary_draw_order = nil
-- table.insert(foundry.graphics_set.working_visualisations, 2, output_pipe_2_graphics)

table.insert(data.raw["technology"]["foundry"].effects, 2, {
	type = "unlock-recipe",
	recipe = "lava-pump",
})

local north = defines.direction.north
local east = defines.direction.east
local west = defines.direction.west
local south = defines.direction.south

local foundry_pipe_pictures = require('foundry-pictures').pipe_pictures

local input_positions = {
	{-2, 0, west, "input", "default", foundry_pipe_pictures.center, foundry_pipe_pictures.center},
	{2, 0, east, "input", "molten-fluid", foundry_pipe_pictures.center, foundry_pipe_pictures.center},
	{-1, 2, south, "output", "molten-fluid", foundry_pipe_pictures.clockwise, foundry_pipe_pictures.counter_clockwise},
	{1, -2, north, "output", "molten-fluid", foundry_pipe_pictures.clockwise, foundry_pipe_pictures.counter_clockwise},
}
local output_positions = {
	{1, 2, south, foundry_pipe_pictures.counter_clockwise, foundry_pipe_pictures.clockwise},
	{-2, -1, west, foundry_pipe_pictures.clockwise, foundry_pipe_pictures.counter_clockwise},
	-- {2, -1, east},
}

-- for _, visualisation in pairs(require('foundry-pictures')) do
-- 	table.insert(foundry.graphics_set.working_visualisations, visualisation)
-- end

local original = foundry.fluid_boxes[1]

local function pipe_covers(filter) 
	if filter == 'molten-fluid' then
		return pipecoverspictures()
	end
	return original.pipe_covers
end

local new_boxes = {}
for _, pos in ipairs(input_positions) do
	local box = {
		production_type = "input",
		pipe_covers = pipe_covers(pos[5]),
		always_draw_covers = false,
		volume = 500,
		pipe_picture = pos[6],
		mirrored_pipe_picture = pos[7],
		pipe_connections = {{
			flow_direction = pos[4],
			direction = pos[3],
			position = {pos[1], pos[2]},
			connection_category = pos[5],
		}},
	}
	table.insert(new_boxes, box)
end
for _, pos in ipairs(output_positions) do
	local box = {
		production_type = "output",
		pipe_covers = pipe_covers('molten-fluid'),
		always_draw_covers = false,
		volume = 100,
		pipe_picture = pos[4],
		mirrored_pipe_picture = pos[5],
		pipe_connections = {{
			flow_direction = "input-output",
			direction = pos[3],
			position = {pos[1], pos[2]},
			connection_category = "molten-fluid",
		}},
	}
	table.insert(new_boxes, box)
end

foundry.fluid_boxes = new_boxes


local offshore_pump = data.raw["offshore-pump"]["offshore-pump"]
offshore_pump.tile_buildability_rules[2].colliding_tiles.layers = {lava_tile=true}

local function can_craft(machine, recipe) 
	for _, machine_cat in ipairs(machine.crafting_categories) do
		local recipe_cats = {"crafting"}
		if recipe.categories then
			recipe_cats = recipe.categories
		end
		for _, recipe_cat in ipairs(recipe_cats) do
			if machine_cat == recipe_cat then
				return true
			end
		end
	end
	return false
end

local function is_molten_fluid(id)
	return id == "lava" or id == "molten-iron" or id == "molten-copper"
end

data.raw["recipe"]["casting-low-density-structure"].ingredients[1] = {type = "item", name = "steel-plate", amount = 2}

for _, recipe in pairs(data.raw['recipe']) do
	if can_craft(foundry, recipe) then
		local molten_fluid_ingredients = 0
		local regular_fluid_ingredients = 0
		for _, ingredient in ipairs(recipe.ingredients) do
			if ingredient.type == "fluid" then
				if is_molten_fluid(ingredient.name) then
					molten_fluid_ingredients = molten_fluid_ingredients + 1
				else
					regular_fluid_ingredients = regular_fluid_ingredients + 1
				end
			end
		end
		if molten_fluid_ingredients > 1 then
			error("passthrough-foundries unsupported foundry recipe: more than 1 molten fluid ingredient: " .. recipe.name)
		end
		if regular_fluid_ingredients > 1 then
			error("passthrough-foundries unsupported foundry recipe: more than 1 regular fluid ingredient: " .. recipe.name)
		end
		for _, ingredient in ipairs(recipe.ingredients) do
			if ingredient.type == "fluid" then
				if is_molten_fluid(ingredient.name) then
					ingredient.fluidbox_index = 2
					ingredient.optional_fluidbox_indexes = {3, 4}
				else
					ingredient.fluidbox_index = 1
				end
			end
		end
	end
end
