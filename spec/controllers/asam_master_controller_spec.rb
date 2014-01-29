require 'spec_helper'

describe AsamMasterController do

  i = 1
  describe 'asam' do
    it 'populates Subregions' do
      $stdout.puts(">>>>Test #{i}, populates Subregions")
      i += 1
      subregions = Array.new
      subregions.concat(AsamMasterController.new.asam)
      subregions[0][1].should == 11
      sub_length = subregions.length
      subregions[sub_length -1][1].should == 97
    end
  end

  describe 'asam_query' do
    it 'should return Subregion 21 date desc' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 date desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Date DESC', :MSI_generalFilterValue => '21'}
      assigns(:asams)[0].tx_yyyy.should == 2009
      assigns(:asams)[0].tx_num.should == 345
    end

    it 'should return Subregion 21 date asc' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 date asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Date ASC', :MSI_generalFilterValue => '21'}
      assigns(:asams)[0].tx_yyyy.should == 1995
      assigns(:asams)[0].tx_num.should == 85
    end

    it 'should return Subregion 21 ref desc' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 ref desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Number DESC', :MSI_generalFilterValue => '21'}
      assigns(:asams)[0].tx_yyyy.should == 2009
      assigns(:asams)[0].tx_num.should == 345
    end

    it 'should return Subregion 21 ref asc' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 ref asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Number ASC', :MSI_generalFilterValue => '21'}
      assigns(:asams)[0].tx_yyyy.should == 1995
      assigns(:asams)[0].tx_num.should == 85
    end

    it 'should return Subregion 21 desc specificdate' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 desc specificdate")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Date DESC', :MSI_generalFilterValue => '21', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2002-DEC-06'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 357
    end

    it 'should return Subregion 21 desc daterange' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 desc daterange")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Date DESC', :MSI_generalFilterValue => '21', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2002-JAN-01:2004-MAY-01'}
      assigns(:asams)[0].tx_yyyy.should == 2004
      assigns(:asams)[0].tx_num.should == 102
    end

    it 'should test All ASAMs date desc' do
      $stdout.puts(">>>>Test #{i}, All ASAMs date desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Date DESC'}
      assigns(:asams)[0].tx_yyyy.should == 2009
      assigns(:asams)[0].tx_num.should == 410
    end

    it 'should test All ASAMs date asc' do
      $stdout.puts(">>>>Test #{i}, All ASAMs date asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Date ASC'}
      assigns(:asams)[0].tx_yyyy.should == 2008
      assigns(:asams)[0].tx_num.should == 137
    end

    it 'should test All ASAMs ref desc' do
      $stdout.puts(">>>>Test #{i}, All ASAMs ref desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Number DESC'}
      assigns(:asams)[0].tx_yyyy.should == 2009
      assigns(:asams)[0].tx_num.should == 421
    end

    it 'should test All ASAMs ref asc' do
      $stdout.puts(">>>>Test #{i}, All ASAMs ref asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Number ASC'}
      assigns(:asams)[0].tx_yyyy.should == 1985
      assigns(:asams)[0].tx_num.should == 1
    end

    it 'should test All ASAMs date desc specificdate 18Sep08' do
      $stdout.puts(">>>>Test #{i}, All ASAMs date desc specificdate 18Sep08")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Date DESC', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2008-SEP-18'}
      assigns(:asams)[0].tx_yyyy.should == 2008
      assigns(:asams)[0].tx_num.should == 336
    end

    it 'should test All ASAMs date asc specificdate 18Sep08' do
      $stdout.puts(">>>>Test #{i}, All ASAMs date asc specificdate 18Sep08")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Date ASC', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2008-SEP-18'}
      assigns(:asams)[0].tx_yyyy.should == 2008
      assigns(:asams)[0].tx_num.should == 336
    end

    it 'should test All ASAMs date asc specificdate 18Sep10 and return nil' do
      $stdout.puts(">>>>Test #{i}, All ASAMs date asc specificdate 18Sep10 and return nil")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Date ASC', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2010-SEP-18'}
      assigns(:asams)[0].should == nil
    end

    it 'should test ASAMs by ref date desc' do
      $stdout.puts(">>>>Test #{i}, ASAMs by ref date desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'SpecificNumber', :MSI_generalFilterValue => '2008_336', :MSI_outputOptionValue1 => 'Date DESC'}
      assigns(:asams)[0].victim.should == 'CHEMICAL TANKER'
    end

    it 'should test ASAMs by ref specific date' do
      $stdout.puts(">>>>Test #{i}, ASAMs by ref specific date")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'SpecificNumber', :MSI_generalFilterValue => '2008_336', :MSI_outputOptionValue1 => 'Date DESC', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2008-SEP-18'}
      assigns(:asams)[0].victim.should == 'CHEMICAL TANKER'
    end

    it 'should test ASAMs by ref date range' do
      $stdout.puts(">>>>Test #{i}, ASAMs by ref date range")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'SpecificNumber', :MSI_generalFilterValue => '2008_336', :MSI_outputOptionValue1 => 'Date DESC', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2008-JAN-01:2009-JAN-01'}
      assigns(:asams)[0].victim.should == 'CHEMICAL TANKER'
    end

    it 'should test ASAMs by ref specific date return nil' do
      $stdout.puts(">>>>Test #{i}, ASAMs by ref specific date return nil")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'SpecificNumber', :MSI_generalFilterValue => '2008_336', :MSI_outputOptionValue1 => 'Date DESC', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2009-SEP-18'}
      assigns(:asams)[0].should == nil
    end

    it 'should test ASAMs by ref date range return nil' do
      $stdout.puts(">>>>Test #{i}, ASAMs by ref date range return nil")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'SpecificNumber', :MSI_generalFilterValue => '2008_336', :MSI_outputOptionValue1 => 'Date DESC', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2007-JAN-01:2008-JAN-01'}
      assigns(:asams)[0].should == nil
    end
  end

end