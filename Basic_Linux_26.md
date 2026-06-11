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

> 💡 **Note:** You won't see your password when you type it. You can copy and paste it into the terminal but make sure you don't grab any white spaces.



### The Terminal

The terminal is a window where you can type commands and interact with a Linux computer. The command line provides a fast and flexible way to navigate files, manage data and run bioinformatics software. 

#### The Terminal Prompt

A typical Linux prompt looks like:

```bash
your_username@alpha2:~$
```

| Part            | Meaning                              |
|-----------------|--------------------------------------|
| `your_username` | Your username                        |
| `alpha2`        | Server name                          |
| `~`             | Your home directory                  |
| `$`             | The prompt (where you type commands) |

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

### Learning Objectives

By the end of this tutorial you will be able to:

1. Find your current location using `pwd`
2. View files and directories using `ls`
3. Create directories using `mkdir`
4. Move around the directory structure using `cd`
5. Understand absolute and relative paths
6. Copy files using `cp`
7. Navigate a Linux system with confidence 🤞


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

The `ls` command *lists* the contents of a directory. It can be used to view files and subdirectories within your current working directory.

```bash
ls
```

🤔 **Question:** What do you see?

<details>
  <summary>Expected output</summary>
You shouldn't see any output as your home directory is currently empty 😅
</details>


### Creating a Directory

Use the `mkdir` command (**make directory**) to create a new directory called `linux_tutorial`.

```bash
mkdir linux_tutorial
```

🤔 **Question:** Was the directory created successfully?

```bash
ls
```
You should see the directory:

`linux_tutorial`

### Changing directories

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

🤔 **Question:** What do you think this path means?

`/home4/your_username/linux_tutorial/text_files`

 Your directory is part of a larger directory structure:

<details>
  <summary>Answer</summary>

```text
/
└── home4
    └── your_username <--- your home directory
        └── linux_tutorial
            └── text_files
```

💡 A path describes the location of a file or directory.

Paths beginning with `/` are called **absolute paths** because they start from the top of the directory structure.

Each `/` separates one directory from the next.

Paths beginning with `~` start from your home directory.

Examples:

`/home4/VBG_data/Linux_26`

`~/linux_tutorial/text_files`

</details>

💡 **Note:** Before continuing, it is useful to know that:

| Symbol | Meaning                             |
|--------|-------------------------------------|
| `~`    | Your home directory                 |
| `.`    | The current directory               |
| `..`   | The parent directory (one level up) |
| `/`    | Separates directories in a path     |

For example:

`/home4/your_username/linux_tutorial/text_files`

is a path showing how to reach the `text_files` directory.


You should still be in `text_files` which is are now two directories **below** your home directory. Let's go home.


### Moving Around the Directory Structure

The `cd` command can be used with special shortcuts to move around the directory structure.

| Command                | Meaning                                           |
|------------------------|---------------------------------------------------|
| `cd`                   | Takes you home                                    |
| `cd ~`                 | Go to your home directory                         |
| `cd ..`                | Go up one directory                               |
| `cd directory_name`    | Change into a named directory                     |
| `cd ../..`             | Go up two directories                             |
| `cd ../directory_name` | Go up one directory and enter a sibling directory |

##### Practise

It's very useful to practice moving around directory structures. Here are a few simple tasks to help you get familiar with changing directories.

```bash
cd
pwd
```
You should see:
`/home4/your_username`

```bash
cd linux_tutorial/text_files
pwd
```

You should see:
`/home4/your_username/linux_tutorial/text_files`

```bash
cd ..
```
🤔 **Question:** What do you expect your current working directory to be?

<details>
  <summary>Output</summary>
You have moved up one directory so you are now in the linux_tutorial directory.
```bash
pwd 
```

`/home4/your_username/linux_tutorial`

</details>

🤔 **Question:** What is in the linux_tutorial directory?

<details>
  <summary>Answer</summary>

```bash
ls
```
`text_files`
</details>

Okay - Let's go back to your home directory.

<details>
  <summary>How do I do that?</summary>

These will all take you home from the `linux_tutorial` folder
```bash
cd
cd ~
cd ../
```
> 💡 **Note:**There is often more than one way to reach the same location in Linux.
</details>

🤔 **Question:** Are you back in your home directory?

```bash
pwd
```

 You should see:
 
 `/home4/your_username/`




### Creating, Copying and Removing Files

#### Copying

The `cp` command (**copy**) is used to make a copy of a file.

| Command                      | Meaning                                |
|------------------------------|----------------------------------------|
| `cp file.txt newfile.txt`    | Copy a file and rename the copy        |
| `cp file.txt directory_name` | Copy a file into a directory           |
| `cp path/file.txt .`         | Copy a file into the current directory |
| `cp * directory_name`        | Copy multiple files                    |


> 💡 **Note:**:
- `~` represents your home directory.
- `.` represents the current directory.
- Use `pwd` if you are unsure where you are.

##### Practise Excercises

Here you are going to copy three text files from `/home4/VBG_data/Linux_26` into your `text_files` directory from three different starting locations:

Let's first check what is in this dir:
```bash
ls /home4/VBG_data/Linux_26
```
You should see:

`Exercises  human_viruses.txt  outbreak.csv  SARS-CoV-2.fa  test_files`

Now let's copy each of the text files from a different starting location:

1. Go into your `text_files` directory and copy `human_viruses.txt` from `Linux_26` into `text_files`
2. Go into `Linux_26` and copy `outbreak.csv` into your `text_files` directory  
3. From your home directory copy `SARS-CoV-2.fa` into your `text_files` directory 

Starting from your home directory:

##### Walkthrough: Challenge 1:

First check what is in the directory you are going to copy from:

```bash
ls /home4/VBG_data/Linux_26
```
Change into your `text_files` directory, then copy `human_viruses.txt` from `Linux_26`.

```bash
cd linux_tutorial/text_files/ 
cp /home4/VBG_data/Linux_26/human_viruses.txt . 
ls 
```
> 💡 **Note:**
> 
> The dot (`.`) means "the current directory" (👇 to here).
> 
> Use `ls` to check that the file has been copied to the correct location.
> 

##### Walkthrough: Challenge 2:

Go into `/home4/VBG_data/Linux_26` and copy `outbreak.csv` into your `text_files` directory

```bash
cd /home4/VBG_data/Linux_26
ls 
cp outbreak.csv ~/linux_tutorial/text_files/ 
ls  ~/linux_tutorial/text_files
```
> 💡 **Note:**
> 
> ls (1): Look around and see what is here
> 
> ~ is used for your home dir
> 
> ls (II): Check the files have been copied


##### Walkthrough: Challenge 3

From your home directory, copy `/home4/VBG_data/Linux_26/SARS-CoV-2.fa` into your `text_files` directory. Try it without using the Help box.

<details>
  <summary>Help</summary>

```bash
cd
cp /home4/VBG_data/Linux_26/SARS-CoV-2.fa linux_tutorial/text_files
```

</details>

Check that you have all the files:

```bash
ls linux_tutorial/text_files
```

You should see something similar to:

`human_viruses.txt  outbreak.csv  SARS-CoV-2.fa`


