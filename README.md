# Geneweb
Family tree software from Geneweb Compiled to latest github clone (version 7+)

## Usage
Untar the geneweb.tar.gz and run gwsetup

Edit `/gw/only.txt` with your pc ip address. This is the authorised ip to access the admin.

Port 2316 is the default usage, Port 2317 is for admin.
````
Usage: gwsetup [options] where options are:
  -bd <dir>: Directory where the databases are installed.
  -gwd_p <number>: Specify the port number of gwd (default = 2317); > 1024 for normal users.
  -lang <string>: default lang
  -daemon : Unix daemon mode.
  -p <number>: Select a port number (default = 2316); > 1024 for normal users.
  -only <file>: File containing the only authorized address
  -gd <string>: gwsetup directory
  -bindir <string>: binary directory (default = value of option -gd)
  -help  Display this list of options
  --help  Display this list of options
 ````
 
 ## Docker
 to do
