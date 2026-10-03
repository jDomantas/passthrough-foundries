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

return pictures
