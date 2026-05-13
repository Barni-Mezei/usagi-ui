This repo contains basically a single important file: [ui.lua](lib/ui.lua)
This file allows you to mak simple user interfaces, dispay text, icons and buttons on the screen
using a flexbox like layout system. It has

Made with (and for) the [Usagi](https://github.com/brettchalupa/usagi) engine

## **IMPORTANT**
This documentation might be lacking some information about the functions and methods in the library. If you can't find something, take a look at the function in the `ui.lua` file, because that has all of it's functions documented.

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
- `UI.Label`: This is an instance of the box, but it has some text inside. You can set the vertical and horizontal aligmnet of the text.
- `UI.List`: This container allows you to make complex ui layouts. It has parameters for controlling the positioning of it's children, on one axis

Planned items:
- `UI.Image`: Display a sprite inside a box
- `UI.Button`: A clickable image

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
- `x` (**number**) The X coordinate of the top-left corner of this item
- `y` (**number**) The Y coordinate of the top-left corner of this item
- `w` (**number**) The width of this item
- `h` (**number**) The height of this item
- `min_w` (**number**) The **minimum** allowed width of this item
- `min_h` (**number**) The **minimum** allowed height of this item
- `max_w` (**number**) The **maximum** allowed width of this item
- `max_h` (**number**) The **maximum** allowed height of this item
- `mx` (**number**) The outside margin of this item on the X axis (So the total width of this item is: `w + mx*2`)
- `my` (**number**) The outside margin of this item on the Y axis (So the total height of this item is: `h + my*2`)
- `fix_size` (**boolean**) If set to true, then the size of this item will not be autmatically decided, rather it will stay the same as it was created with.
- `children` (**table**) A table, containing all child items

### Methods
- `add_child(item)`: When calling this function on a ui item, the supplied other item will be appended at the end of the original item's `children` table.



## UI.Panel
This is a special kind of box, that is a direct "child" of the hidden screen box (a box which covers the whole screen). This allows you to have multiple, separate uis in your game

### Fields

Same as for `UI.Box`, but it has it's type field set to "panel"



## UI.Label

This is aessentially is just a box, with a single line of text in it. The position of the textcan be modified (centered, left aligned, top aligned,  etc.)

### Fields

Everything from `UI.Box` and some more:

- `text` (**string**) The text to display inside
- `value_hook` (**string**)  A reference to an entry in the `value_hooks` table. Modifying that table, the text in the lael will be updated to the new value
- `h_align` (**integer**) The horizontal alignment of the text inside the box (-1: left, 0: center, 1: right)
- `v_align` (**integer**) The vertical alignment of the text inside the box   (-1: top,  0: center, 1: bottom)



## UI.List

This item allows you to arrange it's children in a line, either horizontally or vertically. You can also specify the `gap` to leave between the elements

### Fields

Everything from `UI.Box` and some more:

- `axis` (**string**) The axis to align items along (can be "x" or "y")
- `gap` (**number**) The gap between the items in this list
- `h_align` (**integer**) The horizontal alignment of the items inside the box (-1: left, 0: center, 1: right)
- `v_align`(**integer**) The vertical alignment of the items inside the box (-1: top,  0: center, 1: bottom)



# Modul methods

## `create_box()`

### Arguments
- `x` (**number**): The X coordinate of the box
- `y` (**number**): The Y coordinate of the box
- `w` (**number**): The width of the box
- `h` (**number**): The height of the box
- `mx` (**number**): The margin of the box on the X axis
- `my` (**number**): The margin of the box on the Y axis

If only one argument (a table) is passed to it, then the function will return the same box, with all of it's missing fields filled in

### Returns
- `UI.Box`: A newly created box, which has ALL of it's fields filled in

### Example

```lua
-- Creates a box which is located at 0;0 and
-- has a size of 16px by 32px
local box = ui.create_box(0, 0, 16, 32)
```



## `create_label()`

### Arguments
- `text` (**string**): The text to display in the middle of this label.
- `h_align` (**integer**): The horizontal alignment of the text inside the label's box (-1: left, 0: center, 1: right)
- `v_align` (**integer**): The vertical alignment of the text inside the label's box (-1: top, 0: center, 1: bottom)
- `value_hook` (**string**): This acts as an ID which you can refer to the contents of this label to. Use the `set_hook()` function to update the text in this label.

If only one argument (a table) is passed to it, then the function will return the same label, with all of it's missing fields filled in

### Returns
- `UI.Label`: A newly created label, which has ALL of it's fields filled in

### Example

```lua
-- Creates a label with the text: "Hello, world!" and a coresponding value
-- hook, with the id: "label_1"
local label = ui.create_label("Hello, world!", -1, -1, "label_1")

-- Updates the text in the label to "New text"
ui.set_hook("label_1", "New text")
```



## `create_list()`

### Arguments
- `axis` (**string**): The axis on which to align the children of this element
- `gap` (**number**): The gap to leave between the items
- `h_align` (**integer**): The horizontal alignment of the items in the list (-1: left, 0: center, 1: right)
- `v_align` (**integer**): The vertical alignment of the items in the list (-1: top, 0: center, 1: bottom)

If only one argument (a table) is passed to it, then the function will return the same list, with all of it's missing fields filled in

### Returns
- `UI.List`: A newly created list, which has ALL of it's fields filled in

### Example

```lua
-- Creates a list, which aligns it's children in
-- a horizontal line, with an 8px gap in between them
local list = ui.create_list("x", 8)
```



## `create_list()`

### Arguments
- `axis` (**string**): The axis on which to align the children of this element
- `gap` (**number**): The gap to leave between the items
- `h_align` (**integer**): The horizontal alignment of the items in the list (-1: left, 0: center, 1: right)
- `v_align` (**integer**): The vertical alignment of the items in the list (-1: top, 0: center, 1: bottom)

If only one argument (a table) is passed to it, then the function will return the same list, with all of it's missing fields filled in

### Returns
- `UI.List`: A newly created list, which has ALL of it's fields filled in

### Example

```lua
-- Creates a list, which aligns it's children in
-- a horizontal line, with an 8px gap in between them
local list = ui.create_list("x", 8)
```