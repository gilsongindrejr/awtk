local wibox = require('wibox')
local gears = require('gears')

Button = {}

function Button:new(args)
  -- shape, text, bg, border, border_color, top, bottom, left, right, hover, click

  if not args.border_color then
    args.border_color = args.bg
  end

  if not args.text then
    args.text = 'Button'
  end

  local button_config = {
    {
      {
        text = args.text,
        widget = wibox.widget.textbox
      },
      top = args.top,
      bottom = args.bottom,
      left = args.left,
      right = args.right,
      widget = wibox.container.margin
    },
    bg = args.bg,
    shape_border_width = args.border,
    shape_border_color = args.border_color,
    shape = args.shape,
    widget = wibox.container.background
  }

  local button = wibox.widget(button_config)

  -- Change cursor on hover
  local old_cursor, old_wibox
  button:connect_signal("mouse::enter", function(c)
    local wb = mouse.current_wibox
    old_cursor, old_wibox = wb.cursor, wb
    wb.cursor = "hand1"
  end)
  button:connect_signal("mouse::leave", function(c)
    if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
    end
  end)

  -- Add hover effect
  button:connect_signal("mouse::enter", function(c) c:set_bg(args.hover) end)
  button:connect_signal("mouse::leave", function(c) c:set_bg(args.bg) end)

  -- Add on click effect
  button:connect_signal("button::press", function(c) c:set_bg(args.click) end)
  button:connect_signal("button::release", function(c) c:set_bg(args.hover) end)

  return button
end

return Button
