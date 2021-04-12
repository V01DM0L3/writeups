Level 9
======

### Task

> The password for the next level is stored in the file data.txt in one of the few human-readable strings, preceded by several ‘=’ characters.

### Steps

#### Login to `bandit9` with password from previous level
`ssh bandit9@bandit.labs.overthewire.org -p 2220`

#### Let's see how our `data.txt` file looks:
`cat data.txt`

That was really bad idea, now our terminal is full of weird characters, that usually means we are dealing with binary file, which mostly unreadable for human

#### We can ensure about that, using `file` command:
`file data.txt`

And as we can see it's `data` fileformat (not `ASCII text` as it would be at normal human-readable text file)

#### To deal with it we can try searching for hidden text inside file, among all this weird characters, again it's pointell to look through this manualy so:
`strings data.txt`

Will do what we need, that's what strings command is for, searching readable content among unreadable data in binary files<br>
Result:

```
Z/,_
WW"&8
2Qk)
xWa_
... more output ...
}1:LF
]vur
Emlld
&========== HEREisPASSWORDfindITbyYOURSELF12
_Gmz
\Uli,
... more output ...
P"`\XZ
1KOA
```

This whole output consist of readable strings, of length 4+ which occur in given file.

#### Task is done but to avoid manual search we can grep result according to task condition about several `=` character prefix:

`strings data.txt | grep '=='`

### Additional Notes:

As you can see from the upper example, never suggest on file extension, while you works in Unix system, here extensions in filename are just tips and they don't have to say truth about real file format, in this case `.txt` was only deception from real binary file format of `data.txt`

This type of tasks is widely known on CTF tournaments, as **Forensics** category.<br>
In shortcut, it's soaking useful data or CTF flag from files which looks unreadable, or normally(photos, docs, audio etc.)

