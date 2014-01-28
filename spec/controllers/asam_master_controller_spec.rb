require 'spec_helper'

describe AsamMasterController do

  describe 'asam' do
    it 'populates Subregions' do
      subregions = Array.new
      subregions.concat(AsamMasterController.new.asam)
      subregions[0][1].should == 11
      sub_length = subregions.length
      subregions[sub_length -1][1].should == 97
    end
  end

  describe 'asam_query' do
    it 'should return Subregion 11 ASAM VANDERPOOL EXPRESS' do
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Date DESC', :MSI_generalFilterValue => '11'}
      asams = AsamMaster.where(subregion: 11)
      #asams = AsamMasterController.instance_variable_get(:@asams).to_a
      assigns(:asams)[0].victim.should == 'VANDERPOOL EXPRESS'

    end

  end

end