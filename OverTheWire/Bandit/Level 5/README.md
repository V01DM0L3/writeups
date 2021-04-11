Level 5
======

### Task

> The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties: <br><br>
 human-readable <br>
 1033 bytes in size <br>
 not executable

### Steps

#### Login to `bandit5` with password from previous level
`ssh bandit5@bandit.labs.overthewire.org -p 2220`

#### Desired file is placed in inhere dir, so go there
`cd inhere`

#### Just in case, list all files in tree like view: (because our file is buried deep inside subdirectories)
`ls -Ral`

`-R` *stands for tree like view* <br>
`-a` *for all files includeing `.` `..` and hidden* <br>
`-l` *for list view*

There is many files so it is pointless to check every single one

#### So we use find command with flags we need:
`find -readable -size 1033c ! -executable`

`-readable` *stands for finding human-readable files* <br>
`-size 1033c` *stands for finding 1033 Bytes in size files, where c means Bytes size unit* <br>
`! -executable` *stands for finding not executable files, where ! means test's negation so we get non-executable files result* <br>

#### Our output:
`./maybehere07/.file2`

#### Just display .file2 using normal cat command:
`cat ./maybehere07/.file2`




