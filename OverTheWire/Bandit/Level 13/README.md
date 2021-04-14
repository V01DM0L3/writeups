Level 13
======

### Task

> The password for the next level is stored in /etc/bandit_pass/bandit14 and can only be read by user bandit14. For this level, you don’t get the next password, but you get a private SSH key that can be used to log into the next level. Note: localhost is a hostname that refers to the machine you are working on

### Steps

#### Login to `bandit13` with password from previous level
`ssh bandit13@bandit.labs.overthewire.org -p 2220`

#### This looks different than other taks, main point is not to get the password but to figure out how to connect to ssh using ssh key

#### Let's see what's inside home directory and try to view it:
`ls -l` <br>
`cat sshkey.private`

Ok that's weird file you have to assume, but here I go with help for you. This file have something what is called ssh key. inside, this misterious things is basically unical key, you can interpretate it's like a physical door key, which allows us to go wherever we want if this "doors" we want to open, knows that we are allowed to get in. So basically, the host we want to connect to, stores our identity (in this case bandit13 ssh user) knowing that this particular user is allowed to get in but, only if he use correct key to open the doors, and this correct key is stored in our `sshkey.private` file <br>

So everything we have to do, is to try access next level but not with typical password authentication. We have to use this sshkey

#### The command which allows us to do so is:
`ssh -i ./sshkey.private bandit14@localhost` <br>

`-i` means identity file flag, which we use to connect via some kind of file identifying us, in this case it's `sshkey.private` stored in home bandit13's directory <br>
`bandit14@localhost` this last statement simply points on "doors" we want to open, and this doors are access to `bandit14` user, which exist on `localhost`, meaning same machine we are logged into but, other user. <br>
If any error prompt just type `yes`, it should work, regardless this inconvinience. 

### Additional Notes:

After This we can jump to `/etc/bandit_pass/` dir where all passwors are stored, but can be accessed only by current user so as bandit14 we can read only bandit14's password (placed in `bandit14` file), so no cheating here ;)<br>

`cat /etc/bandit_pass/bandit14`

  





