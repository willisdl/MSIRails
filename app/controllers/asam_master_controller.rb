class AsamMasterController < ApplicationController
  def home
  end

  def asam
    subregions = Array.new
    (11..19).each do |region|
      subregions.push(["Subregion #{region}", region])
    end
    (21..29).each do |region|
      subregions.push(["Subregion #{region}", region])
    end
    (35..38).each do |region|
      subregions.push(["Subregion #{region}", region])
    end
    (41..44).each do |region|
      subregions.push(["Subregion #{region}", region])
    end
    (51..57).each do |region|
      subregions.push(["Subregion #{region}", region])
    end
    (61..63).each do |region|
      subregions.push(["Subregion #{region}", region])
    end
    (71..76).each do |region|
      subregions.push(["Subregion #{region}", region])
    end
    (81..83).each do |region|
      subregions.push(["Subregion #{region}", region])
    end
    (91..97).each do |region|
      subregions.push(["Subregion #{region}", region])
    end
    @subregions = subregions
  end

  def asam_query
    msi_query_type = params[:MSI_queryType]
    msi_filter_type = params[:MSI_generalFilterType]
    msi_filter_value = params[:MSI_generalFilterValue]
    msi_filter_type1 = params[:MSI_additionalFilterType1]
    msi_filter_type2 = params[:MSI_additionalFilterType2]
    msi_filter_value1 = params[:MSI_additionalFilterValue1]
    msi_filter_value2 = params[:MSI_additionalFilterValue2]
    msi_sort_type = params[:MSI_outputOptionType1]
    msi_output_option_type2 = params[:MSI_outputOptionType2]
    msi_sort_value = params[:MSI_outputOptionValue1]
    msi_output_option_value2 = params[:MSI_outputOptionValue2]
    msi_map = params[:MSI_MAP]
    @searchparam = Array.new
    sort_ord = 'occur_date DESC, tx_yyyy DESC, tx_num DESC' if msi_sort_value.include? 'Date DESC'
    sort_ord = 'occur_date asc, tx_yyyy asc, tx_num asc' if msi_sort_value.include? 'Date ASC'
    sort_ord = 'tx_yyyy DESC, tx_num DESC' if msi_sort_value.include? 'Number DESC'
    sort_ord = 'tx_yyyy ASC, tx_num ASC' if msi_sort_value.include? 'Number ASC'
    @searchparam[0] = 'All Anti-Shipping Activity Messages' if msi_filter_type == 'All'
    @searchparam[0] = 'ASAMs by Subregion' if msi_filter_type == 'Subregion'
    @searchparam[0] = "Victim's Name" if msi_filter_type == 'VictimName'
    @searchparam[1] = msi_filter_value
    @searchparam[2] = 'None'
    @searchparam[3] = 'Descending Date of Occurrence' if msi_sort_value.include? 'Date DESC'
    @searchparam[3] = 'Ascending Date of Occurrence' if msi_sort_value.include? 'Date ASC'
    @searchparam[3] = 'Descending ASAM Ref. Number' if msi_sort_value.include? 'Number DESC'
    @searchparam[3] = 'Ascending ASAM Ref. Number' if msi_sort_value.include? 'Number ASC'

    #Search ASAMs with no criteria selected - return ALL ASAM messages
    if msi_filter_type == 'All'
      if msi_filter_type1 == 'SpecificDate'
        asamdate = DateTime.parse(msi_filter_value1)
        @asams = AsamMaster.where(occur_date: asamdate).order(sort_ord)
      elsif msi_filter_type1 == 'DateRange'
        asamdate = msi_filter_value1.split(':')
        date1 = DateTime.parse(asamdate[0])
        date2 = DateTime.parse(asamdate[1])
        @asams = AsamMaster.where(occur_date: date1..date2).order(sort_ord)
      else
        @asams = AsamMaster.order(sort_ord)
      end
    end

    #
    #Search ASAMs by specific Subregion
    #
    if msi_filter_type == 'Subregion'
      if msi_filter_type1 == 'SpecificDate'
        asamdate = DateTime.parse(msi_filter_value1)
        @asams = AsamMaster.where(subregion: msi_filter_value).where(occur_date: asamdate).order(sort_ord)
      elsif msi_filter_type1 == 'DateRange'
        asamdate = msi_filter_value1.split(':')
        date1 = DateTime.parse(asamdate[0])
        date2 = DateTime.parse(asamdate[1])
        @asams = AsamMaster.where(subregion: msi_filter_value).where(occur_date: date1..date2).order(sort_ord)
      else
        @asams = AsamMaster.where(subregion: msi_filter_value).order(sort_ord)
      end
    end

    #
    # Search for a specific reference number
    #
    if msi_filter_type == 'SpecificNumber'
      @searchparam[0] = "Single ASAM Ref. Number: #{msi_filter_value}"
      ref = msi_filter_value.split('_')
      @asams = AsamMaster.where(tx_yyyy: ref[0]).where(tx_num: ref[1])
    end

    #
    # Search for a range of reference numbers
    #
    if msi_filter_type == 'NumberRange'

      ref = msi_filter_value.split(':')
      ref1 = ref[0].split('_')
      ref2 = ref[1].split('_')
      year1 = ref1[0].to_i
      year2 = ref2[0].to_i
      @searchparam[0] = "ASAM Ref. Number Range: from #{year1}_#{ref1[1]} to #{year2}_#{ref2[1]}"
      @asams = Array.new


      midyears = year2 - year1
      clause = "(tx_yyyy = #{year1} and tx_num >= #{ref1[1]})"
      if midyears > 0
        (1..(midyears - 1)).each do |i|
          clause += " or (tx_yyyy = #{year1 + i})"
        end
      end
      clause += " or (tx_yyyy = #{year2} and tx_num <= #{ref2[1]})"

      if msi_filter_type1 == 'SpecificDate'
        asamdate = DateTime.parse(msi_filter_value1)
        @asams = AsamMaster.where(clause).where(occur_date: asamdate).order(sort_ord)
      elsif msi_filter_type1 == 'DateRange'
        asamdate = msi_filter_value1.split(':')
        date1 = DateTime.parse(asamdate[0])
        date2 = DateTime.parse(asamdate[1])
        @asams = AsamMaster.where(clause).where(occur_date: date1..date2).order(sort_ord)
      else
        @asams = AsamMaster.where(clause).order(sort_ord)
      end
    end

    #
    # Search ASAMs for specific victim
    #
    if msi_filter_type == 'VictimName'
      name = msi_filter_value.downcase
      if msi_filter_type1 == 'SpecificDate'
        asamdate = DateTime.parse(msi_filter_value1)
        @asams = AsamMaster.where('lower(victim) = ?', name).where(occur_date: asamdate).order(sort_ord)
      elsif msi_filter_type1 == 'DateRange'
        asamdate = msi_filter_value1.split(':')
        date1 = DateTime.parse(asamdate[0])
        date2 = DateTime.parse(asamdate[1])
        @asams = AsamMaster.where('lower(victim) = ?', name).where(occur_date: date1..date2).order(sort_ord)
      else
        @asams = AsamMaster.where('lower(victim) = ?', name).order(sort_ord)
      end


    end

  end

end
