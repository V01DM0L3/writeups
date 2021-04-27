Level 14
======

### Task

> The password for the next level can be retrieved by submitting the password of the current level to port 30000 on localhost.

### Steps

#### Login to `bandit14` with password from previous level, or using ssh as mentioned in previous writeup
`ssh bandit14@bandit.labs.overthewire.org -p 2220`

#### The task points, that we should send our password via port 30000, the command, wchich can do so:
`telnet localhost 30000`

Telnet is unsecured protocole, used for remote access or as in this case, sending data to given port, in our case to `localhost` over port `30000`

#### When dash will prompt it means, the connection waits for our meessage, so we can now paste password and hit enter, in response we get reply from port 30000 with password 

### Additional notes 

We also can use one `nc` command for this task, which can be even better, because we can use a pipeline with that so it means we will get answer without prompt for bandit14 password:<br>
`echo "HEREisPASSWORDfindITbyYOURSELF12" | nc localhost 30000`

`nc` stands for netcat, which is something different than telnet, because we can't connect to remote shell as it works in `telnet` (basically ssh is something like secured telnet but it's realy basic explaination).

We generally use nc to send or receive data remotely to/from given port (that's exactly what we had to do in this task)


