-- Config
local pin = 4 --> GPIO2
local value = gpio.HIGH
local BLINK_DURATION_ALARMER = 1
local BLINK_PERIOD_ALARMER = 2

-- Initialise the pin
gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, value)


-- Function turns LED on
function led_on()
  gpio.write(pin, gpio.LOW)
end

-- Function turns LED off
function led_off()
  gpio.write(pin, gpio.HIGH)
end


-- Function toggles LED state
function led_toggle()
  value = gpio.read(pin)
  if value == gpio.LOW then
    value = gpio.HIGH
  else
    value = gpio.LOW
  end
    
  gpio.write(pin, value)
end

-- Blink once during BLINK_DURATION
function led_blink(duration)
  led_toggle()
  tmr.alarm(BLINK_DURATION_ALARMER, duration, 0, led_toggle)
end

-- Start blinking every BLINK_PERIOD
function led_start_blink(period, duration)
  -- Stop if already blinking
  led_stop_blink()
  -- Blink once
  led_blink(duration)
  -- Create an alarm to repeat blink
  tmr.alarm(BLINK_PERIOD_ALARMER, period, 1, function() 
    led_blink(duration)
    end)
end

-- Stop blinking
function led_stop_blink()
  tmr.stop(BLINK_PERIOD_ALARMER)
  led_off()
end
