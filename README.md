# Geneweb
Family tree software from Geneweb Compiled to latest github clone (version 7+)

## Usage
Untar the geneweb.tar.gz and run geneweb.sh

This will run the admin service ````gwsetup```` , the main application ````gwd```` and the watchdog to ensure the services are still running every 60 seconds.

Go to ````http://[containerip]:2316```` to setup databases, each databse is a seperate tree.

On first run you most likely be met with an error message, this is by design to limit access to the admin web management from a single ip address. Edit `/gw/only.txt` with your pc ip address / the one shown on screen. This is then the authorised ip to access the admin area.

#### Port Numbers
Port 2317 is the default usage, Port 2316 is for admin, Port 2322 is for API.

#### GWSETUP
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

 #### GWD (main application)
 ````
 ./gwd --help
Usage: gwd [options] where options are:
  -a <ADDRESS>                 Select a specific address (default = any address of this computer).
  -add_lexicon <FILE>          Add file as lexicon.
  -allowed_tags <FILE>         HTML tags which are allowed to be displayed. One tag per line in file.
  -api_h <HOST>                Host for GeneWeb API (default = 127.0.0.1).
  -api_p <NUMBER>              Port number for GeneWeb API (default = 2322).
  -auth <FILE>                 Authorization file to restrict access. The file must hold lines of the form "user:password".
  -bd <DIR>                    Directory where the databases are installed.
  -blang                       Select the user browser language if any.
  -cache_langs                 Lexicon languages to be cached.
  -cgi                         Force CGI mode.
  -conn_tmout <SEC>            Connection timeout (default 120s; 0 means no limit).
  -daemon                      Unix daemon mode.
  -digest                      Use Digest authorization scheme (more secure on passwords)
  -friend <PASSWD>             Set a friend password.
  -hd <DIR>                    Directory where the directory lang is installed.
  -images_dir <DIR>            Same than previous but directory name relative to current.
  -images_url <URL>            URL for GeneWeb images (default: gwd send them).
  -lang <LANG>                 Set a default language (default: fr).
  -log <FILE>                  Llog trace to this file. Use "-" or "<stdout>" to redirect output to stdout or "<stderr>" to output log to stderr.
  -log_level <N>               Send messages with severity <= <N> to syslog (default: 7).
  -login_tmout <SEC>           Login timeout for entries with passwords in CGI mode (default 1800s).
  -max_clients <NUM>           Max number of clients treated at the same time (default: no limit) (not cgi).
  -min_disp_req                Minimum number of requests in robot trace (default: 6).
  -no_host_address             Force no reverse host by address.
  -nolock                      Do not lock files before writing.
  -only <ADDRESS>              Only inet address accepted.
  -p <NUMBER>                  Select a port number (default = 2317).
  -plugin <PLUGIN>.cmxs        load a safe plugin.
  -plugins <DIR>               load all plugins in <DIR>.
  -redirect <ADDR>             Send a message to say that this service has been redirected to <ADDR>.
  -robot_xcl <CNT>,<SEC>       Exclude connections when more than <CNT> requests in <SEC> seconds.
  -setup_link                  Display a link to local gwsetup in bottom of pages.
  -trace_failed_passwd         Print the failed passwords in log (except if option -digest is set). 
  -trace_templ                 Print the full path to template files as html comment 
  -unsafe_plugin <PLUGIN>.cmxs DO NOT USE UNLESS YOU TRUST THE ORIGIN OF <PLUGIN>.
  -unsafe_plugins <DIR>        DO NOT USE UNLESS YOU TRUST THE ORIGIN OF EVERY PLUGIN IN <DIR>.
  -wd <DIR>                    Directory for socket communication (Windows) and access count.
  -wizard <PASSWD>             Set a wizard password.
  -wjf                         Wizard just friend (permanently).
  -help                        Display this list of options
  --help                       Display this list of options
````

## Docker
 to do
