# Introduction to Linux 
### Author: Karen McLuskey
#### Contact: Karen.McLuskey@glasgow.ac.uk



## Introduction

Linux is widely used in biological and biomedical research for accessing research servers, managing large datasets and running bioinformatics software.

In this tutorial, you will connect to a Linux server and learn how to interact with it using the command line. 

The aim of the tutorial is to develop confidence working at the command line and to provide a foundation for using Linux. 

### Connecting to the Linux Server

In this course, we will use the MobaXterm application to connect to the Alpha2 Linux server. Please use the provided username and password to log in to your account.

> Open MobaXterm → Sessions → New Session → SSH → Enter the remote host and username → OK → Enter password

> **Note:** Note you won't see your password when you type it. You can copy and paste it into the terminal but make sure you don't grab any white spaces.



### The Terminal

The terminal is a window where you can type commands and interact with a Linux computer. The command line provides a fast and flexible way to navigate files, manage data and run bioinformatics software. 

#### The Terminal Prompt

A typical Linux prompt looks like:

```bash
username@alpha2:~$
```

| Part       | Meaning                              |
|------------|--------------------------------------|
| `username` | Your username                        |
| `alpha2`   | Server name                          |
| `~`        | Your home directory                  |
| `$`        | The prompt (where you type commands) |

The `~` symbol is a shortcut for your home directory. When you first log in, you will usually start in your home directory.

### Linux Command Structure

Most Linux commands follow a similar structure:

```bash
command [option(s)] [argument(s)]
```

| Part     | Purpose                                   |
|----------|-------------------------------------------|
| Command  | Specifies the program to run              |
| Option   | Modifies how the command behaves          |
| Argument | Specifies what the command should work on |

For example:

```bash
ls -l results.txt
```

| Part     | Example       |
|----------|---------------|
| Command  | `ls`          |
| Option   | `-l`          |
| Argument | `results.txt` |

A command may be used on its own, or with one or more options and/or arguments.

> **Tip:** Typing `man <command_name>` displays the manual page for a command. The manual contains information about the command, its options and how to use it. Press `q` to exit.

### Linux Keyboard Shortcuts 

Linux offers many keyboard shortcuts that can save time and reduce typing. Below are a few of the most useful shortcuts to get started.

```bash
Up/Down arrows    Previous commands
Tab               Auto-complete commands and filenames
Tab Tab           Show available completions
Ctrl+A            Move cursor to start of line
Ctrl+E            Move cursor to end of line
Ctrl+C            Stop a running command
Ctrl+D            Logout / exit the shell
```

> **Tip:** Experienced Linux users rely heavily on Tab completion to avoid typing long file and directory names. Whenever possible, try using the Tab key rather than typing names in full.


### Further Reading

The workshop is designed for complete beginners and no prior Linux experience is required. However, if you would like some additional background or would like to continue learning after the course, the following resources are recommended.

- [UNIX Tutorial for Beginners](http://www.ee.surrey.ac.uk/Teaching/Unix/)
- [Linux Journey](https://linuxjourney.com)
- [Linux Tutorial (GeeksforGeeks)](https://www.geeksforgeeks.org/linux-unix/linux-tutorial/)
- [Linux Command Cheat Sheet](https://files.fosswire.com/2007/08/fwunixref.pdf)


# Tutorial

## Finding your way around

### Where am I?

Directories are the Linux equivalent of folders on a Windows PC or Mac. Directories can contain files and other directories, allowing information to be organised in a hierarchical structure.

The directory you are currently working in is known as your **current working directory**. To find your current working directory, use the `pwd` command (**print working directory**).

From now on, whenever you see a command in a grey box, try entering it at the command line.

```bash
pwd
```

You should see:

`/home4/your_username`

### What is in here?

The `ls` command lists the contents of a directory. It can be used to view files and subdirectories within your current working directory.

```bash
ls
```

What do you see?

<details>
  <summary>Expected output</summary>
```
```
</details>

<details>
  <summary>Help!</summary>
You shouldn't see any output as your home directory is currently empty 😅
</details>

### Create a new directory

Use the `mkdir` command (**make directory**) to create a new directory called `linux_tutorial`.

```bash
mkdir linux_tutorial
```

Check that the directory was created:

```bash
ls
```
You should see the directory:

`linux_tutorial`

### Changing directory

Use the `cd` command (**change directory**) to move between directories.

Move into the directory you just created:

```bash
cd linux_tutorial
```

Check your new location:

```bash
pwd
```

You should see:

`/home4/your_username/linux_tutorial`

You are now in a subdirectory of your home directory called `linux_tutorial`.

While you are here, create a directory to store some text files. Let's call it `text_files`, then change into it so that your current working directory is:

`/home4/your_username/linux_tutorial/text_files`

<details>
  <summary>Help</summary>

```bash
mkdir text_files
cd text_files
```

</details>

You are now two directories **below** your home directory. Let's go home.

### Moving Around the Directory Structure

The `cd` command can be used with special shortcuts to move around the directory structure.

| `cd` | Takes you home |
| `cd ~` | Go to your home directory |
| `cd ..` | Go up one directory |
| `cd directory_name` | Change into a named directory |
| `cd ../..` | Go up two directories |
| `cd ../directory_name` | Go up one directory and enter a sibling directory |
| `cd .` | Stay in the current directory |

##### Practise

It's very useful to practice moving around directory structures. Here are a few simple tasks to help you get familiar with changing directories.

```bash
cd
pwd
```
Output:
`/home4/your_username`

```bash
cd linux_tutorial/text_files
pwd
```

Output:
`/home4/your_username/linux_tutorial/text_files`

```bash
cd ..
```
What do you expect your current working directory to be?

<details>
  <summary>Output</summary>
You have moved up one directory so you are now in the linux_tutorial directory.
```bash
pwd 
```

`/home4/your_username/linux_tutorial`

</details>

Q. What is in the linux_tutorial directory?

<details>
  <summary>Answer</summary>

```bash
ls
```
`text_files`
</details>

Okay - Let's go back in to your home directory.

<details>
  <summary>How do I do that?</summary>

These will all take you home from the linux_tutorial folder
```bash
cd
cd ~
cd ../
```
> **Note:**There is often more than one way to reach the same location in Linux.
</details>


### Creating, Copying and Removing Files

#### Copying

The `cp` command (**copy**) is used to make a copy of a file.

| Command                      | Meaning                                |
|------------------------------|----------------------------------------|
| `cp file.txt newfile.txt`    | Copy a file                            |
| `cp file.txt directory_name` | Copy a file into a directory           |
| `cp path/file.txt .`         | Copy a file into the current directory |
| `cp * directory_name`        | Copy multiple files                    |

💡 Remember:
- `~` represents your home directory.
- `.` represents the current directory.
- Use `pwd` if you are unsure where you are.

##### Practise

Here you are going to copy three text files from `/home4/VBG_data/Linux_26` into your `text_files` directory from three different starting locations:

Let's first check what is in this dir:
```bash
ls /home4/VBG_data/Linux_26
```
Answer:

`Exercises  human_viruses.txt  outbreak.csv  SARS-CoV-2.fa  test_files`

Now let's copy each of the text files from a different starting location:

1. Go into your `text_files` directory and copy `human_viruses.txt` from `Linux_26` into `text_files`
2. Go into `Linux_26` and copy `outbreak.csv` into your `text_files` directory  
3. From your home directory copy `SARS-CoV-2.fa` into your `text_files` directory 

Starting from your home directory:

How to: Practise challenge 1:

First check what is in the directory you are going to copy from:

```bash
ls /home4/VBG_data/Linux_26
```
Change dir to `text_files`
Then copy `human_viruses.txt` from `VBG_data/Linux_26` to your `text_files` directory


```bash
cd linux_tutorial/text_files/ 
cp /home4/VBG_data/Linux_26/human_viruses.txt . 
ls 
```
> **Note:**
> 
> The dot (`.`) means "the current directory" (👇 to here).
> 
> Use `ls` to check that the file has been copied to the correct location.
> 
How to: Practise challenge 2:

Go into `home4/VBG_data/Linux_26` and copy `outbreak.csv` into your `text_files` directory

`
```bash
cd /home4/VBG_data/Linux_26
ls 
cp outbreak.csv ~/linux_tutorial/text_files/ 
ls  ~/linux_tutorial/text_files/. 
```
>  **Note:**
> 
> ls (1): Look around and see what is here
> ~ is used for your home dir
> ls (II): Check the files have been copied


How to: Practise challenge 3:

From your home directory copy `home4/VBG_data/Linux_26/SARS-CoV-2.fa` into your `text_files` directory - try it without the Help box.
<details>
  <summary>Help</summary>

```bash
cd (take me home)
cp /home4/VBG_data/Linux_26/SARS-CoV-2.fa linux_tutorial/text_files
```
<details>

Check that you have all the files:

```bash 
ls linux_tutorial/text_files/
```
Expected output:
`human_viruses.txt  outbreak.csv  SARS-CoV-2.fa`




#### Tab completion

Typing out longer file names can be boring, and you are likely to make typos that will, at best, make your command fail with a strange error and, at worst, overwrite some of your carefully crafted analysis. 

Tab completion is a trick that typically reduces this risk significantly. Instead of typing out `ls LinuxExamples`, try typing `ls Li` and pressing the Tab button (instead of Enter). The rest of the folder/file names that begin with `Li` should be auto-completed.
### Info

| Terminology | Description                                                                                 |
|-------------|---------------------------------------------------------------------------------------------|
| Linux       | Unix derivative, most popular variant of Unix                                               |
| OS          | Software that commands the hardware and make the computer work                              |
| Ubuntu      | Free Linux distribution (distro) based on Debian (an oldest OS based on Linux kernel)       |
| Kernel      | Core interface between a computer’s hardware and its processes, manages available resources |
| ssh         | Program for logging in to a remote machine specified with a host name                       |
| PC          | A personal computer                                                                         |
| Mac         | A Macintosh computer                                                                        |

***
### **Points to remember**:                                         
> Linux commands are case sensitive and are always single words \
> Options follow the command - and they start with a single hyphen (-) and a character or a double hyphen (- -) and a word \
> Single character options can be combined \
> Argument can be one or two inputs \
> You can write more than one command separating with a semicolon; You can use “tab” to auto-fill the command
***

### Important Commands

*(a)* [ls](https://manpages.ubuntu.com/manpages/focal/en/man1/ls.1plan9.html) \
Lists information about the files/directories. Default is the current directory. Sorts entries alphabetically. 

Commonly used options:
-l long list
-a show all files (including hidden files)
-t sort based on last modified time 

```bash
ls -l
```

Information (from left to right): \
•    File permissions \
•    Number of links \
•    Owner name \
•    Group name \
•    Number of bytes \
•    Abbreviated month, last modified date and time \
•    File/Directory name 

*(b)* [pwd](https://manpages.ubuntu.com/manpages/focal/en/man1/pwd.1posix.html) \
Returns the path of the current working directory (print working directory) to the standard output. 

```bash
pwd
```

*(c)* [cd](https://manpages.ubuntu.com/manpages/focal/en/man1/cd.1posix.html) \
Change current working directory to the specified directory. 

```bash
cd LinuxExamples
pwd
```

We are now in the directory `LinuxExamples`. Typing the command `cd ..` changes it to the parent directory from which the previous command was typed in. Typing `cd` will change the current directory to the home directory.

*(d)* [mkdir](https://manpages.ubuntu.com/manpages/focal/en/man1/mkdir.1.html) \
This command creates a directory in the current working directory if one with the specified name does not already exist. 

```bash
mkdir Practice
ls -l
```

*(e)* [rmdir](https://manpages.ubuntu.com/manpages/focal/en/man1/rmdir.1.html) \
This command is used to remove directories. 

```bash
rmdir Practice
ls -l
```

*(f)* [touch](https://manpages.ubuntu.com/manpages/focal/en/man1/touch.1posix.html) \
It is file’s time-stamp changing command. However, it can be used to create an empty file. This command is typically used to verify whether the current user has write permission.

```bash
touch temp-file
ls -l
```

*(g)* [rm](https://manpages.ubuntu.com/manpages/focal/en/man1/rm.1posix.html) \
rm is used for removing files and directories.

```bash
rm temp-file
ls -l
```

> [!WARNING]
> **To remove directories use "-r" option. Please remember once a file or directory is deleted, it will not go to "Recycle bin" in Linux and there is no way you can recover it.**

*(h)* [cp](https://manpages.ubuntu.com/manpages/focal/en/man1/cp.1.html) \
 Copies the content of the source file/directory to the target file/directory. To copy directories, use "-r" option.

```bash
touch temp1
cp temp1 temp2
ls -l
```

*(i)* [mv](https://manpages.ubuntu.com/manpages/focal/en/man1/mv.1posix.html) \
To move/rename a file or a directory.

```bash
mkdir temp
mv temp1 temp/.
mv temp2 temp3
ls -l
```

The second command moves the "temp1" file into the directory "temp". The "." (dot) at the end of the command retains the name of the file, whereas the third command renames the file "temp2" to "temp3".

*(j)* [ln](https://manpages.ubuntu.com/manpages/focal/en/man1/ln.1.html) \
Link command is used to make links to files/directories. We encourage you to create links rather than copying data in order to save space.

```bash
ln -s temp/temp1 .
ls -l 
```

### File viewers

*(a)* [cat](https://manpages.ubuntu.com/manpages/focal/en/man1/cat.1.html) \
The concatenate command combines files (sequentially) and prints on the screen (standard output).

```bash
cat Ebola.fa
```

*(b)* [more](https://manpages.ubuntu.com/manpages/focal/en/man1/more.1posix.html)/[less](https://manpages.ubuntu.com/manpages/focal/en/man1/less.1.html) \
These commands are used for viewing the content of the files; faster with large input files than text editors; not the entire file is read at the beginning.

```bash
more Ebola.fa
```

Press “Enter” to view lines further and “q” to quit the program

*(c)* [head](https://manpages.ubuntu.com/manpages/focal/en/man1/head.1posix.html)/[tail](https://manpages.ubuntu.com/manpages/focal/en/man1/tail.1.html) \
These commands show first/last 10 lines (default) respectively from a file.

```bash
head Ebola.fa
```

### File editors

There are many non-graphical text editors like ed, emacs, vi and nano available on most Linux distributions. Some of them are very sophisticated (e.g., vi) and for advanced users. 

[Nano](https://manpages.ubuntu.com/manpages/focal/en/man1/nano.1.html) (earlier called pico) is like any graphical editor without a mouse. All commands are executed using the keyboard, using the `Control (Ctrl)` key modifier. It can be used to edit virtually any kind of text file from the command line. Nano without a file name gives you a standard (blank) nano window. 

At the bottom of the screen, there are commands with a symbol in front. The symbol tells you that you need to hold down the `Ctrl` key, and then press the corresponding letter of the command you wish to use. 

#### Nano quick reference


```
Ctrl+X will exit nano and return you to the command line. 

Ctrl+X: Exit the editor. If you’ve edited text without saving, you’ll be prompted as to whether you want to exit. 

Ctrl+O: Write (output) the current contents of the text buffer to a file. A filename prompt will appear; press Ctrl+T to open the file navigator shown above. 

Ctrl+R: Read a text file into the current editing session. At the filename prompt, hit Ctrl+T for the file navigator. 

Ctrl+K: Cut a line into the clipboard. You can press this repeatedly to copy multiple lines, which are then stored as one chunk. 

Ctrl+J: Justify (fill out) a paragraph of text. By default, this reflows text to match the width of the editing window. 

Ctrl+U: Uncut text, or rather, paste it from the clipboard. Note that after a 'Justify' operation, this turns into 'Unjustify'. 

Ctrl+T: Check spelling. 

Ctrl+W: Find a word or phrase. At the prompt, use the cursor keys to go through previous search terms, or hit Ctrl+R to move into replace mode. Alternatively, you can hit Ctrl+T to go to a specific line.

Ctrl+C: Show current line number and file information. 

Ctrl+G: Get help; this provides information on navigating through files and common keyboard commands 
```
### Getting help in Linux

All Linux commands have manual pages. To access them, use the `man` or `info` command. The manual page provides a detailed explanation of the command, including all available options, and sometimes includes examples. For example, to view the manual page for the `ls` command:

```bash
man ls
```

Please explore the manual pages of all the above commands for available options. 

### Linux text processing

*(a)* [cut](https://manpages.ubuntu.com/manpages/focal/en/man1/cut.1.html) \
The cut command is a command-line utility to cut a section from a file. Please see `man cut` for available options.

To cut a section of file use "-c" (characters)

```bash
cut -c1-10 Ebola.fa
```

The option `-c1-10` will output the first 10 characters from each line of the input file. 

```
Few options: 
-c: cut based on character position 
-d: cut based on delimiter 
-f: field number 
```

We have a text file named `viruses.txt` with with information containing the names of the viruses, GenBank IDs and genome length. These fields are separated by the `|` symbol.

```bash
head viruses.txt
```

To get the list of GenBank IDs of the viruses from the file,

```bash
cut -d "|" -f2 viruses.txt
```

*(b)* [sort](https://manpages.ubuntu.com/manpages/focal/en/man1/sort.1posix.html) \
The sort command is used to sort the input content.

```
Few options: 
-t: field separator 
-n: numeric sort 
-k: sort with a key (field) 
-r: reverse sort 
-u: print unique entries 
```

```bash
sort -t "|" -nrk6 viruses.txt 
```

*(c)* [grep](https://manpages.ubuntu.com/manpages/focal/en/man1/grep.1plan9.html) \
grep searches the input for a given pattern.

```
Few options:
-A: after context
-B: before context
-C: before and after context
-c: count
-l: file with match
-i: ignore case
-o: only match
-v: invert match
-w: word match 
```

To get the list of all "Influenza D" viruses from `viruses.txt` file,

```bash
grep "Influenza A" viruses.txt
```

*(d)* [wc](https://manpages.ubuntu.com/manpages/focal/en/man1/wc.1.html) \
The command `wc` can be used to count lines, words, or characters.

```bash
wc -l viruses.csv
```

```bash
cat viruses.csv | wc -l
```



### I/O control in Linux

When you run a command, the output is usually sent to standard output (stdout) ie, the terminal. However, we can redirect the standard output to a file using `>`.

```bash
grep "Influenza A" viruses.txt > flu-file.txt

cat flu-file.txt
```

The first saves the output in a new file called `flu-file.txt`. If there is a file with the same name, it is overwritten with the output of the command. Instead, we can append to a file using `>>` redirection. 

Another type of output generated by programs is standard error. We use `2>` to redirect it. 

```
ls foo 2> error
```

To redirect stdout and stderr to a file, use `&>`.

#### Pipes

Piping in Linux is a compelling and efficient way to combine commands. Pipes `|` in Linux act as connecting links between commands. Pipe redirects the output of the first command as input to the following command. We can nest as many commands as we want using pipes. They ensure the smooth running of the command flow and reduce the execution time. 

To print the 10 smallest viruses,

```bash
sort -t"|" -nk6 viruses.txt | head -10
```

We will be working on other examples during the course, where we use pipes to combine more than two commands. 

### Process control

Some commands may take time to complete their assigned tasks. For example, if you would like to compress a huge file with gzip command that takes a few minutes to finish running, you can run it in the background by appending the command with “&” (Another way is to suspend a command by pressing Ctrl+Z and typing “bg”). The completion of the task is indicated by “Done”.

```bash
gunzip SRR21065613_?.fastq.gz &
```

We can get a list of currently running jobs in the terminal by the `jobs` command. This will give you all the background jobs running in the current terminal. To view all running processes in the system, use the “top” command. You can get user-specific details in the top using "-U" option. 

```bash
top
```

A few of the essential columns in the `top` output: 
```
* PID: Process Id, this is a unique number used to identify the process 
* COMMAND: Command Name 
* S: Process Status: The status of the task which can be one of: 
  + D = uninterruptible sleep 
  + R = running 
  + S = sleeping 
  + T = traced or stopped 
  + Z = zombie 
```
To stop a running background job, use the `kill` command followed by the process ID. 

```
kill 1234
```

This command kills the job with the process id 1234. As a user, you can kill only your jobs. You do not have permission to run this command on the process IDs of other users.
