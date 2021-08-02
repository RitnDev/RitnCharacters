local events = {}

local function call_remote_functions()
    --pcall(function() remote.call("freeplay", "set_created_items", {}) end) 
    --pcall(function() remote.call("freeplay", "set_respawn_items", {}) end) 
    pcall(function() remote.call("freeplay", "set_skip_intro", true) end) 
    pcall(function() remote.call("freeplay", "set_disable_crashsite", true) end) 
end
  
local function on_init(event)
  -- Call remote functions.
  call_remote_functions()
end
  
local function on_load(event)
  -- Call remote functions.
  call_remote_functions()
end


-----------------------------
events.on_init = on_init
events.on_load = on_load
return events