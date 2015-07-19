class CNCHelper

	def initialize(units, tool_number, tool_radius, radial_depth_of_cut, feedrate, spindle_speed, safe_height)
		@units = units
		@tool_number = tool_number
		@tool_radius = tool_radius
		@radial_depth_of_cut = radial_depth_of_cut
		@feedrate = feedrate
		@spindle_speed = spindle_speed
		@safe_height = safe_height
	end

	def program_before_face_milling
		#safety block including absolute mode, canned cycle cancellation, and cutter radius compensation cancellation
		puts "G90G80G40"

		#block with preparatory command for units selection
		if @units == "metric"
			puts "G21"

			elsif @units == "imperial"
				  puts "G20"

			else #default to metric in case of inexact match between user input and logical condition
				puts "G21"

		end

		#tool selection
		puts "T#{@tool_number}M06"

		#approach in +X direction from -X position
		#rapid feed to safe position before machining
		puts "G0X#{(-2*@tool_radius).round(3)}Y#{(-2*@tool_radius).round(3)}"

		#create block specifying spindle speed. start the spindle. start coolant flow.
		puts "S#{@spindle_speed}M03M08"

		#create block for feed to position of first cut. include the feedrate.
		puts "G1X#{(-@tool_radius + @radial_depth_of_cut).round(3)}Y#{(-@tool_radius + @radial_depth_of_cut).round(3)}F#{@feedrate.round(3)}"
	end

	def program_after_face_milling
		#retract the tool to a safe height above the work surface
		puts "G91G0Z#{@safe_height}"
		puts "G90"

		#turn off the spindle and coolant 
		puts "M04M09"

		#return to X0Y0
		puts "G0X0Y0"

		#end the program
		puts "M30"

		puts ""
	end

end