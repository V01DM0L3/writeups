Level 17
======

### Task

> There are 2 files in the homedirectory: passwords.old and passwords.new. The password for the next level is in passwords.new and is the only line that has been changed between passwords.old and passwords.new<br><br>
**NOTE: if you have solved this level and see ‘Byebye!’ when trying to log into bandit18, this is related to the next level, bandit19**

### Steps

#### Login to `bandit17` is more complicated, because we have to use private key verification as we did in Level 13

To do so we just to have copy output from previous level to txtx file to be sure that it is pasted in format like this:

```
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
...more of RSA key...
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----
```

Fastest way to do so is to use builded in nano text editor using whatever name for file we want:<br>

`nano private.key`<br>

This will open editor, then you can copy RSA key from ssh bandit17 ssh conection (`shift+ctrl+c` after selecting)
and then paste it into nano choosing paste over RPM button.

After that simply quit saving changes, whast will create file named `private.key`: <br>
`ctrl + S` and `ctrl + X`

#### Last thing to do is to set proper permissions to file, trying to use this key now to log into bandit17 would end up with forcin you to type password which we don't know yet.

That's because ssh verifies permissions which are linked with `private.key` file, and if they are to "open" meaning so: regular users can do too much we it, connection will fail. <br>

So to fix this we will use Linux set permissions command:<br>

`chmod 700 private.key` <br>

Misterious `700` at the end is octal number, representing permissions for:<br>

`[file owner] [file's group other memebers] [other users (owner nor group members)]`<br>

Where 7 are biggest permissions allowing this section of users, to do everything with that file (also directory, because chmod also works for folders), and 0 is no permissions even reading is permitted.

To sum up, we just gave whole perissions to file owner (one who created it) and no to others.

Whole permissions sections in Linux is very wide subject so I strongly recommend you to get know more about it on your own.

#### Now we can finally log into bandit17 using private RSA key:

`ssh -i private.key bandit17@bandit.labs.overthewire.org -p 2220` <br>

Only difference from `Level 13` logging is that we used whole domain name not localhost, because now we make a connection using key from our own machine, not OWT server.

#### Task is preety simply, we need to find difference between two files `passwords.new` and `passwords.old`;

`diff passwords.new passwords.old`

Ruuning this command will return us output:

```
42c42
< HEREisPASSWORDfindITbyYOURSELF12
---
> w0Yfolrc5bwjS4qw5mq1nnQi6mF03bii
```

Which informs us what is a new content (text after `<` character) in `passwords.new` on specified line, and which content (text after `>` character) was there before in comparison to `passwords.old`.

According to task, our password is in a line different from `password.old`, in `password.new`, and it's text after `<` sign.  

### Additional notes:

If you want to save a password to this level in case of easily connecting in the future, you can go to `/etc/bandit_pass/` dir where all passwors are stored, but can be accessed only by current user so as bandit14 we can read only bandit14's password (placed in `bandit17` file), so no cheating here ;)<br>

`cat /etc/bandit_pass/bandit17`





