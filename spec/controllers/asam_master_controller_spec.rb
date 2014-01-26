require 'spec_helper'

describe 'AsamMasterController' do

  it 'populate Subregions' do

    asam = Array.new
    asam = AsamMaster

    asam.each do |sub|
      $stdout.puts(sub[0] + ' ' + sub[1])
    end
  end
end