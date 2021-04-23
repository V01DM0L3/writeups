Level 18
======

### Task

> The password for the next level is stored in a file readme in the homedirectory. Unfortunately, someone has modified .bashrc to log you out when you log in with SSH.

### Steps

#### In this task again login into ssh isn't so easy as it is mentioned in task, we can't get into ssh, all we get is `Byebye!`
`ssh bandit18@bandit.labs.overthewire.org -p 2220`

We need to figure out how to pass a command to ssh without entering to ssh connection, but inputting password.

#### Seems complex, but it's very easy task:
`ssh bandit18@bandit.labs.overthewire.org -p 2220 'cat readme'`

We have to input credentials, and we did not estabilished ssh connection, but we get content of readme file, as an output.

It works just like passing messages in previous Levels, but in this case we not only pass regular text message, we prcticaly pass command to execute, and we can type in `' '` whatever command we want and it would work exactly same as during estabilished connection.

### Additional notes

You have to remember that it's only one way run, and after passing a command you are logged out again so to avoid blocking our ip for too much logons in time period, it's important to test passing commands previously, to be sure it will do whole task in as few runs, as it's possible idealy we want it work in one run.





