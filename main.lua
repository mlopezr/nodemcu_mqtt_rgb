-- Initialize LED and load functions
dofile("status_led.lua")

-- Blink a lot to show we're in init phase
led_start_blink(1000,100)

dofile("rgb.lua")

print("Connecting to network and MQTT")
connected = false

-- Called when connected to WiFi
function onConnection()
  connected = true
  
  -- Print SSID and IP
  print("Connected to WiFi "..wifi.sta.getconfig().." with IP "..wifi.sta.getip().."")

  -- Can now start using the network
  dofile("mqtt_rgb.lua")
  
end

-- If unable to connect to last known WiFi, creates a setup Access Point
enduser_setup.start(
  onConnection,
  function(err, str)
    print("enduser_setup: Err #" .. err .. ": " .. str)
  end
);

-- If for some reason we missed the alarm:
--if wifi.sta.getip() ~= nil then
--  onConnection()
--end
