# MQTT controlled RGB led on NodeMCU

## What is this?
This is a sample project enabling the control of a NodeMCU with a RGB led using MQTT. 
It uses:
* [NodeMCU WiFi microcontroller](https://en.wikipedia.org/wiki/NodeMCU) using [DevKit v1.0](https://github.com/nodemcu/nodemcu-devkit-v1.0)
* RGB led with common cathode connected to GND and RGB anodes connected to pins 7,6,5 through 100 ohm resistors
* Custom Lua firmware ([online build](http://nodemcu-build.com/), [API Reference](https://github.com/nodemcu/nodemcu-firmware/wiki/nodemcu_api_en)) to include:
 * pwm: to control RGB led
 * mqtt: to publish and subscribe to MQTT topics
 * enduser_setup: if it can't connect to the last known wifi network, it creates a wifi access point serving a configuration web interface at http://192.168.1.4
* CloudMQTT as MQTT broker ([mosquitto](http://mosquitto.org/) can be used too)
* [Node-Red](http://nodered.org/), an open-source web-based flow processing tool to trigger outputs based on inputs

## Similar projects
* [Mobile App Controlled Relays through ESP8266 via MQTT+HTTP](http://vinceelizaga.com/mobile-relay/)
