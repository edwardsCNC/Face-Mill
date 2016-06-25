class Rectangle

	def initialize(width, height, tool_radius, radial_depth_of_cut)
		@width = width
		@height = height	
		@tool_radius = tool_radius
		@radial_depth_of_cut = radial_depth_of_cut

		#initially, the remaining stock of material is the same as the initial stock of material.
		#later, as material is cut away, the remaining stock of material will be reduced.
		@remaining_x_stock = @width
		@remaining_y_stock = @height
	end

	#whenever the cutting tool is moved in the Y direction, the remaining width of material is reduced.
	def reduce_width
		@remaining_x_stock -= @radial_depth_of_cut
	end

	#whenever the cutting tool is moved in the X direction, the remaining height of material is reduced.
	def reduce_height
		@remaining_y_stock -= @radial_depth_of_cut
	end

	def generate_face_milling_toolpath
		#define a local variable needed in the toolpath generating loop.
		i = 1.000

		#feed around the successively shorter edges of the stock. exit loop if remaining stock along either X or Y axis is zero.
		until @remaining_x_stock < 0 || @remaining_y_stock < 0

			#move the cutting tool in the +Y direction, which reduces the remaining width.
			puts "G1Y#{(@height + @tool_radius - i*@radial_depth_of_cut).round(3)}"
				reduce_width
				if @remaining_x_stock < 0
					break
				end

			#move the cutting tool in the +X direction, which reduces the remaining height.
			puts "G1X#{(@width + @tool_radius -i*@radial_depth_of_cut).round(3)}"
				reduce_height
				if @remaining_y_stock < 0
					break
				end

			#move the cutting tool in the -Y direction, which reduces the remaining width.
			puts "G1Y#{(-@tool_radius + i*@radial_depth_of_cut).round(3)}"
				reduce_width
				if @remaining_x_stock < 0
					break
				end

			#during the first +Y cut within this loop, the cutting tool removed material from the left side of the material.
			#the upcoming -X cut will end by positioning the tool in an X position that is one radial depth of cut further in the +X direction.
			#since the X position is determined by the incrementer times the radial depth of cut, increase the incrementer now.
			i += 1.000

			#move the cutting tool in the -X direction, which reduces the remaining height.
			puts "G1X#{(-@tool_radius + i*@radial_depth_of_cut).round(3)}"
				reduce_height
				if @remaining_y_stock < 0
					break
				end

		end
	end

end