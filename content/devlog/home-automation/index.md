---
title: 'Creating a Connected Home: An ESP8266 Project'
date: 2024-08-24T05:01:41+02:00
summary: 'Building a home automation system from scratch using ESP8266 with google home integration'
tags: ['#homeautomation', '#esp8266']
---

```goat
· * · · ·     · · o  * * * * *  * * o o *    o * o      o o *      o o o     · * · · o  . o * * · o
o * o * o * * o  o o * *  * * o o *    o * o   * o *      o * o     · * · o o     · · o * o o o .
* o * o * o * o  o o o o o  * * * * *  o o o o o  * * * * *  o o * o o  · o · · o   · · * * · * o
o o * o o * o o  * * * * *  o o o o *  o o o * o  * * * * *  o o o o o  · · · · o    · · * · * . o
```

Have you ever wondered why the smart home devices are no so common in the market? The answer is simple, they are expensive when compared to the features they offer. Well, did you know that how much it costs to build a smart home device which can be installed in your switch box and controlled using google assistance and google home app? The answer is not much.

Yes, you heard it right. This was the main thought that come to my mind when i first bought a smart bulb for my room. I was very much excited to control the lights in my room using my mobile phone. But when I compared the price of the smart bulb, I was shocked. It was very expensive when compared to the normal bulb.

This was back in 2020, when this initial thought came to my mind when covid was at its peak and everyone was locked in their homes. After couple of months of research and planning an initial prototype was created and installed in my room which was able to control the devices. This was the first step towards creating a connected home.

## Initial Prototype

This write up is not about the process of building the device which was already done and dusted couple of years back and have been installed in couples of locations already. The detailed information about the project is document as a series of youtube videos which can be found in the playlist below.

{{< youtube _rqcX9FfTDs >}}

This blog is about the further iterations done on the project to make it more reliable in terms of software.

## Software & Hardware Enhancements

### Hardware Enhancements

The initial prototype was build with available components and was not designed to be modular. The main idea behind the prototype was to make it work and test it in real world scenario. After a year of testing the prototype in multiple locations, we decided to make the hardware modular and more reliable.
{{< figure src="./assets/parts.jpg" title="components" width="280" >}}

{{< figure src="./assets/assembled.jpg" title="assembled module" width="280" >}}
{{< figure src="./assets/switch-module.jpg" title="Updated hardware 2022" width="280" >}}

This is the updated hardware and works till now without any issues and the cost to build the device is less than 50$ which is very cheap when compared to the commercially available ones.

### Update ESP-8266 firmware to Tasmota

The initial prototype was build using custom firmware that was built using custom logic. Yes the main idea behind that was to have only the required functionality in the firmware to make it light weight. So the firmware included only the logic to control the lights with the switch or using the events received from google home and the OTA update functionality.

However as the project was installed in multiple locations and the number of devices increased we started noticing some issues with the firmware. The main issue was the interference with the AC main line which was causing the device to restart. Already there was software fix implemented using debounce logic but it was not enough. So we decided to move to a more stable firmware which is already available in the market and is open source.

The firmware we decided to move to was [Tasmota](https://tasmota.github.io/docs/). Tasmota is an open source firmware for ESP8266 devices that allows you to control the device using MQTT, HTTP and other protocols. The firmware is very stable and is being used by many people around the world. The firmware also has a web interface which can be used to configure the device.

## Upcoming Enhancements

The upcoming enhancements for the project include adding support for capacitive touch (TTP223 modules) to replace mechanical switches, allowing devices to be controlled via touch.
{{< figure src="./assets/touch-module.jpeg"  title="TTP223 Touch pad detector" width="280">}}

This way the need for mechanical switches can be eliminated and a dummy switch on which the touch module can be placed.

{{< figure src="./assets/capacitive-switch.mov" title="Capacitive touch switches"  width="280">}}

> The functionality is still in development and will be updated as soon as the new features are added. Stay tuned for more updates.
