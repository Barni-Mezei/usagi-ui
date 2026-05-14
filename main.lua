---@diagnostic disable: inject-field, cast-local-type
---@diagnostic disable: return-type-mismatch

require("lib.graphics")
require("lib.misc")
local ui = require("lib.ui")

function _config()
	return {
		name = "Simple UI lib",
		game_id = "com.barni-07.ui-lib",
	}
end

-- Mouse position
local mx, my = 0, 0

function _init()
	ui.init()

	-- Construct the UI panel
	List1 = ui.create_list("y", 4)
	List1.fix_size = true
	List1.w = 128
	List1.mx = 16
	List1.my = 16

	for i = 1, 4 do
		local lst = ui.create_list("x", 8)
		lst.fix_size = true
		lst.w = 100
		lst.h = 20

		local l = ui.create_label("", -1, 0, f("l%d", i))
		l.w = 64
		l.h = 16
		lst.add_child(l)

		local b = ui.create_box(0, 0, 16, 16)
		lst.add_child(b)
		List1.add_child(lst)
	end

	Left_panel = List1

	-- Add left panel
	ui.add_panel(Left_panel, -1, -1)
	ui.update(mx, my)

	--dump(List1)
	--os.exit()
end

function _update(dt)
	mx, my = input.mouse()

	--List1.gap = math.floor(usagi.elapsed * 2) % 10

	for i = 1, 4 do
		ui.set_hook(f("l%d", i), f("Value: %d", math.floor(usagi.elapsed*100/i) % 900 ))
	end

	ui.update(mx, my)
end

function _draw(dt)
	gfx.clear(gfx.COLOR_BLACK)

	ui.render(true)
end
