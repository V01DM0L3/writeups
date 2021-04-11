Level 4
======

### Task

> The password for the next level is stored in the only human-readable file in the inhere directory.

### Steps

#### Login to `bandit4` with password from previous level
`ssh bandit4@bandit.labs.overthewire.org -p 2220`

#### Desired file is placed in inhere dir, so go there
`cd inhere`

#### Just in case, list all files:
`ls -al`
As you can see, files starts with '-' sign so we have to figure it out.

#### Then you have to get know, which of these files is human readable format
`file ./*`

`*` *means, that we search all names in selected directory*<br>
`./` *means current directory*

#### Looking aroud output:
```
./-file00: data
./-file01: data
./-file02: data
./-file03: data
./-file04: data
./-file05: data
./-file06: data
./-file07: ASCII text
./-file08: data
./-file09: data
```

We can notice that only one is in human-like format (bold one) it's `-file07`

#### Just display `-file07` using normal cat command: (remember about `-` sign)
`cat ./-file07`


### Additional notes:

For human-readable files search you can also use `find` command:
`find -readable`



