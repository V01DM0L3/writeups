Level 0
======

### Task

> The password for the next level is stored in a file called `readme` located in the home directory. Use this password to log into bandit1 using SSH. Whenever you find a password for a level, use SSH (on port 2220) to log into that level and continue the game.

**User:** bandit0

**Password:** bandit0

### Steps:

#### SSH login as `badit0`:
`ssh bandit0@bandit.labs.overthewire.org -p 2220`

#### Looking for readme file:
`ls -l`

#### Viewing readme file
`cat readme`

### Additional notes:

`file <filename>` - returns type of given file, 
example output: `readme: ASCII text`

`du <filename>` - returns estimated file size (default in Bytes) 
example output: `4	readme`

`find -iname <fielname>` - searches for file name, even in subdirectories example output: `readme` (because we are in it's directory so there is no slashes needed)







