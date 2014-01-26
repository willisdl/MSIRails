require 'spec_helper'

describe 'AsamMaster' do


  before do
    @asams = AsamMaster.where(subregion: 11)
    #$stdout.puts "Asam list length = " + @asams.length.to_s
  end

  it "should return VANDERPOOL EXPRESS" do
    @asams[0].victim.should == "VANDERPOOL EXPRESS"
    $stdout.puts "Latitude = " + @asams[0].latitude.to_s
  end

  it "should return coordinates of VANDERPOOL EXPRESS" do
    vanderpool = @asams[0].str_lat
    vanderpool[0].should == 25
    vanderpool[1].should == 47
    vanderpool[2].should == 00
    vanderpool[3].should == 'N'
  end



end