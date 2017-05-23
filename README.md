# ZeroTier Controller CLI
[![GitHub license](https://img.shields.io/badge/license-GPL-blue.svg)](https://raw.githubusercontent.com/makersphereLabs/zerotier-ctl/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/makersphereLabs/zerotier-ctl.svg?maxAge=2592000)](https://github.com/makersphereLabs/zerotier-ctl)
[![Github All Releases](https://img.shields.io/github/downloads/makersphereLabs/zerotier-ctl/total.svg?maxAge=2592000)](https://github.com/makersphereLabs/zerotier-ctl/releases)
[![Status](https://img.shields.io/badge/status-laboratory-f0466e.svg)](https://makersphere.org)

Run your own ZeroTier Controller!  
This is a _laboratory project_ and will be replaced by a new tool (incl. Web UI), after `version 1.2.0` is released.

Check out the awesome work the nice folks at [ZeroTier](https://zerotier.com) are doing.  
Peer-to-Peer Networks FTW!

Feel free to open a Pull Request and help us, to improve the project and add more features.

Also check out https://makersphere.org & follow us on https://twitter.com/makerspherehq ✌️

## Features
* Always built from source
* Docker powered
* Written in pure Shell
* No elevated permissions required
* Easy to manage

## How it works
This Docker app contains a special build of `ZeroTier One` with `ZT_ENABLE_NETWORK_CONTROLLER` enabled.  
It allows you to run your own _private_ (or public) ZeroTier network.  
Make sure to read the official [documentation](https://github.com/zerotier/ZeroTierOne/wiki) before you start the setup.

## Usage
Clone the repository and build the Docker image using `docker build -t makerspherelabs/zerotier-ctl:1.1.14 .` on your server.
You need to `cd` into the cloned repo before you run the `docker build` command.  
Start the container with e.g. `docker run -dit -p 9993:9993/udp --name=zerotier-ctl --restart=unless-stopped makerspherelabs/zerotier-ctl:1.1.14`.  
Alright, your very own ZeroTier Controller is up and running.  
Have fun!

## Configuring a new network
Below are some sample calls to get your new controller to assign IP addresses to new members on a private network

Add a managed route

```curl -H "X-ZT1-Auth: $API_SECRET" -H "Content-Type: application/json" -X POST -d '{"routes": [{"target": "10.250.50.0/24", "via": null, "flags":0, "metric":0}]}' $CONTROLLER_ADDRESS/controller/network/$NETWORK_ID```

Add IP assignment pools (make sure they are within the managed route)

```curl -H "X-ZT1-Auth: $API_SECRET" -H "Content-Type: application/json" -X POST -d '{"ipAssignmentPools": [{"ipRangeStart": "10.250.50.1", "ipRangeEnd": "10.250.50.254"}]}' $CONTROLLER_ADDRESS/controller/network/$NETWORK_ID```

Set IPv4 assignment mode

```curl -H "X-ZT1-Auth: $API_SECRET" -H "Content-Type: application/json" -X POST -d '{"v4AssignMode":{"zt": "true"}}' $CONTROLLER_ADDRESS/controller/network/$NETWORK_ID```


Authorize a new member on a private network

```curl --H"X-ZT1-Auth: $API_SECRET" 5-H "Content-Type: application/json" -X POST -d '{"authorized":"true"}' $CONTROLLER_ADDRESS/controller/network/$NETWORK_ID/member/$MEMBER_ID```

## Credits
This project is powered by the [ZeroTier One](https://github.com/zerotier/ZeroTierOne) API.  
Go ahead and say **thank you**!
