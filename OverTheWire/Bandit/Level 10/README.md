Level 10
======

### Task

> The password for the next level is stored in the file data.txt, which contains base64 encoded data

### Steps

#### Login to `bandit10` with password from previous level
`ssh bandit10@bandit.labs.overthewire.org -p 2220`

#### Viewing data.txt content:
`cat data.txt`

Results in weird string outpupt, but we know from task, thats base64 encoded data

#### So we can decode it just using as you can guess:
`base64 --decode data.txt`

I think it's really self-explaining

### Additional Notes:

Genrally `Base64` code modtly ends with `==` so in case of CTFs, you can guess, that any misterious string with ending like that is `Base64` encoded

