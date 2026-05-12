This repo contains basically a single important file: [ui.lua](lib/ui.lua)
This file allows you to mak simple user interfaces, dispay text, icons and buttons on the screen
using a flexbox like layout system. It has

Made with (and for) the [Usagi](https://github.com/brettchalupa/usagi) engine

# Using the libraray

For the libraray to work, you only need the `lib/ui.lua` file. After obtaining it, you cna use
it like a singleton:

In the init unction, you should call the intialisaion function. Thsi is the place where you should
construct your layout (more on that later)
```lua
function _init()
	ui.init()

	ui.set_panel({
        type = "list",
        axis = "y",
        gap = 4,
        children = {
            {
                type = "label",
                text = "Hello, usagi!"
            },
            {
                type = "label",
                text = "Lorem ipsum"
            },
        }
    }, 0, -1)
end
```
To keep the UI responsive (make buttons clickable, update label texts
and handle layout size changes) you need to call `ui.update()` inside the update loop.

```lua
function _update(dt)
	ui.update()
end
```

After constructing the layout in `_init()` and calculating the positions of the ui items, the next thing is to render it in `_draw()`

```lua
function _draw(dt)
	gfx.clear(gfx.COLOR_BLACK)

	ui.render()
end
```

# Structure of the layout

There are 4 ui items available at the moment:
- `UI.Box`: This is the base of all ui items. It has a position, a size, and margins. It also has some special settings like, min and max allowed size.
- `UI.Panel`: It is a kind of container, it acts as a root item. You don't need to create these yourself, they will be automatically generated when creating a new panel
- `UI.Label`: This is an instance of the box, but it has a single line of text inside. You can set the vertical and horizontal aligmnet of the text.
- `UI.List`: This container allows you to make complex ui layouts. It has parameters for controlling the positioning of it's children, on one axis

Planned items:
- `UI.Image`: Display a sprite inside a box
- `UI.Button`: A clickable image
- `UI.Textarea`: A label, that supports displaying multiline strings

# Creating a layout

As it was shown in the starting example, you can use the builint functions to place items inside each other, or you can just supply a table directly to the `set_panel()` function

```lua
-- Creating a layout using the builtin functions

local label1 = ui.create_label("Hello, world!")
local label2 = ui.create_label("Lorem ipsum")

local list = ui.create_list("y")
list.add_child(label1)
list.add_child(label2)

ui.set_panel(list)

```
```lua
-- Creating the same layout by defining a tabe directly

ui.set_panel({
    type = "list",
    axis = "y",
    children = {
        {
            type = "label",
            text = "Hello, usagi!"
        },
        {
            type = "label",
            text = "Lorem ipsum"
        },
    }
})
```

As you can see, each item has a `type` field. This determines the type of the item. They also have a `children` field. This is waht allows you to place items inside each other.


# Item descriptions

## UI.Box
This is the base of ALL other ui items, therefore **every item has these properties**

### Fields
- `type` (**string**) The type of this element: "box"
- `x` (**number**) The X coordinate of the top-left corner of the box
- `y` (**number**) The Y coordinate of the top-left corner of the box
- `w` (**number**) The width of the box
- `h` (**number**) The height of the box
- `min_w` (**number**) The minimum allowed width of the box
- `min_h` (**number**) The minimum allowed height of the box
- `max_w` (**number**) The maximum allowed width of the box
- `max_h` (**number**) The maximum allowed height of the box
- `mx` (**number**) The outside margin of the box on the X axis
- `my` (**number**) The outside margin of the box on the Y axis
- `fix_size` (**boolean**) Toggles whenever to update the size of this item, relative to it's children
- `children` (**table**) A list containing child items

### Methods
- `add_child(item)`: It has one argument: `item`. When calling this function on a ui item, the supplied other item will be appended at the end of the original item's `children` table.

## UI.Panel
This is the base of ALL other ui items, therefore **every item has these properties**

### Fields
- `type` (**string**) The type of this element: "box"
- `x` (**number**) The X coordinate of the top-left corner of the box
- `y` (**number**) The Y coordinate of the top-left corner of the box
- `w` (**number**) The width of the box
- `h` (**number**) The height of the box
- `min_w` (**number**) The minimum allowed width of the box
- `min_h` (**number**) The minimum allowed height of the box
- `max_w` (**number**) The maximum allowed width of the box
- `max_h` (**number**) The maximum allowed height of the box
- `mx` (**number**) The outside margin of the box on the X axis
- `my` (**number**) The outside margin of the box on the Y axis
- `fix_size` (**boolean**) Toggles whenever to update the size of this item, relative to it's children
- `children` (**table**) A list containing child items

### Methods
- `add_child(item)`: It has one argument: `item`. When calling this function on a ui item, the supplied other item will be appended at the end of the original item's `children` table.









## **Documentation is WIP, but the file has decent function descriptions**