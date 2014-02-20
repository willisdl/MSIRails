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

    it 'should return Subregion 21 Date_DESC' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 date desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Date_DESC', :MSI_generalFilterValue => '21'}
      assigns(:asams)[0].tx_yyyy.should == 2009
      assigns(:asams)[0].tx_num.should == 345
      assigns(:asams).last.tx_yyyy.should == 1995
      assigns(:asams).last.tx_num.should == 85
    end

    it 'should return Subregion 21 date asc' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 date asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Date_ASC', :MSI_generalFilterValue => '21'}
      assigns(:asams)[0].tx_yyyy.should == 1995
      assigns(:asams)[0].tx_num.should == 85
      assigns(:asams).last.tx_yyyy.should == 2009
      assigns(:asams).last.tx_num.should == 345
    end

    it 'should return Subregion 21 ref desc' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 ref desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Number_DESC', :MSI_generalFilterValue => '21'}
      assigns(:asams)[0].tx_yyyy.should == 2009
      assigns(:asams)[0].tx_num.should == 345
      assigns(:asams).last.tx_yyyy.should == 1995
      assigns(:asams).last.tx_num.should == 85
    end

    it 'should return Subregion 21 ref asc' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 ref asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Number_ASC', :MSI_generalFilterValue => '21'}
      assigns(:asams)[0].tx_yyyy.should == 1995
      assigns(:asams)[0].tx_num.should == 85
      asamsize = :asams.length - 1
      assigns(:asams).last.tx_yyyy.should == 2009
      assigns(:asams).last.tx_num.should == 345
    end

    it 'should return Subregion 21 desc specificdate' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 desc specificdate")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Date_DESC', :MSI_generalFilterValue => '21', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2002-DEC-06'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 357
    end

    it 'should return Subregion 21 desc daterange' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 desc daterange")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Date_DESC', :MSI_generalFilterValue => '21', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2002-JAN-01:2004-MAY-01'}
      assigns(:asams)[0].tx_yyyy.should == 2004
      assigns(:asams)[0].tx_num.should == 102
      assigns(:asams).last.tx_yyyy.should == 2002
      assigns(:asams).last.tx_num.should == 34
    end

    it 'should return Subregion 21 asc daterange' do
      $stdout.puts(">>>>Test #{i}, Subregion 21 asc daterange")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'Subregion', :MSI_outputOptionValue1 => 'Date_ASC', :MSI_generalFilterValue => '21', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2002-JAN-01:2004-MAY-01'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 34
      assigns(:asams).last.tx_yyyy.should == 2004
      assigns(:asams).last.tx_num.should == 102
    end

    it 'should test All ASAMs date desc' do
      $stdout.puts(">>>>Test #{i}, All ASAMs date desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Date_DESC'}
      assigns(:asams)[0].tx_yyyy.should == 2009
      assigns(:asams)[0].tx_num.should == 419
    end

    it 'should test All ASAMs date asc' do
      $stdout.puts(">>>>Test #{i}, All ASAMs date asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Date_ASC'}
      assigns(:asams)[0].tx_yyyy.should == 2008
      assigns(:asams)[0].tx_num.should == 137
    end

    it 'should test All ASAMs ref desc' do
      $stdout.puts(">>>>Test #{i}, All ASAMs ref desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Number_DESC'}
      assigns(:asams)[0].tx_yyyy.should == 2009
      assigns(:asams)[0].tx_num.should == 421
    end

    it 'should test All ASAMs ref asc' do
      $stdout.puts(">>>>Test #{i}, All ASAMs ref asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Number_ASC'}
      assigns(:asams)[0].tx_yyyy.should == 1985
      assigns(:asams)[0].tx_num.should == 1
    end

    it 'should test All ASAMs date desc specificdate 18Sep08' do
      $stdout.puts(">>>>Test #{i}, All ASAMs date desc specificdate 18Sep08")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Date_DESC', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2008-SEP-18'}
      assigns(:asams)[0].tx_yyyy.should == 2008
      assigns(:asams)[0].tx_num.should == 362
    end

    it 'should test All ASAMs ref desc specificdate 18Sep08' do
      $stdout.puts(">>>>Test #{i}, All ASAMs date desc specificdate 18Sep08")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Number_DESC', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2008-SEP-18'}
      assigns(:asams)[0].tx_yyyy.should == 2008
      assigns(:asams)[0].tx_num.should == 362
    end

    it 'should test All ASAMs ref asc specificdate 18Sep08' do
      $stdout.puts(">>>>Test #{i}, All ASAMs date asc specificdate 18Sep08")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Number_ASC', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2008-SEP-18'}
      assigns(:asams)[0].tx_yyyy.should == 2008
      assigns(:asams)[0].tx_num.should == 336
    end

    it 'should test All ASAMs date asc specificdate 18Sep10 and return nil' do
      $stdout.puts(">>>>Test #{i}, All ASAMs date asc specificdate 18Sep10 and return nil")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Date_ASC', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2010-SEP-18'}
      assigns(:asams)[0].should == nil
    end

    it 'should test ASAMs by ref' do
      $stdout.puts(">>>>Test #{i}, ASAMs by ref")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'SpecificNumber', :MSI_outputOptionValue1 => 'Date_DESC', :MSI_generalFilterValue => '2008_336'}
      assigns(:asams)[0].victim.should == 'CHEMICAL TANKER'
    end

    it 'should test All ASAMs by desc daterange' do
      $stdout.puts(">>>>Test #{i}, All ASAMs by desc daterange")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Date_DESC', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2002-JAN-01:2002-MAY-01'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 130
    end

    it 'should test All ASAMs by asc daterange' do
      $stdout.puts(">>>>Test #{i}, All ASAMs by asc daterange")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'All', :MSI_outputOptionValue1 => 'Date_ASC', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2002-JAN-01:2002-MAY-01'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 2
    end

    #Number range 2002_245 to 2004_12  low end = 2002_245 high = 2004_12 count = 527
    it 'should return ASAM Ref range 2002_245 to 2004_12 ref desc' do
      $stdout.puts(">>>>Test #{i}, ASAM Ref range 2002_245 to 2004_12 desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'NumberRange', :MSI_generalFilterValue => '2002_245:2004_12', :MSI_outputOptionValue1 => 'Number_DESC'}
      assigns(:asams)[0].tx_yyyy.should == 2004
      assigns(:asams)[0].tx_num.should == 12
      assigns(:asams).length.should == 527
      assigns(:asams).last.tx_yyyy.should == 2002
      assigns(:asams).last.tx_num.should == 245
    end

    #Number range specific date 3sep02 low = 2002_252 high = 2002_253
    it 'should return ASAM Ref range 2002_245 to 2004_12 specific date 3sep02 ref desc' do
      $stdout.puts(">>>>Test #{i}, ASAM Ref range 2002_245 to 2004_12 desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'NumberRange', :MSI_generalFilterValue => '2002_245:2004_12', :MSI_outputOptionValue1 => 'Number_DESC', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2002-SEP-03'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 253
      assigns(:asams).length.should == 2
      assigns(:asams)[1].tx_yyyy.should == 2002
      assigns(:asams)[1].tx_num.should == 252
    end

    #date range 3sep02 to 1dec02 low = 2002_250 high = 2003_1 count = 96
    it 'should return ASAM Ref range 2002_245 to 2004_12 date range 3sep02 to 1dec02 ref desc' do
      $stdout.puts(">>>>Test #{i}, ASAM Ref range 2002_245 to 2004_12 desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'NumberRange', :MSI_generalFilterValue => '2002_245:2004_12', :MSI_outputOptionValue1 => 'Number_DESC', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2002-SEP-03:2002-DEC-01'}
      assigns(:asams)[0].tx_yyyy.should == 2003
      assigns(:asams)[0].tx_num.should == 1
      assigns(:asams).length.should == 96
      assigns(:asams).last.tx_yyyy.should == 2002
      assigns(:asams).last.tx_num.should == 250
    end

    #Number range 2002_245 to 2004_12  low end = 2002_245 high = 2004_12 count = 527
    it 'should return ASAM Ref range 2002_245 to 2004_12 ref asc' do
      $stdout.puts(">>>>Test #{i}, ASAM Ref range 2002_245 to 2004_12 asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'NumberRange', :MSI_generalFilterValue => '2002_245:2004_12', :MSI_outputOptionValue1 => 'Number_ASC'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 245
      assigns(:asams).length.should == 527
      assigns(:asams).last.tx_yyyy.should == 2004
      assigns(:asams).last.tx_num.should == 12
    end

    #Number range specific date 3sep02 low = 2002_252 high = 2002_253
    it 'should return ASAM Ref range 2002_245 to 2004_12 specific date 3sep02 ref asc' do
      $stdout.puts(">>>>Test #{i}, ASAM Ref range 2002_245 to 2004_12 asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'NumberRange', :MSI_generalFilterValue => '2002_245:2004_12', :MSI_outputOptionValue1 => 'Number_ASC', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2002-SEP-03'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 252
      assigns(:asams).length.should == 2
      assigns(:asams)[1].tx_yyyy.should == 2002
      assigns(:asams)[1].tx_num.should == 253
    end

    #date range 3sep02 to 1dec02 low = 2002_250 high = 2003_1 count = 96
    it 'should return ASAM Ref range 2002_245 to 2004_12 date range 3sep02 to 1dec02 ref asc' do
      $stdout.puts(">>>>Test #{i}, ASAM Ref range 2002_245 to 2004_12 asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'NumberRange', :MSI_generalFilterValue => '2002_245:2004_12', :MSI_outputOptionValue1 => 'Number_ASC', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2002-SEP-03:2002-DEC-01'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 250
      assigns(:asams).length.should == 96
      assigns(:asams).last.tx_yyyy.should == 2003
      assigns(:asams).last.tx_num.should == 1
    end

    #date range 3sep02 to 1dec02 low = 2002_250 high = 2003_1 count = 96
    it 'should return ASAM Ref range 2002_245 to 2004_12 date range 3sep02 to 1dec02 date desc' do
      $stdout.puts(">>>>Test #{i}, ASAM Ref range 2002_245 to 2004_12 daterange date desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'NumberRange', :MSI_generalFilterValue => '2002_245:2004_12', :MSI_outputOptionValue1 => 'Date_DESC', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2002-SEP-03:2002-DEC-01'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 343
      assigns(:asams).last.tx_yyyy.should == 2002
      assigns(:asams).last.tx_num.should == 252
    end

    #date range 3sep02 to 1dec02 low = 2002_250 high = 2003_1 count = 96
    it 'should return ASAM Ref range 2002_245 to 2004_12 date range 3sep02 to 1dec02 date asc' do
      $stdout.puts(">>>>Test #{i}, ASAM Ref range 2002_245 to 2004_12 daterange date asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'NumberRange', :MSI_generalFilterValue => '2002_245:2004_12', :MSI_outputOptionValue1 => 'Date_ASC', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2002-SEP-03:2002-DEC-01'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 252
      assigns(:asams).last.tx_yyyy.should == 2002
      assigns(:asams).last.tx_num.should == 343
    end

    #Number range 2002_245 to 2004_12  low end = 2002_245 high = 2004_12 count = 527
    it 'should return ASAM Ref range 2002_245 to 2004_12 date desc' do
      $stdout.puts(">>>>Test #{i}, ASAM Ref range 2002_245 to 2004_12 date desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'NumberRange', :MSI_generalFilterValue => '2002_245:2004_12', :MSI_outputOptionValue1 => 'Date_DESC'}
      assigns(:asams)[0].tx_yyyy.should == 2004
      assigns(:asams)[0].tx_num.should == 12
      assigns(:asams).last.tx_yyyy.should == 2002
      assigns(:asams).last.tx_num.should == 245
    end

    #Number range 2002_245 to 2004_12  low end = 2002_245 high = 2004_12 count = 527
    it 'should return ASAM Ref range 2002_245 to 2004_12 date asc' do
      $stdout.puts(">>>>Test #{i}, ASAM Ref range 2002_245 to 2004_12 date asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'NumberRange', :MSI_generalFilterValue => '2002_245:2004_12', :MSI_outputOptionValue1 => 'Date_ASC'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 245
      assigns(:asams).last.tx_yyyy.should == 2004
      assigns(:asams).last.tx_num.should == 12
    end

    #Number range 2002_245 to 2004_12  low end = 2002_245 high = 2004_12 count = 527
    it 'should return ASAM Ref range 2002_245 to 2004_12 date asc' do
      $stdout.puts(">>>>Test #{i}, ASAM Ref range 2002_245 to 2004_12 date asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'NumberRange', :MSI_generalFilterValue => '2002_245:2004_12', :MSI_outputOptionValue1 => 'Date_ASC'}
      assigns(:asams)[0].tx_yyyy.should == 2002
      assigns(:asams)[0].tx_num.should == 245
      assigns(:asams).last.tx_yyyy.should == 2004
      assigns(:asams).last.tx_num.should == 12
    end

    it 'should return ASAMs by victim (yacht) date desc' do
      $stdout.puts(">>>>Test #{i}, ASAMs by victim (yacht) date desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'VictimName', :MSI_outputOptionValue1 => 'Date_DESC', :MSI_generalFilterValue => 'yacht'}
      assigns(:asams)[0].tx_yyyy.should == 2009
      assigns(:asams)[0].tx_num.should == 297
      assigns(:asams).last.tx_yyyy.should == 1996
      assigns(:asams).last.tx_num.should == 9
    end

    it 'should return ASAMs by victim (yacht) date asc' do
      $stdout.puts(">>>>Test #{i}, ASAMs by victim (yacht) date asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'VictimName', :MSI_outputOptionValue1 => 'Date_ASC', :MSI_generalFilterValue => 'yacht'}
      assigns(:asams)[0].tx_yyyy.should == 1996
      assigns(:asams)[0].tx_num.should == 9
      assigns(:asams).last.tx_yyyy.should == 2009
      assigns(:asams).last.tx_num.should == 297
    end

    it 'should return ASAMs by victim (yacht) ref desc' do
      $stdout.puts(">>>>Test #{i}, ASAMs by victim (yacht) ref desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'VictimName', :MSI_outputOptionValue1 => 'Number_DESC', :MSI_generalFilterValue => 'yacht'}
      assigns(:asams)[0].tx_yyyy.should == 2009
      assigns(:asams)[0].tx_num.should == 297
      assigns(:asams).last.tx_yyyy.should == 1996
      assigns(:asams).last.tx_num.should == 9
    end

    it 'should return ASAMs by victim (yacht) ref asc' do
      $stdout.puts(">>>>Test #{i}, ASAMs by victim (yacht) ref asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'VictimName', :MSI_outputOptionValue1 => 'Number_ASC', :MSI_generalFilterValue => 'yacht'}
      assigns(:asams)[0].tx_yyyy.should == 1996
      assigns(:asams)[0].tx_num.should == 9
      assigns(:asams).last.tx_yyyy.should == 2009
      assigns(:asams).last.tx_num.should == 297
    end

    it 'should return ASAMs by victim (yacht) daterange date desc' do
      $stdout.puts(">>>>Test #{i}, ASAMs by victim (yacht) daterange date desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'VictimName', :MSI_outputOptionValue1 => 'Date_DESC', :MSI_generalFilterValue => 'yacht', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2001-JAN-01:2001-DEC-31'}
      assigns(:asams)[0].tx_yyyy.should == 2001
      assigns(:asams)[0].tx_num.should == 351
      assigns(:asams).last.tx_yyyy.should == 2001
      assigns(:asams).last.tx_num.should == 119
    end

    it 'should return ASAMs by victim (yacht) daterange daterange date asc' do
      $stdout.puts(">>>>Test #{i}, ASAMs by victim (yacht) date asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'VictimName', :MSI_outputOptionValue1 => 'Date_ASC', :MSI_generalFilterValue => 'yacht', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2001-JAN-01:2001-DEC-31'}
      assigns(:asams)[0].tx_yyyy.should == 2001
      assigns(:asams)[0].tx_num.should == 119
      assigns(:asams).last.tx_yyyy.should == 2001
      assigns(:asams).last.tx_num.should == 351
    end

    it 'should return ASAMs by victim (yacht) daterange ref desc' do
      $stdout.puts(">>>>Test #{i}, ASAMs by victim (yacht) daterange ref desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'VictimName', :MSI_outputOptionValue1 => 'Number_DESC', :MSI_generalFilterValue => 'yacht', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2001-JAN-01:2001-DEC-31'}
      assigns(:asams)[0].tx_yyyy.should == 2001
      assigns(:asams)[0].tx_num.should == 351
      assigns(:asams).last.tx_yyyy.should == 2001
      assigns(:asams).last.tx_num.should == 119
    end

    it 'should return ASAMs by victim (yacht) daterange ref asc' do
      $stdout.puts(">>>>Test #{i}, ASAMs by victim (yacht) daterange ref asc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'VictimName', :MSI_outputOptionValue1 => 'Number_ASC', :MSI_generalFilterValue => 'yacht', :MSI_additionalFilterType1 => 'DateRange', :MSI_additionalFilterValue1 => '2001-JAN-01:2001-DEC-31'}
      assigns(:asams)[0].tx_yyyy.should == 2001
      assigns(:asams)[0].tx_num.should == 119
      assigns(:asams).last.tx_yyyy.should == 2001
      assigns(:asams).last.tx_num.should == 351
    end

    it 'should return ASAMs by victim (yacht) specificdate date desc' do
      $stdout.puts(">>>>Test #{i}, ASAMs by victim (yacht) specificdate date desc")
      i += 1
      get 'asam_query', {:MSI_generalFilterType => 'VictimName', :MSI_outputOptionValue1 => 'Date_DESC', :MSI_generalFilterValue => 'yacht', :MSI_additionalFilterType1 => 'SpecificDate', :MSI_additionalFilterValue1 => '2001-AUG-12'}
      assigns(:asams)[0].tx_yyyy.should == 2001
      assigns(:asams)[0].tx_num.should == 244
    end

  end

end