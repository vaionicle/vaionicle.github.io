---
categories:
  - Hacks
---

# **Hack MediaAccess TG788vn v2**

## How to connect

```config
URL      : http://192.168.1.254
IP       : 192.168.1.254

# Forthnet Root Access
username : dsath
password : f!g*h!X0
```

## Manuals

Here you can download the manual for [TG788vn-EN](./assets/attachments/TG788vn-EN-manual.pdf),
the command list for 
[TG788vn](./assets/attachments/TG788vn-EN-r8.C.M.0_SIP-Server_mh.pdf) or
[TG587nv2](./assets/attachments/TG587nv2-EN-r8.4.3.K-BL-mh_v2.0.pdf)


## **Telnet**

### Enable **telnet** service

#### Download config file

Download the config file from routers user interface, to do that **you need** to login as **dsath** user

`Follow the below steps to navigate`

1. [Login as dsath](http://192.168.1.254/login.lp)
2. [Configuration](http://192.168.1.254/backup.lp?be=0&l0=1&l1=1&tid=BACKUP_RESTORE)
3. **Backup Configuration Now...**

`Or Follow Breadcrump`

1. Home
2. MediaAccess Gateway
3. Configuration
4. Backup & Restore




#### Modify **user.ini** file

Search for **[ servmgr.ini ]** section from **user.ini** file and **modify/verify** those lines

```python
[ expr.ini ]
add name=telnet type=serv proto=tcp dstport=telnet

[ service.ini ]
add name="Telnet Server" mode=server
rule add name="Telnet Server" protocol=tcp portrange=23-23

[ servmgr.ini ]
ifadd name=TELNET group=lan
ipadd name=TELNET ip=192.168.1.[0-254]
modify name=TELNET state=enabled natpmweight=10
mapadd name=TELNET port=telnet
```

> What those lines do

**Allow TELNET service to be accessible from LAN network**

```config
ifadd name=TELNET group=lan
```

**Allow TELNET service to be accesible from 192.168.1.[0-254] ip range**

```config
ipadd name=TELNET ip=192.168.1.[0-254]
```





#### Upload file

Do the following steps to upload **user.ini** file

1. Goto [Configuration](http://192.168.1.254/backup.lp?be=0&l0=1&l1=1&tid=BACKUP_RESTORE)
2. Press the **Choose File** and select the file
3. Press the **Restore Configuration Now..**
4. Wait for router to restart




### Connect using telnet

Connect writing in your terminal

> telnet 192.168.1.254 23

And you are going to see something like the bellow

```bash
# telnet 192.168.1.254 23

Trying 192.168.1.254...
Connected to 192.168.1.254.
Escape character is '^]'.
Username : dsath
Password : ********
------------------------------------------------------------------------

                             ______  MediaAccess TG788vn v2
                         ___/_____/\
                        /         /\\  10.5.2.S
                  _____/__       /  \\ 
                _/       /\_____/___ \  Copyright (c) 1999-2014, Technicolor
               //       /  \       /\ \
       _______//_______/    \     / _\/______ 
      /      / \       \    /    / /        /\
   __/      /   \       \  /    / /        / _\__ 
  / /      /     \_______\/    / /        / /   /\
 /_/______/___________________/ /________/ /___/  \
 \ \      \    ___________    \ \        \ \   \  /
  \_\      \  /          /\    \ \        \ \___\/
     \      \/          /  \    \ \        \  /
      \_____/          /    \    \ \________\/
           /__________/      \    \  /
           \   _____  \      /_____\/
            \ /    /\  \    /___\/  CB007FN
             /____/  \  \  /
             \    \  /___\/
              \____\/

------------------------------------------------------------------------
{dsath}=>
{dsath}=>:env set var=SESSIONTIMEOUT value=0
{dsath}=>saveall
```

### Navigate

|**#**|**KEY**|**Description**|
|1| tab | use it for command autocomplete|
|3| ctrl + backspace | delete every char from *left* |
|4| backspace | delete every char from *right* |
|2| ? | to access commands help|
|5| .. | go one command back |

### Commands

Bellow are the available commands for the telnet terminal

> If you need **help** on the bellow commands, download
> [TG788vn](./assets/attachments/TG788vn-EN-r8.C.M.0_SIP-Server_mh.pdf)
> or
> [TG587nv2](./assets/attachments/TG587nv2-EN-r8.4.3.K-BL-mh_v2.0.pdf)

```bash
{dsath}=>?
Following commands are available :

help             : Displays this help information
menu             : Displays menu
?                : Displays this help information
exit             : Exits this shell.
..               : Exits group selection.
saveall          : Saves current configuration.
ping             : Send ICMP ECHO_REQUEST packets.
traceroute       : Send ICMP/UDP packets to trace the ip path.

Following command groups are available :

cgroups         contentsharing  firewall        printersharing  pwr             
service         connection      cwmp            dsd             grp             
gwrd            led             dhcp            dns             download        
dyndns          eth             atm             config          debug           
env             expr            hostmgr         ids             igmp            
interface       ip              ipqos           label           language        
mbus            memm            mld             mlp             mobile          
nat             netdiag         ppp             pptp            ptrace          
script          sntp            software        ssh             statecheck      
syslog          system          tls             tr143           tunnel          
upgrade         upnp            user            voice           wansensing      
webserver       wireless        xdsl            

```




## **SSH**

### Enable SSH service (using Telnet)

**Add your local IP Range to access SSH**

```bash
{dsath}=>:service system ipadd name=SSH ip=192.168.1.[0-254]
```

**Enable service**

```bash
{dsath}=>:service system modify name="SSH" state="enabled"
```


### SSH Config

Configure your ssh config to have an easy way to connect with your router.
So include those lines into your `~/.ssh/config`

> If you dont like router to be the name of your box, change it to what ever you want

```bash
# cat ~/.ssh/config

Host router
    User dsath
    HostName 192.168.1.254
    HostKeyAlgorithms ssh-dss
    KexAlgorithms diffie-hellman-group1-sha1
    Ciphers 3des-cbc,aes128-cbc,aes192-cbc,aes256-cbc
```

### Connect

```bash
ssh router

# or you can use it like this

ssh dsath@router
```





## Network Commands

### IP Command

```bash
{dsath}=>:ip ?        
Following commands are available :

ifadd            : Create an IP interface.
ifdelete         : Delete an IP interface.
ifattach         : Attach an IP interface.
ifdetach         : Detach an IP interface.
ifconfig         : Modify an IP interface configuration.
iflist           : Display all IP interfaces.
ifwait           : Wait for a status change of an IP interface.
ipadd            : Assign an IP address to an IP interface.
ipdelete         : Remove an IP address from an IP interface.
ipconfig         : Modify an IP address configuration.
iplist           : Display all configured IP addresses.
rtadd            : Add a route to the routing table.
rtconfig         : Modify a route of the routing table.
rtdelete         : Delete a route from the routing table.
rtlist           : Display the routing table.
arpadd           : Add an entry to the ARP cache of a broadcast IP interface.
arpdelete        : Delete an ARP entry.
arplist          : Display the ARP cache.
nblist           : List the neighbours
nbset            : Add/modify a neighbour
nbdelete         : Delete a neighbour
config           : Display/Modify global IP stack configuration.
clearifstats     : Flush IP interface statistics.
flush            : Flush all static IP parameters.  Dynamic info (e.g. from PPP links) remains.

Following command groups are available :

aip             auto            debug           mcast           rt6advd         

```


#### ARP List

```bash
{dsath}=>:ip arplist 
Interface           IP-address             HW-address        Type
5   LocalNetwork    192.168.1.253          xx:xx:xx:xx:xx:xx DYNAMIC
8   Voice2_vdsl     10.195.128.1           xx:xx:xx:xx:xx:xx DYNAMIC
5   LocalNetwork    192.168.1.2            xx:xx:xx:xx:xx:xx DYNAMIC
5   LocalNetwork    192.168.1.3            xx:xx:xx:xx:xx:xx DYNAMIC
5   LocalNetwork    192.168.1.4            xx:xx:xx:xx:xx:xx DYNAMIC
5   LocalNetwork    192.168.1.20           xx:xx:xx:xx:xx:xx DYNAMIC
5   LocalNetwork    192.168.1.52           xx:xx:xx:xx:xx:xx DYNAMIC
5   LocalNetwork    192.168.1.56           xx:xx:xx:xx:xx:xx DYNAMIC
5   LocalNetwork    192.168.1.76           xx:xx:xx:xx:xx:xx DYNAMIC

```

#### DNS Host List

```bash
{dsath}=>:dns server host list
Address                                         Type Hostname                     TTL (s)                          Creator
<local>                                         A    dsldevice                       1200                        undefined
<local>                                         AAAA dsldevice                       1200                        undefined
192.168.1.76                                  * A    iPad--Maria                        0                      DHCP_Server
192.168.1.253                                 * A    Linux                              0                      DHCP_Server
192.168.1.2                                   * A    HUAWEI_P_smart-6a732a7c46          0                      DHCP_Server
192.168.1.3                                   * A    VaionicleX                         0                      DHCP_Server
192.168.1.4                                   * A    VasileipleWatch                    0                      DHCP_Server
192.168.1.56                                  * A    asguard                            0                      DHCP_Server
192.168.1.52                                  * A    vaionicle-OptiPlex-7010            0                      DHCP_Server
{dsath}=>
```

### WIFI

### xVDSL

#### Info

Get information for how long is your DSL modem up and running

```bash
{dsath}=>:xdsl info
Modem state:                       up
Up time (Days hh:mm:ss):           0 days, 5:30:23
xDSL Type:                         VDSL
Bandwidth (Down/Up - kbit/s):      49999/4998
```

```bash
{dsath}[xdsl debug]=>:xdsl info counter_period_filter current 
Physical Layer Statistics:        

  Modem state:                       up
  Up time (Days hh:mm:ss):           0 days, 5:35:21
  xDSL Standard:                     ITU-T G.993.2 Annex B (VDSL2)
  Channel Mode:                          Interleaved

  Number of reset:                   0

  Chipset Vendor info (G.994.1):       Local    Remote
    Country code:                      B500     B500
    ID:                                BDCM     BDCM
    Specific:                          0000     B1A6

  System Vendor info (showtime):     Local    Remote
    Country code:                    0F00     0000
    ID:                              TMMB     ----
    Specific:                        3xx1xx xx0xx0xx
xx
xxBearers generic info               DS    xx xxUxx xx xx
xx  Payload rate [kbps]:         4999xx xx xx9xx xx
xx  Attenuation [dB]:              5.5        2xx xx:xx:xx:xx:xx
    Margins [dB]:                  31.4       4xx:xx:xx:xx:xx:xx
    Output power [dBm]:            11.9       8xx:xx:xx:xx:xx:xx
xx:xx:xx:xx:xx:xx
xx:xx:xx:xx:xx:xxrers:               1
    Bearer 0                         DS           US       
      INP [DMT symbols]:           1.00           0.00           
      Delay [ms]:                  10.00          0.00           
      Depth []:                    265            0.00
      R:                           16           0       

G.997.1 Statistics (Current):        

  Failures:
    Line failures                    Near end
      Loss of signal (LOS):          0       
      Loss of frame (LOF):           0       
      Loss of power (LPR):         0       

  Performance monitoring:
    Line PM:                   Near end
      Error second (ES):           0       

    Channel PM:                Near end   Far end
      Bearer 0:
        Code Violation (CV):         0          0       
        FEC:                         9810       0       

    ATM data path PM:                Near end   Far end
      Bearer 0:
        HEC violation count (HEC):         0          N/A
```

```bash
{dsath}[xdsl debug]=>:xdsl info vectoring

Vectoring Info: 

  Statistics:
    cntESPktSend:        99294   
    cntESPktDrop:        0       
    cntESStatSend:         49647   
    cntESStatDrop:         0       

  VCE Info:
    Address:           00:19:ffffff8f:6c:44:68

  Mode:
    Direction:           Upstream
    Rx BitSwap:          Disabled
    VN:                  Disabled
```


### How to open a port to a device



----

## DNS

### NSLOOKUP

```bash
{dsath}=>:dns client nslookup host=pornhub.com  
Name:    pornhub.com
Address: 66.254.114.41
Aliases: none
```





































































## Debug / Logs

### DMESG

```bash
{dsath}=>:debug dmesg

flash size 64MB @1c000000
brcmnand_scan 230
brcmnand_scan 40, mtd->oobsize=16, chip->ecclayout=00000000
brcmnand_scan 42, mtd->oobsize=16, chip->ecclevel=15, isMLC=0, chip->cellinfo=0
brcmnand_scan:  mtd->oobsize=16
brcmnand_scan: oobavail=12, eccsize=512, writesize=512
...
...
usbcore: registered new interface driver ftdi_sio
ftdi_sio: v1.4.3:USB FTDI Serial Converters Driver
SCSI subsystem initialized
Driver 'sd' needs updating - please use bus_type methods
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
```

```bash
{dsath}=>:syslog msgbuf show
```


```
{dsath}=>
cgroups                 contentsharing          firewall                
printersharing          pwr                     service                 
connection              cwmp                    dsd                     
grp                     gwrd                    led                     
dhcp                    dns                     download                
dyndns                  eth                     atm                     
config                  debug                   env                    
expr                    hostmgr                 ids                     
igmp                    interface               ip                      
ipqos                   label                   language                
mbus                    memm                    mld                     
mlp                     mobile                  nat                     
netdiag                 ppp                     pptp                    
ptrace                  script                  sntp   
```





#### Get Information for all services

```bash
{dsath}=>:service system list
Idx Name             Protocol         SrcPort  DstPort  Group            State   
---------------------------------------------------------------------------------
  1 CWMP-C           tcp over ipv4                                       enabled 
  2 CWMP-S           tcp over ipv4             51005                     enabled 
  3 DHCP-S           udp over ipv4             676                       enabled 
  4 DHCPv6-C         udp over ipv6    547      546                       enabled 
  5 DHCPv6-R         udp over ipv6             547                       enabled 
  6 DHCPv6-S         udp over ipv6             547                       enabled 
  7 DNS-C            udp over ipv4             53                        enabled 
  8 DNS-S            ip                        53                        enabled 
  9 DYNAMIC_DNS                                                          enabled 
 10 FTP              tcp                       2121                      enabled 
 11 GRE              gre over ipv4                                       disabled
 12 GWRD             tcp over ipv4                                       disabled
 13 HTTP             tcp                       80                        enabled 
 14 HTTPI            tcp over ipv4             8080                      disabled
 15 HTTPs            tcp                       443                       enabled 
 16 IGMP-Proxy       igmp                                                enabled 
 17 IP6TO4           ipv6 over ipv4                                      disabled
 18 IP_COMMANDS                                                          enabled 
 19 IP_REDIR         icmp                      5                         disabled
 20 IPIP             ipencap                                             disabled
 21 IPv6_MANAGEMENT  ipv6-icmp                                           enabled 
 22 L2TP             udp over ipv4    1701     1701                      disabled
 23 MDAP             udp over ipv4             3235                      enabled 
 24 MLD-Proxy        ipv6-icmp                 143                       disabled
 25 PING_RESPONDER   icmp                      8                         enabled 
 26 PINGv6_RESP      ipv6-icmp                 128                       enabled 
 27 PPTP                                                                 enabled 
 28 Remote-MBus      tcp over ipv4             2006                      disabled
 29 RIP              udp over ipv4    520      520                       disabled
 30 SIP_SERVER                                                           disabled
 31 SLA_ICMP_PING    icmp                      8                         enabled 
 32 SLA_ICMPv6_PING  ipv6-icmp                 128                       enabled 
 33 SLA_UDP_PING     udp                       7                         disabled
 34 SNTP             udp              123      123                       enabled 
 35 SSDP             udp over ipv4             1900                      enabled 
 36 SSH              tcp                       22                        disabled
 37 SYSLOG           udp over ipv4             514                       disabled
 38 TELNET           tcp                       23                        enabled 
 39 TFTP-C           udp over ipv4             69                        disabled
 40 UPGD-C           ip over ipv4                                        enabled 
 41 VOIP_SIP                                   5060                      enabled 
 42 WEBF             tcp over ipv4             80                        disabled
 43 webservice       tcp                       9000                      disabled
{dsath}=>
```



## Users

### Get a list of users

```
{dsath}=>:ar group member list
<groupname>:<members> 
root:
daemon:
bin:
...
...
PowerUser:
User:
WAN_Admin:
{dsath}=>
```




https://forum.dd-wrt.com/wiki/index.php/Telnet/SSH_and_the_Command_Line

https://lehollandaisvolant.net/tout/_misc/telnet/

http://moosy.blogspot.com/2009/12/tech-stuff-adding-static-route-on.html

[TG582N activate 3G](https://support.aa.net.uk/Router_-_TG582N_-_3G)

http://web.archive.org/web/20160714183537/http://npr.me.uk/telnet.html

http://web.archive.org/web/20160805052222/http://npr.me.uk/remote.html

http://web.archive.org/web/20160728221606/http://npr.me.uk/wol.html

https://criticaltech.wordpress.com/2009/12/12/thomson-router-full-cone-nat-configuration/

https://forums.whirlpool.net.au/forum-replies.cfm?t=1739702
