

Level 19
======

### Task

> To gain access to the next level, you should use the setuid binary in the homedirectory. Execute it without arguments to find out how to use it. The password for this level can be found in the usual place (/etc/bandit_pass), after you have used the setuid binary.

### Steps

#### Login to `bandit19` with password from previous level
`ssh bandit19@bandit.labs.overthewire.org -p 2220`

#### That looks tricky, on the first seen we have the file to execute so let's execute it:
`./bandit20-do`

Output is something like that:

```
Run a command as another user.
  Example: ./bandit20-do id

```

What means we don;t have password :/<br>

But after task analysing we can get known that this file it's something misteriously called like `setuid binary`<br>

To simply explain you what `setuid` is: This is kind of sepcial permissions for executable file which allows any user who has executable permission on this file, to be for a moment treated by a system like an owner of that file, yes seems complicated, but I ensure you it isn't, maybe this task example will clear things out.

#### Firstly just in case let's check what `file` command will return:

`file ./bandit20-do`

output:
 
```
./bandit20-do: setuid ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=8e941f24b8c5cd0af67b22b724c57e1ab92a92a1, not stripped
```

Yep, that's `setuid executable` indeed

#### Now we can start task compleating:

We know that all passwords are saved in `cat /etc/bandit_pass/banditX` where `X` stand for current level. But we also know that only same level user can open it's password file, so we generally can't view `bandit20` as a current `bandit19` user, **BUT** we have that magic `setuid executable`, explained before. So we can simply run `cat /etc/bandit_pass/bandit20` as `bandit19` via `./bandit20-do` execution, and it look just like that:

`./bandit20-do cat /etc/bandit_pass/bandit20`

What means we just executed `./bandit20-do` which makes us `bandit20` user for a moment, and then we executed `cat` command in `./bandit20-do` file's runtime, what ended up with correct reading of `bandit20` and getting password.

### Additional Notes:

You should know, that in this task that's only creator's kindness to tell you the truth about this executable, during CTF's or vulnerability looking (because it can be serious case of permission leak when some kind of `setuid` excecutable file is shared to unpermitted users) you ahve to get known that it's `setuid` by yourself. You can do so by `file` command as we did before, or viewing extended `ls -l` to see files permissions which is more reliable method, we simply looks for `s` letter in owner's permissions section instead of normal `x` : <br> 

`-rwsr-x--- 1 bandit20 bandit19 7296 May  7  2020 bandit20-do`

`-rwsr-x---` is permissions and type section, where:<br>

First `-` stands for indicator of file type, for example if it's not normal file buit for example directory there would be a `d` (for directory), that's because in Linux everything is a file, even connected devices or ports

Next 9 places are users' permissions, grouped by 3, 
in order mentioned in Level 17. Knopwing that we can see that we have `rws` in palce of owner's permissions, and this `s` is our `setuid` indicator, normally if it's wouldn't be an `setuid`, there would be an `x` which stands for execute permission.

But that's not everything `setuid` not always allows everyone to be as a file's owner. It works only for users which are in permissions group where is `x` looking for upper section, we can see taht for other users (last 3) there is no `x` what means it;s not just as simple.

We have `x` in the middle 3 section which stand's for group's section. There we have permissions for users which are in the same group as file's group.

So generally we can execute that file but only if we are a same group member as file's. Check which group/s member current user is:

`groups` <br>

It seems like we are also bandit19 group member.<br> 

Now let's check `./bandit20-do` file's group and owner, it was the second and first column in `ls -l` output:

`-rwsr-x--- 1 bandit20[owner] bandit19[group] 7296 May  7  2020 bandit20-do`<br>

or we can use:<br>

`stat -c "%U:%G" ./bandit20-do`<br>

and we got output: <br>

`bandit20:bandit19` <br>

stat is generally useful so I recommend you to dive down `man stat` but to explain this case we simply asks `stat` command to return file's user and group in syntax like `user:group` (`-c "%U:%G"` section) on file `./bandit20-do`

What means it's `bandit20`'s (owner) file and it belongs to `bandit19` group.

Bingo! our user is also `bandit19`'s group member, and that's only why we could execute that file as `bandit19` user (for ex. `bandit18`'s group member and any other couldn't do that, but they would if `x` indicator was in last permissions section) 




