---@diagnostic disable: inject-field, cast-local-type
---@diagnostic disable: return-type-mismatch

require("lib.graphics")
require("lib.misc")
local ui = require("lib.ui")

--[[
TODO:

- add panel alignment
- add item alignment in lists
- fix label text clipping

]]

function _config()
	return {
		name = "UI test",
		game_id = "com.barni-07.ui-test",
		icon = 1,

		-- game_width = 640,
		-- game_height = 360,
	}
end

-- Mouse position
local mx, my = 0, 0

function _init()
	ui.init()

	-- Construct the UI panel
	List1 = ui.create_list("y", 0)

	for i = 1, 4 do
		local l = ui.create_label(f("Test: ", i), 0, 0, f("l%d", i))
		l.w = 64
		l.h = 16
		List1.add_child(l)
	end

	Left_panel = List1

	-- Add left panel
	ui.set_panel(Left_panel, -1, -1)
	ui.update(mx, my)

	dump(ui)

	--ui.update(mx, my)
	--ui.render(true)
	--os.exit()
end

function _update(dt)
	mx, my = input.mouse()

	for i = 1, 4 do
		ui.set_hook(f("l%d", i), f("Value: %d", math.floor(usagi.elapsed*i) ))
	end

	ui.update(mx, my)
end

function _draw(dt)
	gfx.clear(gfx.COLOR_BLACK)

	ui.render(true)
end
