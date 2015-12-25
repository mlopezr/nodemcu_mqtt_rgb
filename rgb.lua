redPin = 7
greenPin = 6
bluePin = 5

RGB_CYCLE_ALARMER = 3
RGB_CYCLE_PERIOD = 35
H, S, L = 0, 240, 120

-- PWM frequency - adjust if LED flickers or PWM doesn't look linear
pwmFreq = 250

-- set up pins as PWM pins
pwm.setup(redPin, pwmFreq, 0)
pwm.setup(greenPin, pwmFreq, 0)
pwm.setup(bluePin, pwmFreq, 0)

-- start PWM output on the pins (effectively no light yet)
pwm.start(redPin)
pwm.start(greenPin)
pwm.start(bluePin)

function rgb_set(red,green,blue)
  pwm.setduty(redPin, red*4);
  pwm.setduty(greenPin, green*4);
  pwm.setduty(bluePin, blue*4);
end

function rgb_on()
  rgb_set(255,255,255)
end

function rgb_off()
  rgb_set(0,0,0)
end

function rgb_startCycle()
  tmr.alarm(RGB_CYCLE_ALARMER, RGB_CYCLE_PERIOD, 1, rgb_nextCycle)
end

function rgb_nextCycle()
  H = H + 1
  if H >= 240 then H = 0 end
  rgb_set(HSLtoRGB(H, S, L))
end

function rgb_stopCycle()
  tmr.stop(RGB_CYCLE_ALARMER)
end

function HSLtoRGB(H, S, L)
    H, S, L = math.min(240, H), math.min(240, S), math.min(240, L)
    H, S, L = math.max(0, H), math.max(0, S), math.max(0, L)
    R, G, B = 0, 0, 0
    if H < 80 then
        R = math.min(255, 255 * (80 - H) / 40)
    elseif H > 160 then
        R = math.min(255, 255 * (H - 160) / 40)
    end
    if H < 160 then
        G = math.min(255, 255 * (80 - math.abs(H - 80)) / 40)
    end
    if H > 80 then
        B = math.min(255, 255 * (80 - math.abs(H - 160)) / 40)
    end
    if S < 240 then
        k = S / 240
        R, G, B = R*k, G*k, B*k
        k = 128 * (240 - S) / 240
        R, G, B = R+k, G+k, B+k
    end
    k = (120 - math.abs(L - 120)) / 120
    R, G, B = R*k, G*k, B*k
    if L > 120 then
        k = 256 * (L - 120) / 120
        R, G, B = R+k, G+k, B+k
    end
    return R, G, B
end
