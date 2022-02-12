-- CORAL CARRIER INCARNADINE
-- https://cci.dev

version = "0.0.4"

tabutil = require "tabutil"
include "cci/lib/credits"
include "cci/lib/events"
include "cci/lib/filesystem"
include "cci/lib/graphics"
include "cci/lib/hid_controller"
include "cci/lib/items"
include "cci/lib/lsys/includes"
include "cci/lib/q"
include "cci/lib/View"
include "cci/lib/views/Title"


function init()
  filesystem.init()
  hid_controller.init()
  graphics.init()
  events.init()
  q.init()
  items.init()
  credits.init()
  lsys_controller:init()
  -- boot.init()
  arrow_of_time = 0
  credits:open()
  q:push("items")
  q:push("main_menu")
  q:push("splash")
  q:pop()
  redraw_clock_id = clock.run(redraw_clock)
end

function redraw()
  graphics:render()
end

function keyboard.code(code, value)
  hid_controller:handle_code(code, value)
end

function keyboard.char(ch)
  hid_controller:handle_char(ch)
end

function enc(e, d)
  print(e, d)
end

function key(k, z)
  print(k, z)
end

function redraw_clock()
  while true do
    clock.sync(1/15)
    arrow_of_time = arrow_of_time + 1
    if arrow_of_time > q.endframe and not q.hold then
      q:pop()
    end
    if screen_dirty then
      redraw()
      screen_dirty = false
    end
  end
end

function cleanup()
  credits:close()
  clock.cancel(redraw_clock_id)
end
