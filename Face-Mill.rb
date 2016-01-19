require './Rectangle.rb'
require './CNCHelper.rb'

#get user input

	puts ""

	puts "What is the length of the material to be face-milled in the X direction?"
	width = Float(gets)
	puts ""

	puts "What is the length of the material to be face-milled in the Y direction?"
	height = Float(gets)
	puts ""

	puts "What is the tool radius?"
	tool_radius = Float(gets)
	puts ""

	puts "What is the radial depth of cut?"
	radial_depth_of_cut = Float(gets)
	puts ""

	puts "What is the feedrate?"
	feedrate = Float(gets)
	puts ""

	puts "At the end of the program, the tool will retract to a safe height above the material before rapid motion to (X=0, Y=0)."
	puts "What is the safe height for rapid XY motion?"
	safe_height = Float(gets)
	puts ""

	puts "CNC mill setup instructions: The tool will rapidly approach the workpiece in the +X direction from the -X direction. It will then start cutting in the +Y direction. On the machine, X=0 and Y=0 should be set to the furthest -X and -Y point on the workpiece, with empty space on the -X side of the workpiece. Before running your CNC program, move the tool to the empty space to the -X side of the workpiece, and set your tool at the Z depth for your desired axial depth of cut."

	puts "Here is your CNC program. (Edit this to add spindle speed, coolant control, tool numbers, etc. as necessary)"
	puts ""

helper = CNCHelper.new(tool_radius, radial_depth_of_cut, feedrate, safe_height)
helper.program_before_face_milling

rectangle = Rectangle.new(width, height, tool_radius, radial_depth_of_cut)
rectangle.generate_face_milling_toolpath

helper.program_after_face_milling
