# Simulation Banner
puts "\n\n"
puts "###############################################################################"
puts "#                                                                             #"
puts "# NEWTON'S LAW OF COOLING -- analytical version 1.04                          #"
puts "#_____________________________________________________________________________#"
puts "#                                                                             #"
puts "# Copyright 2011-13 by Mark Ciotola; available for use under GNU license      #"
puts "# Last revised on 25 October 2013                                             #"
puts "#_____________________________________________________________________________#"
puts "#                                                                             #"
puts "# Description:                                                                #"
puts "# This program generates a silumation of Newton's Law of Cooling.             #"
puts "#                                                                             #"
puts "###############################################################################"

      ###############################################################################
      #                                                                             #
      # Developed with Ruby 1.9.2                                                   #
      # Takes the following parameters: temperature of reservoirs                   #
      #                                                                             #
      ###############################################################################

# GOALS
# This simulation introduces several Ruby features: user input and output files.


# Include
  include Math

puts "\n\n"
puts "INTRODUCTION"
puts "\n"
puts "This programs simulates the cooling of a warm object in a cooler environment\n"
puts "according to Newton's Law of Cooling.  As the object cools, its temperature\n"
puts "decreases. (This law works for the warming of an object as well.)\n"
puts "\n"
puts "However, the idealized environment has an unlimited ability to absorb heat,\n"
puts "so its temperature remains constant. This is a reasonable approximation for\n"
puts "ordinary objects that are much smaller than their environment.\n"
puts "\n"
puts "There is an object constant that is dependent upon the characteristics of the.\n"
puts "object such as its material, volume and surface area. Setting it to 1 is low\n"
puts "for a typical object, but allows for a faster temperature decrease.\n"
puts "\n"
puts "\n"
puts "INSTRUCTIONS"
puts "\n"
puts "You will be asked to enter an optional initial object temperature. All \n"
puts "temperatures are in Kelvin.  Default values are shown in '[ ]' marks.\n"
puts "\n" 
puts "Type Control-c to stop program if it gets stuck in a loop."
puts "\n"

# Initialize Simulation Parameters (initialize parameters here)

	periods = 10.0  # Periods; need to set to float for later calcs
	defaultobjecttemperature = 500.0
	environmenttemperature = 300.00  # about typical room temperature
	objectconstant = 1.0
	

# User Inputs Simulation Parameters

  prompt = "> "

  puts "\n"
  puts "USER PARAMETER ENTRY"
  puts "\n"
  
  puts "Please enter a positive number for the initial object temperature ["+ defaultobjecttemperature.to_s+"]: \n"
  print prompt
  inittemp = gets.chomp
  
  	if inittemp.to_f > 0
		initobjecttemperature = inittemp.to_f
	else
		initobjecttemperature = defaultobjecttemperature
	end


# optional output file	
  puts "\n"
  puts "What is the desired name for your output file? [newton_cooling_ebs.txt]:"
  print prompt
  output_file_ebs = STDIN.gets.chomp()

  	if output_file_ebs > ""
	    output_file_ebs = output_file_ebs
	else
		output_file_ebs = "newton_cooling_ebs.txt"
	end

target = File.open(output_file_ebs, 'w')


# Display Initial Parameter Values

  # Write to screen
    puts "\n\n"
    puts "PARAMETERS: \n\n"

	puts sprintf "  Object Constant (s^-1): \t %11.0f " , objectconstant
	puts sprintf "  Env Temp (K): \t\t %11.0f " , environmenttemperature
	puts sprintf "  Initial Object Temp (K): \t %11.0f " , initobjecttemperature


       
# Display Simulation Banner
 
  puts "\n\n"  
  puts "RESULTS: (at end of period)\n\n"

  puts "PERIOD\t ENV TEMP      OBJ TMP  \t       TMP CH RT "
  puts "------\t --------     ----------\t      -----------\n"


# Calculate and Display Simulation Results (this is a loop)

  
  #Set Initial Period Number and Counters
  
	period = 1.0             # Initialize period; is set to float for later calcs
    objecttemperature = initobjecttemperature
          
    i = period
    j = periods
	
	
  # Start Loop
	
  while i <= j do
	
	objectbegintemp = objecttemperature  # temperature of object at beginning of period
		
	objecttemperature = environmenttemperature + ( (initobjecttemperature - environmenttemperature) * exp( - objectconstant * i ) )

    objecttempchangerate = objecttemperature - objectbegintemp
	

      # Display variables

		per = i
		te = environmenttemperature
		th = objecttemperature
		tr = objecttempchangerate

        
	  # Formatting and Output
	  
		 mystring = (" %02d\t%8.2f\t%7.2f\t\t\t%8.2f")
		 puts sprintf mystring, per, te, th, tr

	  # Write to Output File
		 periodstring = per.to_s+"\t"+te.to_s+"\t"+th.to_s+"\t"+tr.to_s
		 target.write(periodstring)
		 target.write("\n")

  
      i = i + 1
  end
  

# Close Output File

 target.close()

  puts "\n"
  puts "\nDone. \n\n\n"


# End Matter, Including Key to Output

  puts "KEY: \n\n"
  puts "  PERIOD: \tElapsed time in seconds\n"
  puts "  ENV TEMP: \tTemperature of Environment in Kelvin\n"
  puts "  OBJ TMP: \tTemperature of Object in Kelvin\n"
  puts "  TMP CH RT: \tRate of Temperature Change of Object in Kelvin/per second\n"
  puts "  \n\n"

  puts "================================= References ==================================\n\n"
  puts "Daniel V. Schroeder, 2000, \"An Introduction to Thermal Physics.\""
  puts "http://www.biology.arizona.edu/biomath/tutorials/applications/cooling.html"
  puts "\n\n"

