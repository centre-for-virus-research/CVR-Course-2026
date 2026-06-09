# Introduction to Linux 2026
### Author: Sreenu Vattipally
#### Contact: Sreenu.Vattipally@glasgow.ac.uk
```
Command line shortcuts 

Up/Down arrows: Previous commands
!!: Reruns previous command
Tab: Auto complete
Tab+Tab: All available options 
Ctrl+a: Move cursor to start of line
Ctrl+e: Move cursor to end of line
Alt+: Alternates between terminals
Ctrl+l: Clear screen (or Command+k on Mac) 
Ctrl+c: Terminates the running program 
Ctrl+z: Suspends the running program
Ctrl+w: Removes a previous word
Ctrl+d: Logout
Ctrl+d(in a command): Removes a character 
Ctrl+u: Removes till the beginning 
```

## Introduction

[Linux](#info) is an open-source operating system ([OS](#info)) developed based on the kernel created by Linus Benedict Torvalds. Over the last two decades, Linux has gained significant popularity and is now used on numerous platforms. Nowadays, most high-end servers and mobile phones (running Android OS or iOS) are powered by different variants of Linux.

Linux computers/servers are installed for multi-user usage. In this course, we will work on a high-performance cluster machine running [Ubuntu](#info) Server Edition. Most of the commands specified in this manual can be used in any other distribution (i.e., CentOS, Debian, etc.) of the Linux operating system.

#### Resource: How to install Ubuntu? <span style='color: red;'>(Please do not install if you are unsure of what you are doing)</span>

To install a desktop edition of Ubuntu on your personal computer, please follow the instructions at the following link. [Install Ubuntu](https://tutorials.ubuntu.com/tutorial/tutorial-install-ubuntu-desktop#0)

### The Terminal

We use a terminal (also known as a command-line interface) to interact with the operating system. The terminal runs one of the “shells” by default. Shell is a program that sits between the user and the [kernel](#info), translating user commands (text) into machine code. The advantages of using the command line are greater control and flexibility over the system or software, and multiple commands can be saved in a file and executed as a program.

The most common shells are:

- Bourne Shell
- Bourne Again Shell – BASH (variant is Z Shell)
- C Shell (variant is T Shell)
- K Shell 

Among these, Bourne Again Shell (BASH) is the most popular one. This is the default shell on the system, and we will be using it throughout this course. 

#### Connecting to the Linux Server

In this course, we will use the MobaXterm application to access the Ubuntu operating system. Please use the provided username and password to log in into your account.

> Open MobaXterm -> Sessions -> New session -> [ssh](#info) -> add remote host and username -> OK -> Enter password -> Don't save password

> Files can be downloaded and uploaded to the server

### Linux command structure

When you open a terminal in Linux (MobaXterm defaults to opening a terminal), you will see a command prompt, ready to accept commands. The default location on the terminal is your “home directory”. It is represented with the ~ (tilde) symbol.

Copy the command below and paste it into your command line to copy the contents of the Linux directory to your home directory.

```bash
cp -r ~bvv2t/LinuxExamples .
```

All Linux commands are single words (can be alpha-numeric), with optional parameters followed by arguments. For historical reasons, some of the early commands are only two letters long and case sensitive. Most of the command options (also referred to as flags) are represented by single letters. They should be specified after the command before giving any input. 

```bash
ls -l
```

The "ls" command lists the contents of a directory, "-l" is the option for long listing. Without the input, "ls" shows all the contents of the current directory. 

To clear the terminal screen,

```bash
clear
```

### First Commands

Directories are the Unix equivalent of folders on a [PC](#info) or a [Mac](#info). They are organised in a hierarchy so that directories can have sub-directories and so on. Directories, like folders, are helpful to keep your data files organised. The location or directory you are currently in is called the current working directory. 

#### Tab completion

Typing out longer file names can be boring, and you are likely to make typos that will, at best, make your command fail with a strange error and, at worst, overwrite some of your carefully crafted analysis. 

Tab completion is a trick that typically reduces this risk significantly. Instead of typing out `ls LinuxExamples`, try typing `ls Li` and pressing the Tab button (instead of Enter). The rest of the folder/file names that begin with `Li` should be auto-completed.
### Info

| Terminology | Description                                                                                 |
| ----------- | ------------------------------------------------------------------------------------------- |
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
