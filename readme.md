# Termite

* Version: 0.8
* Author: joão paulo camargo

Termite is an open source time tracker command line ruby script/tool that uses sqlite. It is very simple, and it is meant for personal time management only (thus the simple features).

**Screenshots:**

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
 
### Add the script's directory to your environment's path

Run the script for the first time, the database should be created automatically in the same directory of the script. (Make sure the script has permission to write inside the directory, and the script itself is executable)
Add the script's directory to your `PATH` for easier use of this tool.

### Localization

I've added a localization file for Brazil, with work related time information following the brazilian laws. Also brazilian holidays information (with state/region specific holidays as well).

    ## termite locale related configuration
    COUNTRY = 'BR'
    REGION = 'SP'
    require "lib/locale-#{COUNTRY}.rb"

If you are in Brazil, change de `REGION` value to the brazilian state code to load the specific holidays for your state.
There will be **no** language translations for termite, the script messages and commands **will remain in english**.

### About Adium support

open the termite script file, and change the constants below as you see fit.

    ADIUM = true
    ADIUM_STATUS = {
      :available => 'Working',
      :lunch => 'Out to lunch',
      :away => 'Be right back',
      :sick => 'I am sick',
      :stop => 'Going home'
    }

As a reminder `ADIUM` is a boolean that represents if you want termite to change your Adium status messages or not.

### Command completion

If you want a **very simple** command completion for termite, you can add the following to your `.bash_profile` or `.bash_rc` file:

    # termite completion
    complete -C /path/to/termite/_termite_completion -o default termite

## For multiple computers

If you plan to use this in more than one computer, _at least for now_, I would recommend that you use dropbox.
Move the database there, and create a symbolic link inside this script's directory. Something like this:

    mv termite.db ~/Dropbox/termite.db
    ln -s ~/Dropbox/termite.db termite.db

[Signup to dropbox](https://www.dropbox.com/referrals/NTIyMDkwMTA5) if you don't have an account yet, please consider using my [my referral link](https://www.dropbox.com/referrals/NTIyMDkwMTA5) because if you do we both get a higher storage quota.

## To do

* add a config file option (at the user's home directory)
* add database migration-like updates
* add termite source auto-updates (probably using git)
* add support to projects, and reports based on projects
* add support to tags, and reports based on tags
* add an online sync feature to keep databases updated between computers
* add other countries locale information
* add an export feature to convert the reports to pdf, csv, etc. (maybe now even to google docs using googlecl)

## License

Termite is released under the MIT license and is copyright © 2010 [João Paulo Camargo](http://jpcamargo.com)

[Read the license](http://github.com/jao/termite/master/license.md)

### Change the script at your own risk.

If you want to give me tips, ideas, or instructions on how to improve this, feel free to contact me using [termite at jpcamargo dot com](mailto:termite@jpcamargo.com).
