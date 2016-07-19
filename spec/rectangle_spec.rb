require '../lib/Rectangle.rb'
require './spec_helper.rb'

RSpec.describe Rectangle do

	let(:rectangle) { Rectangle.new(0.5, 0.5, 0.125, 0.225) }

	it "generates a face-milling toolpath which mills the entire flat surface specified by the user" do
		expect {rectangle.generate_face_milling_toolpath}.to output("G1Y0.4\nG1X0.4\nG1Y0.1\nG1X0.325\nG1Y0.175\n").to_stdout
	end

	let(:rectangle_small_x_stock) { Rectangle.new(0.5, 1.0, 0.125, 0.225) }
	let(:rectangle_small_y_stock) { Rectangle.new(1.0, 0.5, 0.125, 0.225) }

	it "does not generate extraneous G1 commands once all X stock is machined" do
		expect {rectangle_small_x_stock.generate_face_milling_toolpath}.to output(/G1Y0.9\nG1X0.4\nG1Y0.1\nG1X0.325\nG1Y0.675\n(?!G1)/).to_stdout
	end

	it "does not generate extraneous G1 commands once all Y stock is machined" do
		expect {rectangle_small_y_stock.generate_face_milling_toolpath}.to output(/G1Y0.4\nG1X0.9\nG1Y0.1\nG1X0.325\nG1Y0.175\nG1X0.675\n(?!G1)/).to_stdout
	end

end