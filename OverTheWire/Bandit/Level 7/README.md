Level 7
======

### Task

> The password for the next level is stored in the file data.txt next to the word millionth

### Steps

#### Login to `bandit7` with password from previous level
`ssh bandit7@bandit.labs.overthewire.org -p 2220`

### We know that our password is in `data.txt` but as we can see using cat just in case:
`cat data.txt`

There is much data, so we have to automate searching

### We also know, thta our password is near 'millionth' word, that's why we use command like that:
`grep 'millionth' data.txt`

This will return all lines from file data.txt, which has 'millionth' word inside<br>
Here is our output with password near:<br>

```
millionth	HEREisPASSWORDfindITbyYOURSELF12
```

### Additional Notes:

You can use additional `awk {'print $2'}` command to automatically return just password:

`grep 'millionth' data.txt | awk {'print $2'}`

All this command do, is returning second ($3 - third, $4 - fourth ...) column of given input (in our case line with 'millionth' inside), basically awk distinguish column by tab sign, and in our case (according to test `cat` command in first step), we have pattern like: `some_word <tab> password_like_word`, where password is hidden in second column. 






