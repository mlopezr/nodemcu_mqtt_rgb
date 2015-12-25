-- init mqtt client with keepalive timer 120sec
m = mqtt.Client("clientid", 120, "cblgywch", "PhsKtj4F8GnB")

-- setup Last Will and Testament (optional)
-- Broker will publish a message with qos = 0, retain = 0, data = "offline" 
-- to topic "/lwt" if client don't send keepalive packet
m:lwt("node/lwt", "offline", 0, 0)

m:on("offline", function(con) 
  print ("MQTT offline") 
  led_start_blink(1000,100)
end)

m:on("connect", function(con) 
  print ("MQTT connected")
end)

-- on publish message receive event
m:on("message", function(conn, topic, data) 
  print("Received: " .. topic .. ": " .. data) 
  if topic == "node/led" then
    if data == "on" then 
      led_on()
    elseif data == "off" then 
      led_off()
    elseif data == "toggle" then 
      led_toggle()
    end
  elseif topic == "node/rgb" then
    if data == "cycle" then
      print("Starting RGB cycle")
      rgb_startCycle()
    elseif data == "stop" then
      print("Stopping RGB cycle")
      rgb_stopCycle()
    elseif data == "on" then
      print("Setting RGB on")
      rgb_on()
    elseif data == "off" then
      print("Setting RGB off")
      rgb_off()
    else 
      r, g, b = data:match("([^,]+),([^,]+),([^,]+)")
      r = tonumber(r)
      g = tonumber(g)
      b = tonumber(b)
      if (r ~= nil and g ~= nil and b ~= nil) then
        rgb_set(r,g,b)
      else
        print("Unrecognized message: " .. data)
      end
    end
  end
end)

-- for secure: m:connect("192.168.11.118", 1880, 1)
m:connect("m20.cloudmqtt.com", 19767, 0, 
  function(conn) 
    print ("MQTT connected. Subscribing...")

    -- subscribe topic with qos = 0
    m:subscribe("node/#",0, function(conn) 
      print("Subscription successful")
      led_start_blink(10000,100)
    end)

    -- publish a message with data = hello, QoS = 0, retain = 0
    m:publish("node/hello","mac = " .. wifi.sta.getmac(),0,0, function(conn) print("Hello sent") end)
  end
)
