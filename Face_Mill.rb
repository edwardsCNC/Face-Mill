#________check that all variables are used
#move to home?
#consistent comment syntax
#setup instructions and introduction. describe to the user what the program will do.

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
puts "G0X#{(-2*tool_radius).round(2)}Y#{(-2*tool_radius).round(2)}"

#create block specifying spindle speed. start the spindle. start coolant flow.
puts "S#{spindle_speed}M03M08"

#create block for feed to position of first cut. include the feedrate.
puts "G1X#{(-tool_radius + radial_depth_of_cut).round(2)}Y#{(-tool_radius + radial_depth_of_cut).round(2)}F#{feedrate.round(2)}"

#define some variables needed in the toolpath generating loop
i = 1.000
remaining_x_stock = width
remaining_y_stock = height

#feed around the successively shorter edges of the stock
while remaining_x_stock > 0 and remaining_x_stock > 0

puts "G1Y#{(height + tool_radius - i*radial_depth_of_cut).round(2)}"
puts "G1X#{(width + tool_radius -i*radial_depth_of_cut).round(2)}"
puts "G1Y#{(-tool_radius + i*radial_depth_of_cut).round(2)}"

i = i + 1.000

puts "G1 X#{(-tool_radius + i*radial_depth_of_cut).round(3)}"

remaining_x_stock = width - 2*(i - 1)*radial_depth_of_cut
remaining_y_stock = height - 2*(i - 1)*radial_depth_of_cut

end

#if the material's height or width is exactly divisible by the radial depth of cut, there may be a very small line of uncut material in the center of the stock.
#in this case, feed through the center of the stock to remove any remaining material.
if remaining_x_stock == 0
	puts "G1 X#{(width/2).round(3)}" 	#feed to the x center of the stock
	puts "G1 Y#{(height + tool_radius - i*radial_depth_of_cut).round(3)}" #feed to the top end of the last upward cut in the Y direction
elsif remaining_y_stock == 0
	puts "G1 Y#{(height/2).round(3)}" #feed to the y center of the stock
	puts "G1 X#{(-tool_radius + i*radial_depth_of_cut).round(3)}" #feed to the right end of the last rightward cut in the X direction
end

#retract the tool to a safe height above the work surface
puts "G91 G0 Z#{safe_height}"
puts "G90"

#turn off the spindle and coolant 
puts "M04M09"

#return to X0Y0
puts "G0X0Y0"

#end the program
puts "M30"

puts ""

