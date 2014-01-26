class AsamMaster < ActiveRecord::Base
  #self.abstract_class = true
  self.table_name = 'ASAM_MASTER'

  #attr_accessor :victim, :subregion, :tx_num, :tx_yyyy, :latitude, :longitude, :src_log_id, :status, :occur_date,
  #             :originator, :e_mail_address, :commercial_telephone_number, :aggressor, :entry_date, :cmmnts, :text

  def str_lat
    if self.latitude < 1
      posval = self.latitude * (-1)
      direct = 'S'
    else
      posval = self.latitude
      direct = 'N'
    end
    degint = posval.to_i
    remain = posval % 1
    minint = (remain * 60).to_i
    lastremain = (remain * 60) % 1
    secint = (lastremain * 60).to_i
    secremain = (lastremain * 60) % 1
    if secremain >= 0.5
      secint += 1
    end
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
    #sec = '00' if sec == '0'
    @lat = [deg, min, sec, direct]
  end

  def str_lon
    if self.longitude < 1
      posval = self.longitude * (-1)
      direct = 'W'
    else
      posval = self.longitude
      direct = 'E'
    end
    degint = posval.to_i
    remain = posval % 1
    minint = (remain * 60).to_i
    lastremain = (remain * 60) % 1
    secint = (lastremain * 60).to_i
    secremain = (lastremain * 60) % 1
    if secremain >= 0.5
      secint += 1
    end
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
    @lon = [deg, min, sec, direct]
  end

end
