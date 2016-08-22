#! /usr/bin/env ruby

# Restarts a local 2Wire Gateway
# Takes one argument - the router admin password
# See http://testvb.overclockers.co.uk/showthread.php?t=18383696

require 'rubygems'
require 'mechanize'

a = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

base = "http://192.168.1.254/xslt?PAGE=A02_POST&THISPAGE=A07&NEXTPAGE=A08&CMSKICK=&NEXTPAGE=A08&THISPAGE=A07&PAGE=A08&PASSWORD="
pass = ARGV.shift

url = base + pass

page = a.post(url)
res = page.form.submit
puts res
