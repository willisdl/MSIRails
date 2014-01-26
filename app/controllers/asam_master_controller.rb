class AsamMasterController < ApplicationController
  def home
  end

  def asam
    @subregions = Array.new
    (11..19).each do |region|
      @subregions.push(["Subregion #{region}", region])
    end
    (21..29).each do |region|
      @subregions.push(["Subregion #{region}", region])
    end
    (35..38).each do |region|
      @subregions.push(["Subregion #{region}", region])
    end
    (41..44).each do |region|
      @subregions.push(["Subregion #{region}", region])
    end
    (51..57).each do |region|
      @subregions.push(["Subregion #{region}", region])
    end
    (61..63).each do |region|
      @subregions.push(["Subregion #{region}", region])
    end
    (71..76).each do |region|
      @subregions.push(["Subregion #{region}", region])
    end
    (81..83).each do |region|
      @subregions.push(["Subregion #{region}", region])
    end
    (91..97).each do |region|
      @subregions.push(["Subregion #{region}", region])
    end
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
    sort_ord = ''

    #Search ASAMs with no criteria selected - return ALL ASAM messages
    if msi_filter_type == 'All'
      #Sort by date of message
      if msi_sort_value.include? "Date"
        sort_ord = "occur_date DESC" if msi_sort_value.include? "DESC"
        sort_ord = "occur_date ASC" if msi_sort_value.include? "ASC"
        @searchparam[0] = 'All Anti-Shipping Activity Messages'
        @searchparam[1] = msi_filter_value
        @searchparam[2] = 'None'
        @searchparam[3] = 'Descending Date of Occurrence' if msi_sort_value.include? "DESC"
        @searchparam[3] = 'Ascending Date of Occurrence' if msi_sort_value.include? "ASC"
        @asams = AsamMaster.order(sort_ord)
      #Sort by reference number
      elsif msi_sort_value.include? "Number"
        sort_ord = "tx_yyyy DESC, tx_num DESC" if msi_sort_value.include? "DESC"
        sort_ord = "tx_yyyy ASC, tx_num ASC" if msi_sort_value.include? "ASC"
        @searchparam[0] = 'All Anti-Shipping Activity Messages'
        @searchparam[1] = msi_filter_value
        @searchparam[2] = 'None'
        @searchparam[3] = 'Descending ASAM Ref. Number' if msi_sort_value.include? "DESC"
        @searchparam[3] = 'Ascending ASAM Ref. Number' if msi_sort_value.include? "ASC"
        @asams = AsamMaster.order(sort_ord)
      end
    end

    #
    #Search ASAMs by specific Subregion
    #
    if msi_filter_type == 'Subregion'
      #Sort by date
      if msi_sort_value.include? "Date"
        sort_ord = "occur_date DESC" if msi_sort_value.include? "DESC"
        sort_ord = "occur_date ASC" if msi_sort_value.include? "ASC"
        @searchparam[0] = 'ASAMs by Subregion'
        @searchparam[1] = msi_filter_value
        @searchparam[2] = 'None'
        @searchparam[3] = 'Descending Date of Occurrence' if msi_sort_value.include? "DESC"
        @searchparam[3] = 'Ascending Date of Occurrence' if msi_sort_value.include? "ASC"
        @asams = AsamMaster.where(subregion: msi_filter_value).order(sort_ord)
      #Sort by ref number
      elsif msi_sort_value.include? "Number"
        sort_ord = "tx_yyyy DESC, tx_num DESC" if msi_sort_value.include? "DESC"
        sort_ord = "tx_yyyy ASC, tx_num ASC" if msi_sort_value.include? "ASC"
        @searchparam[0] = 'ASAMs by Subregion'
        @searchparam[1] = msi_filter_value
        @searchparam[2] = 'None'
        @searchparam[3] = 'Descending ASAM Ref. Number' if msi_sort_value.include? "DESC"
        @searchparam[3] = 'Ascending ASAM Ref. Number' if msi_sort_value.include? "ASC"
        @asams = AsamMaster.where(subregion: msi_filter_value).order(sort_ord)
      end
    end

    #
    # Search for a specific reference number
    #
    if msi_filter_type == 'SpecificNumber'
      @searchparam[0] = 'ASAMs by Subregion'
      @searchparam[1] = msi_filter_value
      @searchparam[2] = 'None'
      @searchparam[3] = 'Descending Date of Occurrence' if msi_sort_value.include? "Date DESC"
      @searchparam[3] = 'Ascending Date of Occurrence' if msi_sort_value.include? "Date ASC"
      @searchparam[3] = 'Descending ASAM Ref. Number' if msi_sort_value.include? "Number DESC"
      @searchparam[3] = 'Ascending ASAM Ref. Number' if msi_sort_value.include? "Number ASC"
      ref = msi_filter_value.split('_')
      @asams = AsamMaster.where(tx_yyyy: ref[0]).where(tx_num: ref[1])
    end

    #
    # Search for a range of reference numbers
    #
    if msi_filter_type == 'NumberRange'
      #
      #Sort by Date
      #
      if msi_sort_value.include? "Date"
        sort_ord = "occur_date DESC" if msi_sort_value.include? "DESC"
        sort_ord = "occur_date ASC" if msi_sort_value.include? "ASC"
        @searchparam[0] = 'ASAMs by Subregion'
        @searchparam[1] = msi_filter_value
        @searchparam[2] = 'None'
        @searchparam[3] = 'Descending Date of Occurrence' if msi_sort_value.include? "DESC"
        @searchparam[3] = 'Ascending Date of Occurrence' if msi_sort_value.include? "ASC"
        #Number range is passed in format yyyy_nn:yyyy_nn, must be parsed
        #ref1 = from, ref2 = to, 0 = yyyy, 1 = nn
        ref = msi_filter_value.split(':')
        ref1 = ref[0].split('_')
        ref2 = ref[1].split('_')
        year1 = ref1[0].to_i
        year2 = ref2[0].to_i
        @asams = Array.new

        #Sort descending
        if msi_sort_value.include? "DESC"
          #retrieve range fo ref. numbers from 'to' year
          @asams = AsamMaster.where("tx_yyyy = #{year2} and tx_num <= #{ref2[1]}").order(sort_ord)
          #determine number of years spanned by query, and retrieve years between first and last years
          #starting from most recent and working backwards
          if year2 - year1 > 1
            range = year2 - year1 - 1
            (range..1).each do |i|
              thisyear = year1 + i
              @asams = @asams + AsamMaster.where("tx_yyyy = #{thisyear}").order(sort_ord)
            end
          end
          #retrieve range of ref numbers from 'from' year
          @asams = @asams + AsamMaster.where("tx_yyyy = #{year1} and tx_num >= #{ref1[1]}")
          #sort concatenated results by date descending
          @asams = @asams.sort {|a,b| b.occur_date <=> a.occur_date}
        end

        # Sort Ascending
        if msi_sort_value.include? "ASC"
          #retrieve range of ref numbers from 'from' year
          @asams = AsamMaster.where("tx_yyyy = #{year1} and tx_num >= #{ref1[1]}").order(sort_ord)
          #determine number of years spanned by query, and retrieve years between first and last years
          #starting from most recent and working forwards
          if year2 - year1 > 1
            range = year2 - year1 - 1
            (1..range).each do |i|
              thisyear = year1 + i
              @asams = @asams + AsamMaster.where("tx_yyyy = #{thisyear}").order(sort_ord)
            end
          end
          #retrieve range fo ref. numbers from 'to' year
          @asams = @asams + AsamMaster.where("tx_yyyy = #{year2} and tx_num >= #{ref2[1]}")
          #sort concatenated results by date ascending
          @asams = @asams.sort {|a,b| a.occur_date <=> b.occur_date}
        end
      #
      # Sort by ref number
      #
      elsif msi_sort_value.include? "Number"
        sort_ord = "tx_yyyy DESC, tx_num DESC" if msi_sort_value.include? "DESC"
        sort_ord = "tx_yyyy ASC, tx_num ASC" if msi_sort_value.include? "ASC"
        @searchparam[0] = 'ASAMs by Subregion'
        @searchparam[1] = msi_filter_value
        @searchparam[2] = 'None'
        @searchparam[3] = 'Descending ASAM Ref. Number' if msi_sort_value.include? "DESC"
        @searchparam[3] = 'Ascending ASAM Ref. Number' if msi_sort_value.include? "ASC"
        ref = msi_filter_value.split(':')
        ref1 = ref[0].split('_')
        ref2 = ref[1].split('_')
        year1 = ref1[0].to_i
        year2 = ref2[0].to_i
        @asams = Array.new
        @asams = AsamMaster.where("tx_yyyy = #{year1} and tx_num >= #{ref1[1]}")
        if year2 - year1 > 1
          range = year2 - year1 - 1
          (1..range).each do |i|
            thisyear = year1 + i
            @asams = @asams + AsamMaster.where("tx_yyyy = #{thisyear}")
          end
        end
        @asams = @asams + AsamMaster.where("tx_yyyy = #{year2} and tx_num <= #{ref2[1]}")

        if msi_sort_value.include? "DESC" #sort descending
          @asams = @asams.sort_by {|a| [a.tx_yyyy, a.tx_num]}.reverse!
        elsif msi_sort_value.include? "ASC" #sort ascending
          @asams = @asams.sort_by {|a| [a.tx_yyyy, a.tx_num]}
        end
      end
    end

    #
    # Search ASAMs for specific victim
    #
    if msi_filter_type == 'VictimName'
      @searchparam[0] = "Victim's Name"
      @searchparam[1] = msi_filter_value
      @searchparam[2] = 'None'
      @searchparam[3] = 'Descending Date of Occurrence' if msi_sort_value.include? "Date DESC"
      @searchparam[3] = 'Ascending Date of Occurrence' if msi_sort_value.include? "Date ASC"
      @searchparam[3] = 'Descending ASAM Ref. Number' if msi_sort_value.include? "Number DESC"
      @searchparam[3] = 'Ascending ASAM Ref. Number' if msi_sort_value.include? "Number ASC"
      sort_ord = "occur_date DESC" if msi_sort_value.include? "Date DESC"
      sort_ord = "occur_date ASC" if msi_sort_value.include? "Date ASC"
      sort_ord = "tx_yyyy DESC, tx_num DESC" if msi_sort_value.include? "Number DESC"
      sort_ord = "tx_yyyy ASC, tx_num ASC" if msi_sort_value.include? "Number ASC"
      name = msi_filter_value.downcase
      if msi_filter_type1 == 'SpecificDate'
        asamdate = DateTime.parse(msi_filter_value1)
        @asams = AsamMaster.where('lower(victim) = ?', name).where(occur_date: asamdate).order(sort_ord)
      else
        @asams = AsamMaster.where('lower(victim) = ?', name).order(sort_ord)
      end


    end
  end

end
