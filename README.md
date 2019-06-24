# pDNS


## PowerDNS + Admin interface installer script

This script is intended for use on a fresh Debian 9 install.
It was never tested with any other distros even though it might work on others just as well.

The install script has multiple breakpoints - it guides you through the process.


## Requirements:

- 2 GB RAM (or more)
- MySQL server (manual set-up)
- Brain


## Important notes:

Don't forget to manually import the DB schema, otherwise you might see a lot of 500 errors at the final stage.
