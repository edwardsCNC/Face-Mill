require './rectangle.rb'

#explain the program
	puts ""
	puts "This utility creates a climb milling CNC program which can be used to machine a rectangular flat surface."
	puts ""
	puts "The tool will rapidly approach the workpiece in the +X direction from the -X direction. It will then start cutting in the +Y direction."
	puts ""
	puts "On the machine, X=0 and Y=0 should be set to the furthest -X and -Y point on the workpiece, with empty space on the -X side of the workpiece."
	puts ""
	puts "Before running your CNC program, move the tool to the empty space to the -X side of the workpiece, and set your tool at the desired Z depth."


#get user input
	puts ""
	puts "You will now be prompted to input specifications of your desired program."
	puts ""

	puts "Will the units of the program be metric (millimeters) or imperial (inches)? Type and enter \"metric\" or \"imperial\". An inexact input will result in a default setting of metric units."
	units = String(gets.chomp)

	puts "What is the length of the material to be face-milled in the X direction?"
	width = Float(gets)

	puts "What is the length of the material to be face-milled in the Y direction?"
	height = Float(gets)

	puts "What is the ATC number of the tool to be used? (Be sure to include a zero before a single digit tool number; e.g. 01 instead of 1)"
	tool_number = String(gets.chomp)

	puts "What is the tool radius?"
	tool_radius = Float(gets)

	puts "What is the radial depth of cut?"
	radial_depth_of_cut = Float(gets)

	puts "What is the feedrate?"
	feedrate = Float(gets)

	puts "What is the spindle speed?"
	spindle_speed = Float(gets)

	puts "At the end of the program, the tool will retract to a safe distance above the material before rapid motion to X0Y0."
	puts "What is the height of the safe distance?"
	safe_height = Float(gets)

puts ""
puts "Here is your CNC program:"
puts ""

#safety block including absolute mode, canned cycle cancellation, and cutter radius compensation cancellation
puts "G90G80G40"

#block with preparatory command for units selection
if units == "metric"
	puts "G21"

	elsif units == "imperial"
		  puts "G20"

	else #default to metric in case of inexact match between user input and logical condition
		puts "G21"

end

#tool selection
puts "T#{tool_number}M06"

#assumes approach in +X direction from -X position
#rapid feed to safe position before machining
puts "G0X#{(-2*tool_radius).round(3)}Y#{(-2*tool_radius).round(3)}"

#create block specifying spindle speed. start the spindle. start coolant flow.
puts "S#{spindle_speed}M03M08"

#create block for feed to position of first cut. include the feedrate.
puts "G1X#{(-tool_radius + radial_depth_of_cut).round(3)}Y#{(-tool_radius + radial_depth_of_cut).round(3)}F#{feedrate.round(3)}"

Rectangle.new(width, height, tool_radius, radial_depth_of_cut).generate_face_milling_toolpath

#retract the tool to a safe height above the work surface
puts "G91G0Z#{safe_height}"
puts "G90"

#turn off the spindle and coolant 
puts "M04M09"

#return to X0Y0
puts "G0X0Y0"

#end the program
puts "M30"

puts ""