# Termite

* Version: 0.6
* Author: joão paulo camargo

Termite is an open source time tracker ruby script/tool that uses sqlite. It is very simple, and it is meant for personal time management.
Command line interface.

Screenshots:

![termite help](http://cl.ly/wiR/content)

![termite list](http://cl.ly/wtv/content)

![termite report daily](http://cl.ly/xsh/content)

![termite report weekly](http://cl.ly/xpJ/content)

![termite report montly](http://cl.ly/x41/content)

## Requirements

* rubygems
* sqlite3-ruby

## Installation

### Clone the repository

    git clone git://github.com/jao/termite.git
 
### Add the script's directory to your path

Run the script for the first time, the database should be created automatically in the same directory of the script. (Make sure the script has permission to write inside the directory, and the script itself is executable)
Add the script's directory to your path for easier use of this tool.

### For Adium support

open the termite script file, and change the following constants as you see fit.

    ADIUM=true
    ADIUM_AVAILABLE='I am here'
    ADIUM_LUNCH='Out to lunch'
    ADIUM_AWAY='Be right back'
    ADIUM_SICK='I am sick'
    ADIUM_STOP='Going home'

### Command completion

If you want a very simple command completion for the work script, you can add the following to your .bash_profile.

    complete -C /path/to/termite/_termite_completion -o default termite

## For multiple computers

If you plan to use this in more than one computer, I would recommend that you use dropbox. Move the database there, and create a symbolic link inside this script's directory.
Something like this:

    mv termite.db ~/Dropbox/termite.db
    ln -s ~/Dropbox/termite.db termite.db

[Signup to dropbox](https://www.dropbox.com/referrals/NTIyMDkwMTA5) if you don't have an account yet, please consider using my [my referral link](https://www.dropbox.com/referrals/NTIyMDkwMTA5) because if you do we both get a higher storage quota.

## To do

* add a config file option (at the user's home directory)
* add database migration-like updates
* add the option to start and stop working more than once a day, or at least break intervals other than lunch
* add support to projects, and reports based on projects
* add support to tags, and reports based on tags
* add an export feature to convert the reports to pdf, csv, etc.

## License

Termite is released under the MIT license and is copyright © 2010 [João Paulo Camargo](http://jpcamargo.com)

[Read the license](http://github.com/jao/timesheet/master/LICENSE)

### Change the script at your own risk.

If you want to give me tips, ideas, or instructions on how to improve this, feel free to contact me using [timesheet (at) code42.com.br](mailto:timesheet@code42.com.br).
