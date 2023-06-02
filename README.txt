This is a setup script I made to automate the setup of a kali linux mobile, ssh-accesssable through pi self-hosted wifi, on a RaspberryPi. 

              Setup a Raspberry pi with 64x Kali
##IMPORTANT## Set the time with "sudo date -s "MMM DD YYYY HH:MM" 
              git clone https://github.com/nracmo/mobilehacker/
              cd mobilehacker
              sudo bash setup.sh

I know the commands work if you run them manually but I got tiredof doing that every time I set up a new one so this is my first attempted script.

It will setup the raspberry pi to broadcast a network that will make the Pi be accesssable through ssh. 
The network name by default is "Skynet" and the password is "password" I have marked in the script where those can be changed, and I recommend doing so befoore you run it.
Once you connect, it will be accessable on 192.168.5.1 and if you connect another wifi usb or ethernet it will pass through the internet connection to your connected device.
If you have any improvements please let me know and I will do my best to add them.
                                                                           ____
                                                                       ___/    \___
                                                |---ATTACK ANNTENA----| INTERNET   |
 _____________                       ___________|_                     \__________/   
| Phone or PC |----------PI-WIFI-----|..        . |
|____SSH______|          (Skynet)    |  ..PI .... |                      
                                     |____________| 
