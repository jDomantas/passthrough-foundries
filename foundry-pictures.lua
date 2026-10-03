local foundry_animation_speed = 0.16
local frames = 128

local function foundry_pipe_pictures(dir)
    return util.sprite_load("__passthrough-foundries__/graphics/foundry/foundry-pipe-connections-" .. dir,
        {
            scale = 0.5
        })
end

local pictures = {
    pipe_pictures = {},
}

local empty_sprite = {
    filename = "__passthrough-foundries__/graphics/empty.png",
    width = 10,
    height = 10,
}

pictures.pipe_pictures.center = {
    north = empty_sprite,
    east = foundry_pipe_pictures("east-center"),
    south = foundry_pipe_pictures("south-center"),
    west = empty_sprite,
}

pictures.pipe_pictures.clockwise = {
    north = empty_sprite,
    east = foundry_pipe_pictures("east-south"),
    south = foundry_pipe_pictures("south-west"),
    west = empty_sprite,
}

pictures.pipe_pictures.counter_clockwise = {
    north = foundry_pipe_pictures("north-west"),
    east = foundry_pipe_pictures("east-north"),
    south = foundry_pipe_pictures("south-east"),
    west = foundry_pipe_pictures("west-south"),
}

-- table.insert(visualisations, {
--     always_draw = true,
--     name = "molten-input-pipe",
--     enabled_by_name = true,
--     -- north_animation = foundry_pipe_north_pictures(),
--     -- north_secondary_draw_order = -10, -- behind main animation
--     east_animation = foundry_pipe_south_pictures('center'),
--     -- south_animation = foundry_pipe_south_pictures('center'),
--     -- west_animation = foundry_pipe_west_pictures()
-- })

-- table.insert(visualisations, {
--     always_draw = true,
--     name = "default-input-pipe",
--     enabled_by_name = true,
--     -- north_animation = foundry_pipe_north_pictures(),
--     -- north_secondary_draw_order = -10, -- behind main animation
--     -- east_animation = foundry_pipe_east_pictures(),
--     -- south_animation = foundry_pipe_south_pictures('center'),
--     west_animation = foundry_pipe_south_pictures('center'),
-- })

-- table.insert(visualisations, {
--     always_draw = true,
--     name = "molten-passthrough-pipe-1",
--     enabled_by_name = true,
--     north_animation = foundry_pipe_south_pictures('west'),
--     -- north_secondary_draw_order = -10, -- behind main animation
--     -- east_animation = foundry_pipe_east_pictures(),
--     -- south_animation = foundry_pipe_south_pictures('center'),
--     -- west_animation = foundry_pipe_west_pictures()
-- })

-- table.insert(visualisations, {
--     always_draw = true,
--     name = "molten-passthrough-pipe-2",
--     enabled_by_name = true,
--     -- north_animation = foundry_pipe_north_pictures(),
--     -- north_secondary_draw_order = -10, -- behind main animation
--     -- east_animation = foundry_pipe_east_pictures(),
--     south_animation = foundry_pipe_south_pictures('west'),
--     -- west_animation = foundry_pipe_west_pictures()
-- })

-- table.insert(visualisations, {
--     always_draw = true,
--     name = "molten-output-pipe-1",
--     enabled_by_name = true,
--     north_animation = foundry_pipe_south_pictures('east'),
--     -- north_secondary_draw_order = -10, -- behind main animation
--     -- east_animation = foundry_pipe_east_pictures(),
--     -- south_animation = foundry_pipe_south_pictures('center'),
--     -- west_animation = foundry_pipe_west_pictures()
-- })

-- table.insert(visualisations, {
--     always_draw = true,
--     name = "molten-output-pipe-2",
--     enabled_by_name = true,
--     -- north_animation = foundry_pipe_north_pictures(),
--     -- north_secondary_draw_order = -10, -- behind main animation
--     -- east_animation = foundry_pipe_east_pictures(),
--     -- south_animation = foundry_pipe_south_pictures('center'),
--     west_animation = foundry_pipe_south_pictures('west'),
-- })

return pictures
