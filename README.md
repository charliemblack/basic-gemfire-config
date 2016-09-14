.
├── config
│   ├── site_a.properties    - The Properties for the GemFire Cluster - Edit this file
│   └── site_a.xml           - The Cache Defintion to use with GemFire
├── lib                      - Any libraries we might need can go here
├── scripts
│   ├── clear_data.sh        - Will remove the contents under the data directory
│   ├── deploy.sh            - Synchronize the "servers" with this directory
│   ├── env.sh               - Edit this file for servers and locators
│   ├── gather_stats.sh      - Gather any logs and stats from the servers
│   ├── pkill_java.sh        - Run pkill -9 java on all of the hosts
│   ├── run_command.sh       - Run an arbitrary command on all of the hosts
│   ├── start_gemfire.sh     - This starts up GemFire
│   ├── start_locator.sh     - The command that gets run on a system to start a locator
│   ├── start_server.sh      - The command that gets run on a system to start a server
│   └── stop_gemfire.sh      - Stop GemFire
└── stats                    - The directory where the logs and stats will be gathered
    