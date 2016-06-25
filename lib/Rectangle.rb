class Rectangle

	def initialize(width, height, tool_radius, radial_depth_of_cut)
		@width = width
		@height = height	
		@tool_radius = tool_radius
		@radial_depth_of_cut = radial_depth_of_cut

		#initially, the remaining material is the same as the initial material.
		#later, as material is cut away, the remaining material will be reduced.
		@remaining_x_material = @width
		@remaining_y_material = @height
	end

	#whenever the cutting tool is moved in the Y direction, the remaining width of material is reduced.
	def reduce_width
		@remaining_x_material -= @radial_depth_of_cut
	end

	#whenever the cutting tool is moved in the X direction, the remaining height of material is reduced.
	def reduce_height
		@remaining_y_material -= @radial_depth_of_cut
	end

	#returns true if either all X stock has been cut away or all Y stock has been cut away.
	def cutting_complete?
		true if (@remaining_x_material < 0) || (@remaining_y_material < 0)
	end

	def generate_face_milling_toolpath
		#define a local variable needed in the toolpath generating block.
		i = 1.000

		#generate a toolpath / CNC program that feeds along successively smaller edges of remaining material
		until cutting_complete?

			#move the cutting tool in the +Y direction, which reduces the remaining width.
			puts "G1Y#{(@height + @tool_radius - i*@radial_depth_of_cut).round(3)}"
				reduce_width
				break if cutting_complete?

			#move the cutting tool in the +X direction, which reduces the remaining height.
			puts "G1X#{(@width + @tool_radius -i*@radial_depth_of_cut).round(3)}"
				reduce_height
				break if cutting_complete?

			#move the cutting tool in the -Y direction, which reduces the remaining width.
			puts "G1Y#{(-@tool_radius + i*@radial_depth_of_cut).round(3)}"
				reduce_width
				break if cutting_complete?

			#during the first +Y cut within this block, the cutting tool removed material from the left side of the material.
			#the upcoming -X cut will end by positioning the tool in an X position that is one radial depth of cut further in the +X direction.
			#since the X position is determined by the incrementer times the radial depth of cut, increase the incrementer now.
			i += 1.000

			#move the cutting tool in the -X direction, which reduces the remaining height.
			puts "G1X#{(-@tool_radius + i*@radial_depth_of_cut).round(3)}"
				reduce_height
				break if cutting_complete?

		end
	end

end