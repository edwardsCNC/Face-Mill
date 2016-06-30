require '../lib/CNCHelper.rb'
require './spec_helper.rb'

RSpec.describe CNCHelper do

  let(:helper) { CNCHelper.new(0.125, 0.225, 15.0, 0.25) }
	
  it "generates a rapid feed toolpath to a safe starting position of negative 2x the tool radius along the X and Y axes" do
    expect {helper.program_before_face_milling}.to output(/G0X-0.25Y-0.25\n/).to_stdout	
  end

  it "generates a feed toolpath to the position of the first cut" do 
  	expect {helper.program_before_face_milling}.to output(/G1X0.1Y0.1/).to_stdout
  end

  it "completes the initial feed command with the feedrate specified by the user" do
  	expect {helper.program_before_face_milling}.to output(/F15.0\n/).to_stdout
  end

  it "generates a rapid feed toolpath to retract the tool to a safe height" do
    expect {helper.program_after_face_milling}.to output(/G91G0Z0.25\nG90/).to_stdout
  end

  it "generates a rapid feed toolpath to return the tool to X0.0Y0.0" do
    expect {helper.program_after_face_milling}.to output(/G0X0.0Y0.0/).to_stdout
  end

end