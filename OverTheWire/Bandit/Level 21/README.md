Level 21
======

### Task

> A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.

### Steps

#### Login to `bandit21` with password from previous level
`ssh bandit21@bandit.labs.overthewire.org -p 2220`

#### Let's go to place where task leads us:
`cd /etc/cron.d`<br>

Now check what's inside<br>
`ls -al`<br>

We have interesting files here, some related to bandit 15, another one connected with bandit23 and so on, but for us, bandit22 is super interesting.

#### Read `cronjob_bandit22` file
`cat cronjob_bandit22`<br>

This will return following output:

```
@reboot bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
* * * * * bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
```
<br>

What we can get known from here is path `/usr/bin/cronjob_bandit22.sh`, it look s like there is something what might help us.

To mention you more `@reboot bandit22` states for "Do following action as `bandit22` user" in our case this "action" is bash script probably hidden over mentioned path.

#### So go to that location and view `cronjob_bandit22.sh` script
`cd /usr/bin`
`cat cronjob_bandit22.sh`<br>

Output looks like that:

```
#!/bin/bash
chmod 644 /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
cat /etc/bandit_pass/bandit22 > /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
```

Yep it definitely looks like bash script, so let's analyze it:

`chmod 644 /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv`<br> 
gives permissions of level 6 for file creator, not enough interesting, but permission of level 4 for group members and others means, that we can open this file, and maybe there is something helpful

`cat /etc/bandit_pass/bandit22 > /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv` <br> 
Bingo, here we have most important part.  it looks like this script, which is executed on every boot, reads password for bandit22 and saves it to mentioned temporary file, which as we researched before, can read.

So here we have conclusion: we can simply read file `t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv` in `/tmp` directory, and this is password for next level

#### Get password:
`cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv` 

### Additional Notes:

It could be missleading that filename `t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv` looks very similiar to password but it doesn't work, you can check, sometimes it's done on purpose to mislead you, to make you think that's dead end of this idea, but as you can see it wasn't.

This type of task is very basic example of **reverse engineering**, it's name is very selfexplainatory but to complete definition: This is simply reading code or binary files, or even reading code from assembler level to get known what it generally do. Very common on CTF's and also one of my favourite branches.


