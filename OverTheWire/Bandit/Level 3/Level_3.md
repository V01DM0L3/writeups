Level 3
======

### Task

> The password for the next level is stored in a hidden file in the `inhere` directory

### Steps

#### Login to bandit3 with password from previous level
`ssh bandit3@bandit.labs.overthewire.org -p 2220`

#### Desired file is hidden in `inhere` dir, so go there
`cd inhere`

#### Then you have to look for hidden files using
`ls -al`

`-a` *is for all files including `..` `.` and hidden ones(starting with `.`)* <br>
`-l` *is for pretty lsit-like results display*

It looks like our desired file is `.hidden`

#### Just display `.hidden` using normal `cat` command:
`cat .hidden`




