Level 11
======

### Task

> The password for the next level is stored in the file `data.txt`, where all lowercase (a-z) and uppercase (A-Z) letters have been rotated by 13 positions

### Steps

#### Login to `bandit11` with password from previous level
`ssh bandit11@bandit.labs.overthewire.org -p 2220`

#### Firstly let's see what's inside:
`cat data.txt`

Yes, output looks weird, just like output of cesar-like cipher encrytpted, in our case it's ROT13, the case when we replace every character with another, 13 places away (alphabet is repetitous so 't' would be 'g').

We can try to decrypt it manulally translating each character to another, 13 before in repetitous alphabet, but that's not a point of this task.

Everything we have to do manually is to count what character would be corresponding for a and z, and it looks like it's n and m.

#### To deal with that, we use `tr` command, made for translating given characters to another
`cat data.txt | tr [a-zA-Z]' '[n-za-mN-ZA-M]'`

Firstly we pass our file through pipeline to `tr` command using `cat` and `|`

Now the output of `cat` command became input of `tr`, so all we have to do is to properly configure tr `parameters`.

To do so, we use pattern like that: 
`tr [translate_from] [translate_to]`
Knowing that, when we use `tr '[a-zA-Z]' '[n-za-mN-ZA-M]'`,
we just tells `tr` command: 'Trasnslate a-z and A-Z range characters, to n-m and N-M)'. We have to split this ranges for 4 because it's incorrect type range n-m, that's why we typed n-za-m.

### Additional Notes:

You can use `tr` to translate almost everything to everything, for example another useful option is translation from lowercase to uppercase:
`tr [:lower:] [:upper:]`
or numbers to letters:
`tr [0-9] [a-z]`

Remember that range of characters we translate from, only translates to max range from left to right, so even if we typed a-z in upper command, 0-9 would translate to a-j range only, because j is 10th letter and in case like below:
`tr [0-9] [a-eA-E]`
We would get 0-4 translated to a-e and 5-9 into A-E   

