# Command line Timesheet
Version: 0.5
Author: joão paulo camargo

Timesheet is an open source time tracker ruby script that uses sqlite. It is very simple, and it's meant for personal management only.
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

    git://github.com/jao/timesheet.git
 
### Add the script's directory to your path

Run the script for the first time, the database should be created automatically in the same directory of the script. (Make sure the script has permission to write inside the directory)

### If you don't use Adium, open the work script file, and set @ADIUM=false@

### Command completion

If you want a very simple command completion for the work script, you can add the following to your .bash_profile.

    source /path/to/timesheet/.work_completion.sh
  
### Change the script at your own risk, no support available.

## To do

* add the option to start and stop working more than once a day
* add better reports
* add an export feature to pdf, csv, etc.

## License

Timesheet is released under the MIT license and is copyright (c) 2010 [Code 42](http://code42.com.br)

[Read the license](http://github.com/jao/timesheet/master/LICENSE)
