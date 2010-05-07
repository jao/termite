# Command line Timesheet
Version: 0.5
Author: joão paulo camargo

Timesheet is an open source time tracker ruby script/tool that uses sqlite. It is very simple, and it is meant for personal time management.
Command line interface.

Screenshots:

![work help](http://cl.ly/wiR/content)

![work list](http://cl.ly/wtv/content)

![work report daily](http://cl.ly/xsh/content)

![work report weekly](http://cl.ly/xpJ/content)

![work report montly](http://cl.ly/x41/content)

## Requirements

* rubygems
* sqlite3

## Installation

### Clone the repository

    git clone git://github.com/jao/timesheet.git
 
### Add the script's directory to your path

Run the script for the first time, the database should be created automatically in the same directory of the script. (Make sure the script has permission to write inside the directory)

### For Adium support

open the work script file, and change the following constants as you see fit.

    ADIUM=true
    ADIUM_AVAILABLE='I am here'
    ADIUM_LUNCH='Out to lunch'
    ADIUM_AWAY='Be right back'
    ADIUM_SICK='I am sick'
    ADIUM_STOP='Going home'

### Command completion

If you want a very simple command completion for the work script, you can add the following to your .bash_profile.

    source /path/to/timesheet/work_completion.sh

## For multiple computers

If you plan to use this in more than one computer, I would recommend that you use dropbox. Move the database there, and create a symbolic link inside this script's directory.
Something like this:

    mv work.db ~/Dropbox/work.db
    ln -s ~/Dropbox/work.db work.db

[Signup to dropbox](https://www.dropbox.com/referrals/NTIyMDkwMTA5) if you don't have an account yet, this is [my referral link](https://www.dropbox.com/referrals/NTIyMDkwMTA5) - which means if you signup using it, we both get higher space quota.

## To do

* add a config file option (at the user's home directory)
* add the option to start and stop working more than once a day
* add the support to projects, and maybe reports based on projects
* make better reports
* add an export feature to convert the reports to pdf, csv, etc.

## License

Timesheet is released under the MIT license and is copyright (c) 2010 [Code 42](http://code42.com.br)

[Read the license](http://github.com/jao/timesheet/master/LICENSE)

### Change the script at your own risk.
