Level 6
======

### Task

> The password for the next level is stored somewhere on the server and has all of the following properties: <br><br>
owned by user bandit7<br>
owned by group bandit6<br>
33 bytes in size


### Steps

#### Login to `bandit6` with password from previous level
`ssh bandit6@bandit.labs.overthewire.org -p 2220`

#### We don't know in which folder password is, so we can go back to `/`:
`cd /`

#### Then we can use one-line command to get what we want:
`find -size 33c -user bandit7 -group bandit6 -execdir cat {} \;`

Breaking down this command for partts we get: <br>
`-size` for 33 Bytes size condition<br>
`-user` for owner condition<br>
`-group` for owning group condition<br><br>
`-execdir` is interesting one, it allows us, to run command for all single found paths meeting conditions, which are indicated as `{}` (in the `-execdir` syntax). Translating it to basic pieces, `-execdir cat {} \;` means do `cat` on every found instanece (READ WARNING IN ADDITIONAL NOTES)

#### Looking through our output we can see there is many errors, but among them we can notice one result looking quite normal, that's our password:

```
find: ‘./root’: Permission denied
find: ‘./home/bandit28-git’: Permission denied
find: ‘./home/bandit30-git’: Permission denied
find: ‘./home/bandit5/inhere’: Permission denied
find: ‘./home/bandit27-git’: Permission denied
... other error messages ...
find: ‘./var/lib/apt/lists/partial’: Permission denied
find: ‘./var/lib/polkit-1’: Permission denied
HEREisPASSWORDfindITbyYOURSELF12
find: ‘./var/log’: Permission denied
find: ‘./var/cache/apt/archives/partial’: Permission denied
find: ‘./var/cache/ldconfig’: Permission denied
```

### Additional Notes:

As you can see this method can work only for quite small results amount, but what if we have to look around huge found data.

Thats why we can look through results and exclude all errors using operation called **stderr redirection**.
Here is our one liner returning raw password without errors:

`find -size 33c -user bandit7 -group bandit6 -execdir cat {} \; 2>/dev/null`

Strange looking `2>/dev/null` is nothing more than just telling to terminal "Redirect all results ended with error (and only them) to something like a system trash or void. And return only useful no-error data as terminal output". We can do something reverse using `1>/dev/null` in this case we redirtect all good results to the void, we can place any file after `>` it not have to be `/dev/null` you can do something like `2>errors.txt` (but not in here, on OWT warzone, in `/` you have no permissions to create new files)

#### WARNING
Be aware that you shouldn't use `-execdir` if you don't know what can be outputed, as long as `cat` command is nothing aggresive and in the worst case can spam your terminal with too much output, using `rm` or `mv` commands can cause serious damage to system, especially when you use it from `/` directory 









