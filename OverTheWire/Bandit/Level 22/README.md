Level 22
======

### Task

> A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.<br><br> **NOTE:** Looking at shell scripts written by other people is a very useful skill. The script for this level is intentionally made easy to read. If you are having problems understanding what it does, try executing it to see the debug information it prints.

### Steps

#### Login to `banditX` with password from previous level
`ssh bandit22@bandit.labs.overthewire.org -p 2220`

#### This task is very similiar to previous one so for more detailed instruction about cron itself go to level 21's writeup

What we have to do from beggining is to view cronjob for bandit23: <br>

`cat /etc/cron.d/cronjob_bandit23`

According to output:

```
@reboot bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null
* * * * * bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null
```

There is script runned every reboot as an bandit23

#### This script is placed in /usr/bin/ so let's got here and read this file
`cd /usr/bin/`
`cat cronjob_bandit23.sh`

Output looks as it follows:

```
#!/bin/bash

myname=$(whoami)
mytarget=$(echo I am user $myname | md5sum | cut -d ' ' -f 1)

echo "Copying passwordfile /etc/bandit_pass/$myname to /tmp/$mytarget"

cat /etc/bandit_pass/$myname > /tmp/$mytarget
```

It's bigger script than before but still rather simple to analyze:

`myname=$(whoami)`<br>
Declares new variable named `myname` which is name of user running this script (`whoami` command). We already know according to corresponding file in cron.d, that this script is runned as bandit23. So this variable almost for sure would be `bandit23`.

`mytarget=$(echo I am user $myname | md5sum | cut -d ' ' -f 1)`<br>
This line is more complicated, it's variable declaration, which value is output of 3 piped commands:<br>

`echo I am user $myname` simply prints "I am user (and here goes value od $myname variable, which is bandit23)" so final `echo` command output is
`I am user bandit23`.

`md5sum`<br> Then this message is hashed by md5 algorithm, remember that hash functions are one way, that means you can't decrypt it to get known what data was inputed at beggining. But checksum (hash) is same for same data inputed so if you input x message you will get y checksum, and when someone would use md5 again on same x message anytime, anywhere he should also get y checksum.
So generally this command creates md5 checksum out of `I am user bandit23`.

`cut -d ' ' -f 1` <br> Then created hash, is prepared to strip it from any unwanted characters, that's why we use cut comand to get only first field out of divided by ' ' fields, and that's our raw checksum  

Final ouptut is saved to `$mytarget` variable

`echo "Copying passwordfile /etc/bandit_pass/$myname to /tmp/$mytarget"` Is just a comment which prints on screen while script is executed. It yust spoil us what next line is going to do:

`cat /etc/bandit_pass/$myname > /tmp/$mytarget` means, password of bandit23 is read and outputed into temporatyy file which name is equal ro `$mytarget` variable. In another words, bandit23's password is coppied to temporary file, named by checksum of `I am user bandit23`.

#### Now when we know how this script works, just simulate it's execution typing in terminal everything we know: 
`echo I am user bandit23 | md5sum | cut -d ' ' -f 1`
<br>

Thanks that command, we got our checksum in return:<br>
`8ca319486bfbbc3663ea0fbe81326349`

Let's simulate second step which is reading correct temporal file over `/tmp/8ca319486bfbbc3663ea0fbe81326349`:<br>
`cat /tmp/8ca319486bfbbc3663ea0fbe81326349` 

#### That's it, as an output we got password for next level


### Additional Notes:

You can also use one command to complete whole last step:
`cat /tmp/$(echo I am user bandit23 | md5sum | cut -d ' ' -f 1)`<br>

Which simply treats `echo I am user bandit23 | md5sum | cut -d ' ' -f 1`'s output, as an temporal variable which dies with command completion in terminal.
 



