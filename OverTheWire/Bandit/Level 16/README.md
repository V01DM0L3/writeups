Level 16
======

### Task

> The credentials for the next level can be retrieved by submitting the password of the current level to **a port on localhost in the range 31000 to 32000**. First find out which of these ports have a server listening on them. Then find out which of those speak SSL and which don’t. There is only 1 server that will give the next credentials, the others will simply send back to you whatever you send to it.

### Steps

#### Login to `bandit16` with password from previous level
`ssh bandit16@bandit.labs.overthewire.org -p 2220`

#### Firstly we don't know to which port we have to connect so we can scan loclahost in port range 31000 to 32000 using some scanner, we are going to use `nmap`:
`nmap localhost -p 31000-32000`

This command has really simple syntax:<br>

`localhost` in this place you can also place ip address, it informs `nmap` what we are gonna to scan.<br>

`-p 31000-32000` means just to scan in range 31000 to 32000 in case to find some info about them it ignores other ports

Otput of this command would looks like below:

```
Starting Nmap 7.40 ( https://nmap.org ) at 2021-04-21 19:05 CEST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00029s latency).
Not shown: 996 closed ports
PORT      STATE SERVICE
31046/tcp open  unknown
31518/tcp open  unknown
31691/tcp open  unknown
31790/tcp open  unknown
31960/tcp open  unknown

Nmap done: 1 IP address (1 host up) scanned in 0.09 seconds
```

We narrowed our searches to 5 open ports instead 1000, and in this point we can stop our scanninbg and try to get password from each of this ports but, as I said many times automation is our ally.<br>

Futher more we don't get any info even about if SSL works on one this 5 ports, we just know they are listenning and open for input, so we also have to use more exact scan type.

#### The whole line which will do what we need is:
`nmap localhost -sV -p 31046,31518,31691,31790,31960 | grep ssl`

That will return us only ports which have something to do with ssl and what's more important we only narrowed our search to 5 ports which might have ssl service running on. <br>

Explaination: We used `-sV` flag to make a more exact scan, performed on specified ports, each one separated by `,` after `-p` flag, Later we add an `grep` command over pipeline, to search only `ssl` containing lines.<br>

And our desired output looks like this:

```
31518/tcp open  ssl/echo
31790/tcp open  ssl/unknown
```

Be aware, that `-sV` scan takes some time so don't panic, just wait for results

#### Knowing on which ports ssl works we can simply try to pass current level credentials and see what will happend:
 
`openssl s_client -connect localhost:31518`

Nope it doesn't work, any input returns as same message so we have to chec another port <br>

`openssl s_client -connect localhost:31790`

Bingo, when we type current level password here, in response we get RSA private key, which we will use to log into next level, using same method as we did in **Level 13** <br>

```
...more RSA key...
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----
closed

```

### Additional notes

You can automate things even more like below:<br>

`nmap localhost -sV -T4 -p $(nmap localhost -p 31000-32000 | grep "/tcp" | cut -d "/" -f1 | tr '\n', ',') | grep ssl`

This is one line command for whole ssl ports identifying, main difference from previous one is, that we used `$()` which allows us to pass every output we want in that place (in our case: value for `-p` flag), to be treated as input for example a file.<br>

To do so we firstly have to execute scan in case of finding all open ports in range 31000-32000, then we `grep` from this output, only lines containing `/tcp`, what means we just cutted just lines with ports numbers. After that we use `cut` command to cut these lines using `/` (`-d` flag) character as a separator and we pass through pipeline only first field cutted like that (`-f1`). Finally we translate output's new-line character into comma to convert this:

```
31046
31518
31691
31790
31960
```

into this:

```
31046,31518,31691,31790,31960 
```

This format can be easily read by `nmap` and all we do now is to put this formated output as an argument for `-p` flag what we just did using `$()` syntax.<br>

At the end we simply clear output to get only lines with ssl service (`grep ssl`), and finally we get same output as in regular task completion, but fully automated, with no scan analysing, only raw command doing what we wanted.


