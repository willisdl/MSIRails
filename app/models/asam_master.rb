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

end
