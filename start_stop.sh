#!/usr/bin/env bash

# startables and stoppables

# postgres (currently running automatically in background)
#alias start-pg=""
#alias stop-pg=""

# mysql (http://stackoverflow.com/questions/11091414/how-to-stop-mysqld)
alias start-mysql="mysql.server start"
alias stop-mysql="mysqladmin -u root shutdown"

# neo4j
alias start-neo4j="neo4j start"
alias stop-neo4k="neo4j stop"

# find
alias find-stoppables="ps aux | egrep 'sql|neo4j' --color"
