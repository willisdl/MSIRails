class AsamMasterController < ApplicationController

  def initialize
    @asam_sub = AsamMaster.new
  end

  def asam
    @subregions = Array.new
    @subregions = @asam_sub.get_subs
  end

  def asam_query
    #msi_query_type = params[:MSI_queryType]
    msi_filter_type = params[:MSI_generalFilterType]
    msi_filter_value = params[:MSI_generalFilterValue]
    msi_filter_type1 = params[:MSI_additionalFilterType1]
    #msi_filter_type2 = params[:MSI_additionalFilterType2]
    msi_filter_value1 = params[:MSI_additionalFilterValue1]
    #msi_filter_value2 = params[:MSI_additionalFilterValue2]
    #msi_sort_type = params[:MSI_outputOptionType1]
    #msi_output_option_type2 = params[:MSI_outputOptionType2]
    msi_sort_value = params[:MSI_outputOptionValue1]
    #msi_output_option_value2 = params[:MSI_outputOptionValue2]
    msi_map = params[:MSI_MAP]
    @asams = Array.new
    @asams = @asam_sub.get_asam(msi_filter_type, msi_filter_value, msi_filter_type1, msi_filter_value1, msi_sort_value)
    @searchparam = @asam_sub.get_searchparam
  end

end
