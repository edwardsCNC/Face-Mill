class Rectangle

	def initialize(width, height, tool_radius, radial_depth_of_cut)
		@width = width
		@height = height	
		@tool_radius = tool_radius
		@radial_depth_of_cut = radial_depth_of_cut
	end

	def generate_face_milling_toolpath
		#define local variables needed in the toolpath generating loop
		i = 1.000
		remaining_x_stock = @width
		remaining_y_stock = @height

		#feed around the successively shorter edges of the stock. exit loop if remaining stock along either X or Y axis is zero
		until remaining_x_stock < 0 || remaining_y_stock < 0

			puts "G1Y#{(@height + @tool_radius - i*@radial_depth_of_cut).round(3)}"
				remaining_x_stock = remaining_x_stock - @radial_depth_of_cut
				if remaining_x_stock < 0
					break
				end

			puts "G1X#{(@width + @tool_radius -i*@radial_depth_of_cut).round(3)}"
				remaining_y_stock = remaining_y_stock - @radial_depth_of_cut
				if remaining_y_stock < 0
					break
				end

			puts "G1Y#{(-@tool_radius + i*@radial_depth_of_cut).round(3)}"
				remaining_x_stock = remaining_x_stock - @radial_depth_of_cut 
				if remaining_x_stock < 0
					break
				end

			i = i + 1.000

			puts "G1X#{(-@tool_radius + i*@radial_depth_of_cut).round(3)}"
				remaining_y_stock = remaining_y_stock - @radial_depth_of_cut
				if remaining_y_stock < 0
					break
				end

		end
	end

end