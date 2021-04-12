Level 8
======

### Task

> The password for the next level is stored in the file data.txt and is the only line of text that occurs only once

### Steps

#### Login to `bandit8` with password from previous level
`ssh bandit8@bandit.labs.overthewire.org -p 2220`

### As always let's see how our `data.txt` file looks:
`cat data.txt`

Looking on output we know that it's impossible to guess which line occurs only once

### So we type something like that:
`cat data.txt | sort | uniq -u`

`sort` as the name suggest, sorts output lines ascending, this command is must have if we want to use our next command in pipeline: <br>
`uniq` this one, normally returns lines without repetition, so if we have 10 lines like: 123456, `uniq` will return only one line 123456 as representation of them all, signalising that 123456 exist. <br>
But here we have `-u` flag, which do exactly what we need for our task: returning literally unique lines, which occurs only once in whole input, and thats our password.

 






