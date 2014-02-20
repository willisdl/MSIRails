class AsamMaster < ActiveRecord::Base
  #self.abstract_class = true
  self.table_name = 'ASAM_MASTER'

  #attr_accessor :victim, :subregion, :tx_num, :tx_yyyy, :latitude, :longitude, :src_log_id, :status, :occur_date,
  #             :originator, :e_mail_address, :commercial_telephone_number, :aggressor, :entry_date, :cmmnts, :text

  def str_lat
    if self.latitude < 0
      direct = 'S'
    else
      direct = 'N'
    end
    @lat = coord_transform(self.latitude, direct)
  end

  def str_lon
    if self.longitude < 0
      direct = 'W'
    else
      direct = 'E'
    end
    @lon = coord_transform(self.longitude, direct)
  end

  def coord_transform(coord, direction)
    degint = coord.abs.to_i
    minint = ((coord.abs - degint) * 60).to_i
    secint = ((((coord.abs - degint) * 60) - minint) * 60).round
    if secint == 60
      minint += 1
      secint = 0
    end
    if minint == 60
      degint += 1
      minint == 0
    end
    deg = degint.to_s
    deg = '0' + deg if deg.length == 1
    min = minint.to_s
    min = '0' + min if min.length == 1
    sec = secint.to_s
    sec = '0' + sec if sec.length == 1
    [deg, min, sec, direction]
  end

  def get_asam(filter_type, filter_value, filter_type1, filter_value1, sort_value)
    @msi_filter_type = filter_type
    @msi_filter_value = filter_value
    @msi_filter_type1 = filter_type1
    @msi_filter_value1 = filter_value1
    @msi_sort_value = sort_value
    sort_ord = 'occur_date DESC, tx_yyyy DESC, tx_num DESC' if @msi_sort_value.include? 'Date_DESC'
    sort_ord = 'occur_date asc, tx_yyyy asc, tx_num asc' if @msi_sort_value.include? 'Date_ASC'
    sort_ord = 'tx_yyyy DESC, tx_num DESC' if @msi_sort_value.include? 'Number_DESC'
    sort_ord = 'tx_yyyy ASC, tx_num ASC' if @msi_sort_value.include? 'Number_ASC'
    @searchparam = Array.new
    @searchparam[0] = 'All Anti-Shipping Activity Messages' if @msi_filter_type == 'All'
    @searchparam[0] = 'ASAMs by Subregion' if @msi_filter_type == 'Subregion'
    @searchparam[0] = "Victim's Name" if @msi_filter_type == 'VictimName'
    @searchparam[1] = @msi_filter_value
    @searchparam[2] = 'None'
    @searchparam[3] = 'Descending Date of Occurrence' if @msi_sort_value.include? 'Date_DESC'
    @searchparam[3] = 'Ascending Date of Occurrence' if @msi_sort_value.include? 'Date_ASC'
    @searchparam[3] = 'Descending ASAM Ref. Number' if @msi_sort_value.include? 'Number_DESC'
    @searchparam[3] = 'Ascending ASAM Ref. Number' if @msi_sort_value.include? 'Number_ASC'

    @asam = Array.new
    #Search ASAMs with no criteria selected - return ALL ASAM messages
    if @msi_filter_type == 'All'
      if @msi_filter_type1 == 'SpecificDate'
        asamdate = DateTime.parse(@msi_filter_value1)
        @asam = AsamMaster.where(occur_date: asamdate).order(sort_ord)
      elsif @msi_filter_type1 == 'DateRange'
        asamdate = @msi_filter_value1.split(':')
        date1 = DateTime.parse(asamdate[0])
        date2 = DateTime.parse(asamdate[1])
        @asam = AsamMaster.where(occur_date: date1..date2).order(sort_ord)
      else
        @asam = AsamMaster.order(sort_ord)
      end
    end

    #
    #Search ASAMs by specific Subregion
    #
    if @msi_filter_type == 'Subregion'
      if @msi_filter_type1 == 'SpecificDate'
        asamdate = DateTime.parse(@msi_filter_value1)
        @asam = AsamMaster.where(subregion: @msi_filter_value).where(occur_date: asamdate).order(sort_ord)
      elsif @msi_filter_type1 == 'DateRange'
        asamdate = @msi_filter_value1.split(':')
        date1 = DateTime.parse(asamdate[0])
        date2 = DateTime.parse(asamdate[1])
        @asam = AsamMaster.where(subregion: @msi_filter_value).where(occur_date: date1..date2).order(sort_ord)
      else
        @asam = AsamMaster.where(subregion: @msi_filter_value).order(sort_ord)
      end
    end

    #
    # Search for a specific reference number
    #
    if @msi_filter_type == 'SpecificNumber'
      @searchparam[0] = "Single ASAM Ref. Number: #{@msi_filter_value}"
      ref = @msi_filter_value.split('_')
      @asam = AsamMaster.where(tx_yyyy: ref[0]).where(tx_num: ref[1])
    end

    #
    # Search for a range of reference numbers
    #
    if @msi_filter_type == 'NumberRange'

      ref = @msi_filter_value.split(':')
      ref1 = ref[0].split('_')
      ref2 = ref[1].split('_')
      year1 = ref1[0].to_i
      year2 = ref2[0].to_i
      @searchparam[0] = "ASAM Ref. Number Range: from #{year1}_#{ref1[1]} to #{year2}_#{ref2[1]}"
      @asam = Array.new


      midyears = year2 - year1
      clause = "(tx_yyyy = #{year1} and tx_num >= #{ref1[1]})"
      if midyears > 0
        (1..(midyears - 1)).each do |i|
          clause += " or (tx_yyyy = #{year1 + i})"
        end
      end
      clause += " or (tx_yyyy = #{year2} and tx_num <= #{ref2[1]})"

      if @msi_filter_type1 == 'SpecificDate'
        asamdate = DateTime.parse(@msi_filter_value1)
        @asam = AsamMaster.where(clause).where(occur_date: asamdate).order(sort_ord)
      elsif @msi_filter_type1 == 'DateRange'
        asamdate = @msi_filter_value1.split(':')
        date1 = DateTime.parse(asamdate[0])
        date2 = DateTime.parse(asamdate[1])
        @asam = AsamMaster.where(clause).where(occur_date: date1..date2).order(sort_ord)
      else
        @asam = AsamMaster.where(clause).order(sort_ord)
      end
    end

    #
    # Search ASAMs for specific victim
    #
    if @msi_filter_type == 'VictimName'
      name = @msi_filter_value.downcase
      if @msi_filter_type1 == 'SpecificDate'
        asamdate = DateTime.parse(@msi_filter_value1)
        @asam = AsamMaster.where('lower(victim) = ?', name).where(occur_date: asamdate).order(sort_ord)
      elsif @msi_filter_type1 == 'DateRange'
        asamdate = @msi_filter_value1.split(':')
        date1 = DateTime.parse(asamdate[0])
        date2 = DateTime.parse(asamdate[1])
        @asam = AsamMaster.where('lower(victim) = ?', name).where(occur_date: date1..date2).order(sort_ord)
      else
        @asam = AsamMaster.where('lower(victim) = ?', name).order(sort_ord)
      end
    end
    #$stdout.puts(@asam.length)
    @asam
  end

  def get_searchparam
    @searchparam
  end

  def get_subs
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

end
