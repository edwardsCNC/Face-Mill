require '../lib/CNCHelper.rb'
require './spec_helper.rb'

RSpec.describe CNCHelper do
	
  it "generates a rapid feed toolpath to a safe starting position of negative 2x the tool radius along the X and Y axes" do
    helper = CNCHelper.new(0.125, 0.225, 15.0, 0.25)
    expect {helper.program_before_face_milling}.to output(/G0X-0.25Y-0.25\n/).to_stdout	
  end

end