# Introduction to Linux 
### Author: Karen McLuskey
#### Contact: Karen.McLuskey@glasgow.ac.uk



## Introduction

Linux is widely used in biological and biomedical research for accessing research servers, managing large datasets and running bioinformatics software. In this tutorial, you will connect to a Linux server (alpha2) and learn how to interact with it using the command line. 

The aim of the tutorial is to develop confidence working at the command line and to provide a foundation for using Linux. 

### Connecting to the Linux Server

In this course, we will use the MobaXterm application to connect to the Alpha2 Linux server using the username and password provided.

### The Terminal

Once connected, MobaXterm opens a terminal window. The terminal is a text-based interface that allows you to interact with the Linux server by typing commands. These commands provide a fast and flexible way to navigate files, manage data and run bioinformatics software. 

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

>💡 **Note:** The `~` symbol is a shortcut for your home directory. When you first log in, you will usually start in your home directory.

### Linux Command Structure

Most Linux commands follow a similar structure:

```bash
command [option(s)] [argument(s)]
```

| Part     | Purpose                                   |
|----------|-------------------------------------------|
| command  | Specifies the program to run              |
| option   | Modifies how the command behaves          |
| argument | Specifies what the command should work on |

For example:

```bash
ls -l results.txt
```

| Part     | Example       | Meaning          |
|----------|---------------|------------------|
| Command  | `ls`          | *list*           |
| Option   | `-l`          | long-version     |
| Argument | `results.txt` | file of interest |

A command may be used on its own, or with one or more options and/or arguments.

>💡 **Note:** Typing `man <command_name>` displays the manual page for a command. The manual contains information about the command, its options and how to use it. Press `q` to exit when done.

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

>💡 **Note:** Experienced Linux users rely heavily on Tab completion to avoid typing long file and directory names. Whenever possible, try using the Tab key rather than typing names in full.


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
5. Copy files using `cp`
6. Create files using `touch`
7. Rename and move files using `mv`
8. Remove files using `rm`
9. Edit text files using `nano`
10. View text files using `less`
11. Navigate a Linux system with confidence 🤞

## Getting around in Linux

### Where am I?

Directories in Linux are the equivalent of folders on a Windows PC or Mac. Directories can contain files and/or other directories, allowing information to be organised in a hierarchical structure.

The directory you are currently working in is known as your *current working directory*. To find your current working directory, use the `pwd` command (*print working directory*).

From now on, whenever you see a command in a grey box, try entering it at the command line.

```bash
pwd
```

You should see:

`/home4/your_username`

>💡 **Note:**  This is your home directory.

### What is in here?

The `ls` command *lists* the contents of a directory. It can be used to view files and subdirectories within your current working directory.

```bash
ls
```

🤔 **Question:** What do you see?

<details>
  <summary>Expected output</summary>
You shouldn't see any output as your home directory is currently empty. 

Let's add some files and directories to your home directory.
</details>


### Creating a Directory

Use the `mkdir` command (*make directory*) to create a new directory called `linux_tutorial`.

```bash
mkdir linux_tutorial
```

🤔 **Question:** Was the directory created successfully?

```bash
ls
```

You should now see the directory:

`linux_tutorial`

### Changing directories

Use the `cd` command (*change directory*) to move between directories.

Move into the directory you just created:

```bash
cd linux_tutorial
```

Check your new location:

```bash
pwd
```

You should now see:
`/home4/your_username/linux_tutorial`<br>
You are now in a subdirectory of your home directory called `linux_tutorial`. <br>

While you are here, create another new directory called `data_files` and then move into it. <br>
Once you have done this, your current working directory should be:`/home4/your_username/linux_tutorial/data_files`

<details>
  <summary>Help</summary>

```bash
mkdir data_files
cd data_files
pwd
```

</details>
<br>


Before continuing, it is probably good to know that:

| Symbol | Meaning                             |
|--------|-------------------------------------|
| `~`    | Your home directory                 |
| `.`    | The current directory               |
| `..`   | The parent directory (one level up) |
| `/`    | Separates directories in a path     |

For example: `/home4/your_username/linux_tutorial/data_files`
is the full path showing how to reach the `data_files` directory.

🤔 **Question:** What do you think this path represents?

`/home4/your_username/linux_tutorial/data_files`

<details>
  <summary>Answer</summary>

  Your directory is part of a larger directory structure:

```text
/
└── home4
    └── your_username <--- your home directory
        └── linux_tutorial
            └── data_files
```

- A path describes the location of a file or directory.

- Paths beginning with `/` are called **absolute paths** because they start from the top of the directory structure.

- Each `/` separates one directory from the next.

- Paths beginning with `~` start from your home directory.

- Examples:

  - `/home4/your_username/linux_tutorial/data_files`

  - Is equivalent to: `~/linux_tutorial/data_files`

</details>
<br>


Okay, you should still be in the directory `data_files` which is two directories *below* your home directory. So, let's go home.


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

#### Practise

It's useful to practice moving around directory structures. Here are a few simple tasks to help you get familiar with changing directories.

```bash
cd
pwd
```

This should take you home and you should see:
`/home4/your_username`

```bash
cd linux_tutorial/data_files
pwd
```

You should see:
`/home4/your_username/linux_tutorial/data_files`

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
<br>

🤔 **Question:** What is in the `linux_tutorial` directory?

<details>
  <summary>Answer</summary>

```bash
ls
```

`data_files`
</details>
<br>
Okay - Now go back to your home directory.

<details>
  <summary>How do I do that?</summary>

These will all take you home from the `linux_tutorial` folder

```bash
cd
cd ~
cd ../
```

>💡 **Note:** There is often more than one way to reach the same location in Linux.
</details>
<br>

🤔 **Question:** Are you back in your home directory?

```bash
pwd
```

 You should see:
 
 `/home4/your_username/`


### Creating, Copying and Removing Files

#### Copying

The `cp` command (**copy**) is used to make a copy of a file.

| Command                        | Meaning                                         |
|--------------------------------|-------------------------------------------------|
| `cp file.txt newfile.txt`      | Copy a file and rename the copy                 |
| `cp file.txt directory_name/.` | Copy a file into a directory with the same name |
| `cp path/file.txt .`           | Copy a file into the current directory          |
| `cp * directory_name`          | Copy multiple files                             |


>💡 **Note:**
>- `~` represents your home directory.
>- `.` represents the current directory.
>- Use `pwd` if you are unsure where you are.

#### Practise Exercises

Here you are going to copy three data files from `/home4/VBG_data/Linux_26` into your `data_files` directory from three different starting locations:

Let's first check what is in this dir:

```bash
ls /home4/VBG_data/Linux_26
```

You should see:

`Exercises  human_viruses.txt  outbreak.csv  SARS-CoV-2.fa  test_files`

>💡 **Note:** `Exercises` and `test_files` are directories and may be coloured differently to represent this.

Now let's copy each of the text files from a different starting location:

1. Go into your `data_files` directory and copy `human_viruses.txt` from `Linux_26` into `data_files`
2. Go into `Linux_26` and copy `outbreak.csv` into your `data_files` directory  
3. From your home directory copy `SARS-CoV-2.fa` into your `data_files` directory 

Starting from your home directory:

#### Walkthrough: Challenge 1:

Change into your `data_files` directory, then copy `human_viruses.txt` from `Linux_26`.

```bash
cd linux_tutorial/data_files/ 
cp /home4/VBG_data/Linux_26/human_viruses.txt . 
ls 
```

>💡 **Note:**
> 
> The dot (`.`) means "the current directory" (👇 to here).
> 
> Using `ls` should show the file `human_viruses.txt` in your current directory `data_files`
> 

#### Walkthrough: Challenge 2:

Go into `/home4/VBG_data/Linux_26` and copy `outbreak.csv` into your `data_files` directory

```bash
cd /home4/VBG_data/Linux_26
ls 
cp outbreak.csv ~/linux_tutorial/data_files/.
ls  ~/linux_tutorial/data_files
```

>💡 **Note:**
> 
> - The first *ls* is just used to look around and see what is here
> - ~ is used to denote your home dir
> - The second *ls* is used to check that the new file has been copied and should now show `human_viruses.txt outbreak.csv` 


#### Walkthrough: Challenge 3

From your **home directory**, copy `/home4/VBG_data/Linux_26/SARS-CoV-2.fa` into your `data_files` directory. Try it without using the Help box if possible.

<details>
  <summary>Help</summary>

```bash
cd
cp /home4/VBG_data/Linux_26/SARS-CoV-2.fa linux_tutorial/data_files
```

</details>

Check that you have all the files:

```bash
ls linux_tutorial/data_files
```

You should see something similar to:

`human_viruses.txt  outbreak.csv  SARS-CoV-2.fa`


## Working with Files

Now that you can navigate the directory structure and copy files, let's look at some common commands for creating, editing, viewing and managing files.

### Creating Files

The `touch` command can be used to create an empty file.

>💡 **Note:** Why is it called touch?
>
>The command was originally designed to update a file's timestamp. If the file does not exist, Linux creates an empty file first. As a result, `touch` is commonly used to create empty files.

First make sure you are in your `linux_tutorial` directory then create a directory called `virus_notes` and move into it.

```bash
cd ~/linux_tutorial
mkdir virus_notes
cd virus_notes
```

Now create a file where we can store some notes about viruses.

```bash
touch virus_notes.txt
ls
```

You should see `virus_notes.txt` in your directory.

### Moving and Renaming Files

The `mv` command (*move*) can be used to move files between directories or rename files and directories.

Let's make our notes a little more specific by creating a copy for influenza viruses.

```bash
cp virus_notes.txt influenza_notes.txt
```

🤔 **Question:** What files do you have now?

<details>
  <summary>Answer</summary>

```bash
ls
```

`virus_notes.txt influenza_notes.txt`
</details>
<br>

Rename `virus_notes.txt` to `rabies_notes.txt` so that neither file is generic.


<details>
  <summary>Answer</summary>

```bash
mv virus_notes.txt rabies_notes.txt
ls
```

You should now have `influenza_notes.txt rabies_notes.txt` in your `virus_notes` dir.
</details>
<br>

Finally in your `virus_notes` directory make a final text file named `tuberculosis_notes.txt`.

<details>
  <summary>Help</summary>

```bash
touch tuberculosis_notes.txt
ls
```

</details>
<br>

You should now have `influenza_notes.txt rabies_notes.txt tuberculosis_notes.txt`.

🤔 **Question:** Are you happy with your three virus notes files?

<details>
  <summary>Yes</summary>

  Uh oh! 😱

  One of those files doesn't belong here.

  Tuberculosis is caused by a bacterium rather than a virus, so let's remove it.

</details>
<br>

<details>
  <summary>No</summary>

  😃 Hopefully you spotted that tuberculosis is a bacterial infection and has no place in a virus_notes directory so we should remove it.

</details>
<br>


#### Removing Files

The `rm` command (*remove*) is used to permanently delete files. 

>💡 **Note:** Unlike deleting a file on your computer, removed files do not go to a Recycle Bin or Trash folder, so use this command with care.

Remove `tuberculosis_notes.txt` using the `rm` command.

```bash
rm tuberculosis_notes.txt
ls
```

You should now have two files `influenza_notes.txt rabies_notes.txt` in your `virus_notes` directory. These files will be used in the next section.

### Editing Files

Let's put some information into our `influenza_notes.txt` file and save it using the text editor `nano`.

```bash
nano influenza_notes.txt
```

Now type: Influenza A(H5N1)

Then add: `Often called bird flu, Influenza A(H5N1), primarily infects birds but can occasionally infect humans. Human infections are rare but can cause severe disease.`

When you have finished:

- Press Ctrl+X to exit
- Press Y to save your changes
- Press Enter to keep the current filename

🤔 **Question:** Did your file save successfully?

```bash
ls -ltr
```

>💡 **Note:**  What do these options mean?
>
> - -l shows files in a long format including size, permissions and modification date.
> - -t sorts files by modification time.
> - -r reverses the order of the listing.
>
> Together, ls -ltr shows the most recently modified files at the bottom of the list.
>
> If your file was saved successfully, influenza_notes.txt should be the most recently modified file and should appear at the bottom of the lists of files.


### Viewing Files

Some files you created yourself may be empty, while `influenza_notes.txt` and the files copied into `data_files` should contain data.

Let's have a look inside these files using the `less` command.

The `less` command is used to view the contents of a text file one screen at a time. This is particularly useful for large files that do not fit on the screen. 
Quit `less` by pressing **q**.

> 💡 **Note:** Why is it called `less`?
>
> Before `less`, there was an older command called `more` which could only move forwards through a file. `less` was developed as an improved version that allows you to move both forwards and backwards. As the creators joked:
>
> *"less is more"*

```bash

cd ~/linux_tutorial/virus_notes
less influenza_notes.txt
```

Press **q** to exit `less`, then look at `outbreak.csv`

```bash
cd ..
cd data_files
less outbreak.csv
```

You should see the text that you wrote for `influenza_notes.txt` and a scrollable file for `outbreak.csv`.

Press **q** to exit `less`

The `less` command has several useful keyboard shortcuts:

 **Useful `less` commands**

 | Key | Action |
 |-----|--------|
 | `Space` | Next page |
 | `b` | Previous page |
 | `↑` / `↓` | Move up or down |
 | `q` | Quit `less` |

Try the shortcuts while looking at the other two data files, remembering to press **q** to exit `less` between each command.

```bash
less human_viruses.txt
less SARS-CoV-2.fa
```

### Wildcards and Tab Completion

Before we move on to a couple of exercises to try on your own it's useful to know about wildcards and tab completion.

The `*` character is known as a **wildcard**. It can be used to match any number of characters in a filename.

Tab completion is another useful shortcut. If you start typing a filename or directory name and press **Tab**, Linux will try to complete the name for you.

Together, wildcards and Tab completion can save a lot of typing and help avoid spelling mistakes.

```bash
cd ~/linux_tutorial/data_files
ls
```

You should see `human_viruses.txt  outbreak.csv  SARS-CoV-2.fa`

To list only the FASTA (fa) files:

```bash
ls *.fa
```

which will show only `SARS-CoV-2.fa`

🤔 **Question:** How would you list only text files? How would you list only CSV files?

<details> 
<summary>Answer</summary>

```bash
ls *.txt
ls *.csv
```
</details>

Now try tab completion (don't press enter):

```bash
less SARS-
```

Before pressing Enter, press Tab. Linux should complete the filename to: `SARS-CoV-2.fa`. 

> 💡 **Note:** If there is more than one possible completion, press **Tab** twice to see the available options.
> This is probably the most useful Linux trick you'll learn all day. Remember this in the Exercises below.

### Exercises

In this section you are going to try a few exercises using the commands that you have learned so far.

Before we start, copy the `Exercises` directory from `VBG_data` into your `linux_tutorial` directory using the following command:

```bash
cp -r /home4/VBG_data/Linux_26/Exercises ~/linux_tutorial/.
```

>💡 **Note:** As `Exercises` is a directory rather than a file. The `-r ` (recursive) option tells `cp` to copy the directory and everything inside it. Without `-r`, Linux will not copy directories.


#### Exercise 1: 
Go into the Exercises folder and see what files are in there.

<details> <summary>Answer</summary>

```bash
cd ~/linux_tutorial/Exercises
ls
```
</details>

#### Exercise 2: 
Hidden amongst the FASTA files (`.fa`) is a file called `NC_012936.1_cds_YP_003029853_Y.1_10.fa`.
Use wildcards, Tab completion and the commands you have learned so far to find the file and follow the instructions inside it.

> **Hint**
>
> ```bash
> ls *.fa
> less NC_012
> ```
>
> Press **Tab** to complete the filename. If more than one match is available, press **Tab** twice to see the options.

<details>
  <summary>Answer</summary>

```bash
less NC_012936.1_cds_YP_003029853_Y.1_10.fa
mv NC_012936.1_cds_YP_003029853_Y.1_10.fa found_file.txt
```
</details>

#### Exercise 3:  
In the `Exercises` directory there are several stray text files.

   1. Can you list all of the text files in the directory?
   2. Can you delete the four newest text files?
   3. Can you move the remaining text files into a new subdirectory called `text_files`?

<details>
  <summary>Don't cheat</summary>

<details>
  <summary>You really need a hint?</summary>

You will need to:

1. List all of the text files using a wildcard (`*`) and identify the newest files using `ls -ltr`.
2. Remove all text files beginning with `stray_file`.
3. Create a new directory called `text_files`.
4. Move the remaining text files into the new directory.

```bash
ls -ltr *.txt
rm stray_file*.txt
mkdir text_files
mv *.txt text_files
```
</details>
</details>

#### Exercise 4:  
Most of the FASTA files in the `Exercises` directory begin with `NC_`.

   1. Create a new directory called `NC_fasta`.
   2. Move all FASTA files beginning with `NC_` into the new directory.
   3. What is the FASTA header of the remaining FASTA file (the line beginning with `>`)?

<details>
  <summary>Commands</summary>

```bash
mkdir NC_fasta
mv NC_*.fa NC_fasta
ls *.fa
less Betacoronaviruses.fa
```
</details>