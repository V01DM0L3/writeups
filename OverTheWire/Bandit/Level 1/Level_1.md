Level 1
======

### Task

> The password for the next level is stored in a file called - located in the home directory 

### Steps

#### Login to `bandit1` with password from previous level
`ssh bandit1@bandit.labs.overthewire.org -p 2220`

#### Search for desired `-` file:
`find ‘-’`

It is inside current dir, so you can view it

#### To view files with '-’ like names, you have to use stream sign `<`:
`cat < '-'`

### Additional Notes:

You can also use `cat ./-` and this is more universal method which works also for `file` command 


 







