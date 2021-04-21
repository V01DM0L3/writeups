Level 15
======

### Task

> The password for the next level can be retrieved by submitting the password of the current level to port 30001 on localhost using SSL encryption.<br><br>
**Helpful note: Getting “HEARTBEATING” and “Read R BLOCK”? Use -ign_eof and read the “CONNECTED COMMANDS” section in the manpage. Next to ‘R’ and ‘Q’, the ‘B’ command also works in this version of that command…**

### Steps

#### Login to `bandit15` with password from previous level
`ssh bandit15@bandit.labs.overthewire.org -p 2220`

#### You need to pass message over port 30001, we know it should be passed using encrypted SSL connection. So command we are looking for is `openssl`:
`openssl s_client -connect localhost:30001`

`s_client` part means, we want to make a connection using SSL or TLS, openssl will estabilish a client which wil allow as to do so<br>

`-connect` this flag makes it possible to determine into where we want to connect.<br>

`localhost:30001` simply is like answering the question "Where you want to open connection?" - "To the port `30001` on `localhost`" in place localhost there can be for ex. ip or server DNS name.<br> 

#### After taht we will be prompted to type current password and in reward we got password to next level:

```
...more output...

    0070 - f1 06 d6 b7 9e 08 d3 05-4a a2 33 cc 12 0e 41 4c   ........J.3...AL
    0080 - 25 5d 23 75 ec ec 5a d4-13 22 de d3 58 8e 5d 63   %]#u..Z.."..X.]c
    0090 - df c5 62 3c ff c4 fc af-8a 92 6e 29 6c ec 13 29   ..b<......n)l..)

    Start Time: 1619023535
    Timeout   : 7200 (sec)
    Verify return code: 18 (self signed certificate)
    Extended master secret: yes
---
HEREisCURRENTlevelPASSWORDyouTYPED
Correct!
HEREisPASSWORDtoNEXTlevelASresponse


```

### Additional Notes:

This weird looking things, at the beginning of command output are oure cridentials and certificate which identifies us as a privilaged user to connect into given server and port, without this we will be rejected form connecting. <br>

Generally this command is similiar to netcat connection, you can also pass some data through port, but main difference is that openssl is huge functionality and can do much more things than netcat can do, and also whole connection works using encrytion and certificate which can identify only trusted users. <br>

