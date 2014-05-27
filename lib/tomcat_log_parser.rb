#!/usr/bin/env ruby

require 'rubygems'
 
class Tomcat_log_parser
    attr_reader            :catalinalogarray ,  :finalcatalinalogarray, :accesslogarray, :filelocation
 
    def initialize (filelocation)
		@filelocation = filelocation
		@catalinalogarray = Array.new
		@finalcatalinalogarray = Array.new
		@accesslogarray = Array.new
    end

	private

		def splitCatalinaout
			#initLogVariables
			temHash = Hash.new
			temHash['firstline'] = ''
			temHash['secondline'] = ''

			File.open(@filelocation) do |file| 		
				file.each do |line|	 
 					logtime = /^(\AJan|\AFeb|\AMar|\AApr|\AMay|\AJun|\AJul|\AAug|\ASep|\AOct|\ANov|\ADec) [0-9]{1,2}, 20[0-9]{2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2} (PM|AM)/.match("#{line}") 
					
					if logtime					     
						temHash = Hash.new
						temHash['firstline'] = line
						@catalinalogarray.push(temHash)
						temHash['secondline'] = ''
					else					    
						temHash['secondline'] =   temHash['secondline'] + line
					end
				end
			end
			
			return @catalinalogarray
		rescue Exception
			on_exception
		end		
		
	public 
		
		def parseCatalineout
			#print 'process file ...'	
			@la = splitCatalinaout
			@la.each do |log|
				temHash = Hash.new
				temp = log['firstline'].split(' ').last(2)
				temHash['logclass']    = temp[0]
				temHash['logaction']   = temp[1]
				temHash['logtime']     = /^(\AJan|\AFeb|\AMar|\AApr|\AMay|\AJun|\AJul|\AAug|\ASep|\AOct|\ANov|\ADec) [0-9]{1,2}, 20[0-9]{2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2} (PM|AM)/.match("#{log['firstline']}")
				temHash['logseverity'] = log['secondline'].split(':').first
				temHash['logdetails']  = log['secondline']	
				@finalcatalinalogarray.push(temHash)				
			end
			
			return @finalcatalinalogarray
		rescue Exception
			on_exception			
		end	
		
		def parseAccesslog
			File.open(@filelocation) do |file| 		
				file.each do |line|	 
					temHash = Hash.new
 					temHash['ipaddress'] = /\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/.match("#{line}")
 					temHash['time'] = /\[.*\]/.match("#{line}").to_s.gsub(/\[|\]/,'') 
 					temHash['url'] = /\".*\"/.match("#{line}").to_s.gsub(/\"/,'')  #.sub('"','') 
					temHash['code'] = line.split(' ')[-3]
					temHash['size'] = line.split(' ')[-2]
					temHash['responsetime'] = line.split(' ')[-1]
			
					@accesslogarray.push(temHash)				 
				end
			end
			
			return @accesslogarray
		rescue Exception
			on_exception
		end			
		
end

