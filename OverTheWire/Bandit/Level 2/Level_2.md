Level 2
======

### Task

> The password for the next level is stored in a file called `spaces in this filename` located in the home directory

### Steps

#### Login to `bandit2` with password from previous level
`ssh bandit2@bandit.labs.overthewire.org -p 2220`

#### Search for desired `spaces in this filename` file:
`find "spaces in this filename"`

It is inside current dir, so you can view it

#### To view files with space inside names, you can use regular `cat` command:
`cat "spaces in this filename"`




