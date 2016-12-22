# MQTT controlled RGB led on NodeMCU

## What is this?
This is a sample project enabling the control of a NodeMCU with a RGB led using MQTT.

It uses:
* [NodeMCU](https://en.wikipedia.org/wiki/NodeMCU) [DevKit v1.0](https://github.com/nodemcu/nodemcu-devkit-v1.0) based on [ESP8266 microcontroller](https://en.wikipedia.org/wiki/ESP8266)
* RGB led with common cathode connected to GND and RGB anodes connected to pins 7,6,5 through 100 ohm resistors
* Custom Lua firmware ([online build](http://nodemcu-build.com/), [API Reference](https://github.com/nodemcu/nodemcu-firmware/wiki/nodemcu_api_en)) including the following modules:
 * pwm: to control RGB led
 * mqtt: to publish and subscribe to MQTT topics
 * enduser_setup: to simplify initial WiFi configuration using a temporary access point and web server
* [CloudMQTT](https://www.cloudmqtt.com/) as MQTT broker ([mosquitto](http://mosquitto.org/) can be used too)
* [Node-Red](http://nodered.org/), an open-source web-based flow processing tool to trigger outputs based on inputs

## Usage
* [Get started with ESPlorer](https://odd-one-out.serek.eu/esp8266-nodemcu-getting-started-hello-world/).
* Connect common cathode of RGB LED to GND and R,G,B anodes to pins 7,6,5 through 100 ohm resistors.
* Set up a MQTT broker, for instance using [CloudMQTT](https://www.cloudmqtt.com/). Update server, user and password in `mqtt_rgb.lua`.
* Flash lua files.
* After first boot, a WiFi Access Point named "SetupGadget..." is created. Connect to it (you will get an IPv4 address through DHCP) and browse http://192.168.4.1 to configure the WiFi SSID and password to be used subsequently.
* The on-board LED blinks once every second when not connected and once every 10 seconds once connected.
* Use any MQTT client such as [CloudMQTT web console](https://api.cloudmqtt.com/sso/cloudmqtt/websocket) to publish messages.
 * topic `node/led` controls on-board LED using payloads:
  * `on`
  * `off`
  * `toggle`
* topic `node/rgb` controls RGB LED on pins 7,6,5 using payloads:
 * `cycle` starts and endless colour cycle
 * `stop` stops cycle
 * `on` turns white (you should stop cycle first)
 * `off` turns off (you should stop cycle first)
* You can install Node-Red and import the flow to trigger actions based on events

## Related projects
* [Mobile App Controlled Relays through ESP8266 via MQTT+HTTP](http://vinceelizaga.com/mobile-relay/)
* [Home Automation with Ionic and MQTT](https://blog.codecentric.de/en/2014/09/home-pi-reloaded-home-automation-ionic-mqtt/)
