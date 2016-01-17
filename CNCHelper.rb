class CNCHelper

	def initialize(tool_radius, radial_depth_of_cut, feedrate, safe_height)
		@tool_radius = tool_radius
		@radial_depth_of_cut = radial_depth_of_cut
		@feedrate = feedrate
		@safe_height = safe_height
	end

	def program_before_face_milling

		#approach in +X direction from -X position
		#rapid feed to safe position before machining
		puts "G0X#{(-2*@tool_radius).round(3)}Y#{(-2*@tool_radius).round(3)}"

		#create block for feed to position of first cut. include the feedrate.
		puts "G1X#{(-@tool_radius + @radial_depth_of_cut).round(3)}Y#{(-@tool_radius + @radial_depth_of_cut).round(3)}F#{@feedrate.round(3)}"
	end

	def program_after_face_milling
		#retract the tool to a safe height above the work surface
		puts "G91G0Z#{@safe_height}"
		puts "G90"

		#return to X0Y0
		puts "G0X0.0Y0.0"

		puts ""
	end

end