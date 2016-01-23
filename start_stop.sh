#!/usr/bin/env bash

# Startables and stoppables

# postgres
alias start-pgsql=""
alias stop-pgsql=""

# mysql (http://stackoverflow.com/questions/11091414/how-to-stop-mysqld)
alias start-mysql=""
alias stop-mysql="mysqladmin -u root -p shutdown"

# neo4j
alias start-neo4j="neo4j start"
alias stop-neo4k="neo4j stop"


# find
alias find-stoppables="ps aux | grep ..."
