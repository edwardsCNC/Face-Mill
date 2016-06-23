require '../lib/Rectangle.rb'
require './spec_helper.rb'

RSpec.describe Rectangle do

	it "generates a face-milling toolpath which mills the entire flat surface specified by the user" do
		rectangle = Rectangle.new(0.5, 0.5, 0.125, 0.225)
		expect {rectangle.generate_face_milling_toolpath}.to output("G1Y0.4\nG1X0.4\nG1Y0.1\nG1X0.325\nG1Y0.175\n").to_stdout
	end

end