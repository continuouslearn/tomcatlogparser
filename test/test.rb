#!/usr/bin/env ruby

require '../lib/tomcat_log_parser.rb'

tomcatcatalinalog =  Tomcat_log_parser.new("#{ARGV[0]}")

#parse_result = tomcatcatalinalog.parseCatalineout
parse_result = tomcatcatalinalog.parseAccesslog

parse_result.each do |r|
	puts "------------------------------------------------------------------------------"
		
	puts "#{r['ipaddress']} |  #{r['time']} |  #{r['url']} |  #{r['code']} |  #{r['size']} |  #{r['responsetime']} " 
 	
end  


=begin
puts "========================================"
parse_result.each do |r|
	puts "------------------------------------------------------------------------------"
		
	puts "#{r['logtime']} #{r['logclass']} #{r['logaction']} "
	puts "#{r['logseverity']}  #{r['logdetails']} "
	
end  
puts "============== Log Count ==============="
puts parse_result.size


 

#puts "========== Diff two files ========================"
#`diff #{ARGV[0]} result.log`


=end