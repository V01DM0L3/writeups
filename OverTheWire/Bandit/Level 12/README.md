Level 12
======

### Task

> The password for the next level is stored in the file data.txt, which is a hexdump of a file that has been repeatedly compressed. For this level it may be useful to create a directory under /tmp in which you can work using mkdir. For example: mkdir /tmp/myname123. Then copy the datafile using cp, and rename it using mv (read the manpages!)

### Steps

#### Login to `bandit12` with password from previous level
`ssh bandit12@bandit.labs.overthewire.org -p 2220`

#### Let's see what's inside data.txt
`cat data.txt`

We can see it's again weird data but there is something regular about it, from task content we can notice that it's hexdump oputput over compressed file.

Hexdump is tool which translates binary file into hexadecimal file, which is nothing more than human readable set of data addressess and it's values from binary file.

#### At first we have to revert this operation
`xxd -r data.txt data.bin`

xxd is command which can reverse file with proper hex inside to source binary file (human unreadable).<br>
`-r` flag is used for reverse operation, without it xxd would just display hex format from file.
`data.bin` it would be just our output filename, with contractual extension `.bin` because we know the output will be binary 

#### Just in case check what's inside newly converted file now
`cat data.bin`

Bingo, our hex file, now looks like typical weird looking binary file. But that's not end, you can run `strings data.bin`

#### Let's see if we accomplished task
`strings data.bin`

As you can see there is nothing special here, no password, no tips, now we can go back to task and read carefully. Our file we just got is just half-way-through, because now we have to decompress it as long as it's just archive. Ensure yourself, typing:

`file data.bin`

Yes it clearly looks like that's gzip archive.

#### Now, for comfortable work (and also because we are not allowed to create files in `~` folder), let's do additional things from task:
`cd /tmp`
`mkdir YOURname`
`cd /tmp/YOURname`

Here we can do whatever we want, create, rename, delete files etc. Now we can copy our workfile:

`cp ~/data.bin ./data.bin`

#### Finally we are ready to accomplish rest of task, try to decompress it using corresponding for this file extension:
`gzip -d data.bin`

You probably got error, and that's normal for `gzip`, it's because it could not resolve file extension, as long it's not `.gz`. So correct your mistake renaming file to proper extension and repeat command or add special flag, which allows to operate gzip on given extension (`--suffix=.bin`):

`mv data.bin data.gz | gzip -d data.gz`
or
`gzip -d --suffix=.bin data.bin`

#### Let's look around what have changed in directory
`ls -l`

It looks like we got new file: `data`, that's our decompressed file (gzip cutted off `.bin` extension in output file)

#### Ok we happily done our task let's view password
`cat data`

Ouch, that's look like another binary file :/ no password here, try to get more info about it:

`file data`

Outpupt informed us, that's another compressed file, but this time in `bzip2` format.

#### Try to decompress it using correct command
`bzip2 -d data`

There is also error, but it's nothing serious, and decompression accomplished properly. <br>
`-d` flag means decompressing operation, just like in gzip command

#### Repeat all operations again:
`ls -l`

Now it looks like new file is named `data.out`, do check it's format, in hope that it will be ascii type

`file data.out`

Unfortunately we have compressed file again, and again in `gzip`,
so repeat decompression using correct extension:

`gzip -d --suffix=.out`

#### And again: look for results, check file format look for corresponding archive command...

##### Rep 1
`ls -l`
`file data`

Now something new: it's tar compressed, so type corresponding command:

`tar --extract -f data`

This new command works slightly different, you have to use two flags:<br>
`--extract` for decompress action<br>
`-f` to give file as input for `tar` command

##### Rep 2

`ls -l`
`tar` command, do not overwrite, or remove source file, it creates new ones, those which was compressed (in past case data5.bin)

`file data5.bin`
`tar --extract -f data5.bin`

##### Rep 3
`ls -l`
`file data6.bin`
`bzip2 -d data6.bin`

##### Rep 3
`ls -l`
`file data6.bin.out`
`tar --extract -f data6.bin.out`

##### Rep 4
`ls -l`
`file data8.bin`
`gzip -d --suffix=.bin data8.bin`

##### Rep 5 - Last
`ls -l`
`file data8`

Here it go, finally output we longed for - ASCII file fromat

#### Let's get our password from it:
`cat data8`

### Additional Notes:

This whole operations were very annoying, so much checking and repetitions, in cases like that it's useful to write `.sh` scripts which can automate all this tasks.
Here is script which automates whole process from text file with hex format, all way through to password display:

```shell
#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo "Too few arguments, Use pattern like: bash script.sh [txt_file_with_hexdump_inside]  Exiting script..."
    exit -1
fi

mkdir output
cd ./output
cp ../$1 .
file_name=$1
xxd -r $file_name $file_name.bin
file_name=$1.bin

while true; do
	if [[ $(file $file_name | grep -i " gzip") ]]; then
		echo "gzip archive!"
		mv $file_name $file_name.gz
		gzip -d $file_name.gz
	elif [[ $(file $file_name | grep -i " bzip2") ]]; then
		echo "bzip2 archive!"
		mv $file_name $file_name.bzip2
		bzip2 -d $file_name.bzip2
	elif [[ $(file $file_name | grep -i " tar") ]]; then
		echo "tar archive!"
		mv $file_name $file_name.tar
		tar --extract -f $file_name.tar
	elif [[ $(file $file_name | grep -i " ASCII") ]]; then
		echo "ASCII file!!!"
		cat $file_name
		break
	else
		echo "can't operate on $file_name, unknown condition!"
		cat $file_name
		break
	fi
	
	file_name=$(ls -l | awk {'print $8, $9'} | sort -k 1 -r | head -n 1 | awk {'print $2'})
	
done

```

