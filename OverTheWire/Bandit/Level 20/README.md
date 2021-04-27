Level 20
======

### Task

> There is a setuid binary in the homedirectory that does the following: it makes a connection to localhost on the port you specify as a commandline argument. It then reads a line of text from the connection and compares it to the password in the previous level (bandit20). If the password is correct, it will transmit the password for the next level (bandit21).<br><br>
NOTE: Try connecting to your own network daemon to see if it works as you think.

### Steps

#### Login to `bandit20` with password from previous level
`ssh bandit20@bandit.labs.overthewire.org -p 2220`

#### Firstly let's what's inside homedirectory:
`ls -l`

There is again `setuid executable` as mentioned in task (more about it in Level 19 writeup), this file is named `suconnect`

#### Let's execute it to see what it suppose to do:
`./suconnect`

Basing on output, it sends password to given port if he received correct password (from current level) on this port, futhermore the syntax looks like that:

`./suconnect [portnumber]`

#### Knowing that we can firure next things out.

This task in tricky in some way, we have to nicely understand how ports and listening on them works:

Ports are simply kind of doors where data can come in and out, you can hire a bodyguard who will control all flow through that port. This bodyguard is port listener. We can create one using `nc` (mentioned in Level 14)

Also you can't have more than one listneing/open services over one port, so choosing right port to listen/send data is half success.

#### To find nice port to test things out we can simply run nmap to check which ports we can't use because they are already open or listening:

`nmap -p- -T4 localhost`<br>

`-p-` to check all possible ports, not only mostly used  

`localhost` because we look through current machine ports

`-T4` for speed option (5 is max theoreticaly but it sometimes miss data so 4 is optimal (3 is default))

After that we got output:

```
PORT      STATE SERVICE
22/tcp    open  ssh
113/tcp   open  ident
6011/tcp  open  x11
6013/tcp  open  x11
30000/tcp open  ndmps
30001/tcp open  pago-services1
30002/tcp open  pago-services2
31046/tcp open  unknown
31518/tcp open  unknown
31691/tcp open  unknown
31790/tcp open  unknown
31960/tcp open  unknown
33687/tcp open  unknown
33705/tcp open  unknown
34613/tcp open  unknown
36779/tcp open  unknown
37015/tcp open  unknown
37553/tcp open  unknown
41327/tcp open  unknown
43077/tcp open  unknown
45853/tcp open  unknown
```

Ok that's list of ports we cannot touch so we can randomly use another BUT rememberibng one very important thing: **Normal user cannot test his things out on ports below 1024**, they are reserved for only legit services which are 100% secure, and thus you can be ensured that below port 1024, there is no hacker plugged. So let's say `2000`, it doesn't matter as long as it's not mentioned as open in above nmap scan output nor below 1024.

#### Now, when we know which port we will use to complete task, let's remind ourselves using which command we can communicate with port, or listen on it.

That's `netcat` (or `nc`), so dive down `netcat -h`, and here we go: secon line of help page describes just what we want to do:

```
...
listen for inbound:	nc -l -p port
...
```

So let's start listening on port `2000`:<br>

`nc -lp 2000`

#### After that we have to start new terminal window, wothout closing previous one (no, `nc -lp 2000 &` will not work!)

Here we have to again log into ssh for bandit20:<br>
`ssh bandit20@bandit.labs.overthewire.org -p 2220`<br>

#### Now, finally we can start work with our main file suconnect

`./suconnect 2000`

Will start an connection with port 2000, but remember, this file is only for receiving and automaticaly sending password back, no for sending data from user, you have no influence on what this file would return.

#### So we have to go back to terminal window with netcat listening

While netcat is listening, it's still possible to use it for sending data over given port. Let's do it, and type `bandit20`'s password.

This will result in next level password return. All what we just did, was sending data to port number `2000` using `netcat`, then `suconnect` received it, detected that it's valid password and send back next level password, which netcat intercepted, because it was an listenning on this port

### Additional Notes
This task is widely used in many CTF's (similiar looking tasks which want you to send, listen, and receive data over ports) so it's useful feature to remember

In this case, `setuid` wasn't important as much as in previous task, we can just notice same thing as before, we can execute this file because it's group is same as bandit20's one, and `s` indicator is set:

`groups`<br>
`ls -l`


