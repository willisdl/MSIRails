# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140113124708) do

  create_table "asam_masters", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "db_conn_test", id: false, force: true do |t|
    t.integer "test_id",   limit: 2,   precision: 2, scale: 0, null: false
    t.string  "test_name", limit: 100,                         null: false
  end

# Could not dump table "exceptions" because of following StandardError
#   Unknown type 'ROWID' for column 'row_id'

  create_table "msi_cache_properties", primary_key: "id_element", force: true do |t|
    t.decimal "id_order"
    t.string  "title_element"
    t.string  "value_element"
    t.string  "type_element"
  end

  create_table "msi_query_properties", primary_key: "id_query", force: true do |t|
    t.string  "msi_querytype"
    t.string  "msi_generalfiltertype"
    t.string  "msi_generalfiltername"
    t.string  "msi_generalfilterdatatype"
    t.string  "msi_additionalfiltertype1"
    t.string  "msi_additionalfiltername1"
    t.string  "msi_additionalfilterdatatype1"
    t.string  "msi_additionalfiltertype2"
    t.string  "msi_additionalfiltername2"
    t.string  "msi_additionalfilterdatatype2"
    t.string  "msi_outputoptiontype1"
    t.string  "msi_outputoptionname1"
    t.string  "msi_outputoptiondatatype1"
    t.string  "msi_outputoptiontype2"
    t.string  "msi_outputoptionname2"
    t.string  "msi_outputoptiondatatype2"
    t.string  "msi_procname"
    t.decimal "msi_numcols"
  end

  create_table "pub_persist", id: false, force: true do |t|
    t.string   "pub_type",    limit: 20, null: false
    t.string   "pub_num",     limit: 20, null: false
    t.datetime "create_date"
  end

  create_table "sde_logfile_data", id: false, force: true do |t|
    t.integer "logfile_data_id", precision: 38, scale: 0, null: false
    t.integer "sde_row_id",      precision: 38, scale: 0, null: false
  end

  add_index "sde_logfile_data", ["logfile_data_id", "sde_row_id"], name: "sde_logfile_data_idx1", tablespace: "allnss"
  add_index "sde_logfile_data", ["sde_row_id"], name: "sde_logfile_data_idx2", tablespace: "allnss"

  create_table "sde_logfiles", primary_key: "logfile_id", force: true do |t|
    t.string  "logfile_name",       limit: nil,                          null: false
    t.integer "logfile_data_id",                precision: 38, scale: 0, null: false
    t.integer "registration_id",                precision: 38, scale: 0, null: false
    t.integer "flags",                          precision: 38, scale: 0, null: false
    t.integer "session_tag",                    precision: 38, scale: 0, null: false
    t.string  "logfile_data_db",    limit: nil
    t.string  "logfile_data_owner", limit: nil
    t.string  "logfile_data_table", limit: nil
    t.string  "column_name",        limit: nil
  end

  add_index "sde_logfiles", ["logfile_data_id"], name: "sde_logfiles_uk2", unique: true, tablespace: "allnss"
  add_index "sde_logfiles", ["logfile_name"], name: "sde_logfiles_uk", unique: true, tablespace: "allnss"

  create_table "txt_files", primary_key: "txt_file_id", force: true do |t|
    t.text     "txt_file"
    t.string   "txt_file_name"
    t.datetime "date_create"
    t.string   "site_create",   limit: 3
  end

  add_synonym "jautmp_feature_literal_pub", "jautmp.feature_literal_pub", force: true
  add_synonym "jautmp_geo_uhdr", "jautmp.geo_uhdr", force: true
  add_synonym "jautmp_geo_shdr", "jautmp.geo_shdr", force: true
  add_synonym "jautmp_geo_bhdr", "jautmp.geo_bhdr", force: true
  add_synonym "dissemination_control_lut", "wk1nss.dissemination_control_lut", force: true
  add_synonym "f5", "wk1nss.f5", force: true
  add_synonym "f51", "wk1nss.f51", force: true
  add_synonym "f6", "wk1nss.f6", force: true
  add_synonym "f7", "wk1nss.f7", force: true
  add_synonym "f8", "wk1nss.f8", force: true
  add_synonym "f9", "wk1nss.f9", force: true
  add_synonym "f93", "wk1nss.f93", force: true
  add_synonym "non_intel_markings_lut", "wk1nss.non_intel_markings_lut", force: true
  add_synonym "s5", "wk1nss.s5", force: true
  add_synonym "s51", "wk1nss.s51", force: true
  add_synonym "s6", "wk1nss.s6", force: true
  add_synonym "s7", "wk1nss.s7", force: true
  add_synonym "s8", "wk1nss.s8", force: true
  add_synonym "s9", "wk1nss.s9", force: true
  add_synonym "s93", "wk1nss.s93", force: true
  add_synonym "sci_control_systems_lut", "wk1nss.sci_control_systems_lut", force: true
  add_synonym "sde_exceptions", "wk1nss.sde_exceptions", force: true
  add_synonym "rig_master", "wk1nss.rig_master", force: true
  add_synonym "chart_correction", "wk1nss.chart_correction", force: true
  add_synonym "graticule_units_lut", "wk1nss.graticule_units_lut", force: true
  add_synonym "f68", "wk1nss.f68", force: true
  add_synonym "f119", "wk1nss.f119", force: true
  add_synonym "projection_lut", "wk1nss.projection_lut", force: true
  add_synonym "chart_notes", "wk1nss.chart_notes", force: true
  add_synonym "tide_station_temp", "wk1nss.tide_station_temp", force: true
  add_synonym "radio_na_dfrs_frequency", "wk1nss.radio_na_dfrs_frequency", force: true
  add_synonym "f66", "wk1nss.f66", force: true
  add_synonym "tod_lvl_lut", "wk1nss.tod_lvl_lut", force: true
  add_synonym "foul_ground_points", "wk1nss.foul_ground_points", force: true
  add_synonym "valid_4_pos_corr_status_lut", "wk1nss.valid_4_pos_corr_status_lut", force: true
  add_synonym "s183", "wk1nss.s183", force: true
  add_synonym "chart_inset", "wk1nss.chart_inset", force: true
  add_synonym "port", "wk1nss.port", force: true
  add_synonym "range_units_lut", "wk1nss.range_units_lut", force: true
  add_synonym "chart_non_feature_correction", "wk1nss.chart_non_feature_correction", force: true
  add_synonym "geopolitical_entity_lut", "wk1nss.geopolitical_entity_lut", force: true
  add_synonym "shelter_afforded_code_key", "wk1nss.shelter_afforded_code_key", force: true
  add_synonym "nfl_3_pos_corr_status_lut", "wk1nss.nfl_3_pos_corr_status_lut", force: true
  add_synonym "tod_catalog_region", "wk1nss.tod_catalog_region", force: true
  add_synonym "radio_na_warn_broadcast", "wk1nss.radio_na_warn_broadcast", force: true
  add_synonym "publication_type_lut", "wk1nss.publication_type_lut", force: true
  add_synonym "f59", "wk1nss.f59", force: true
  add_synonym "radio_na_ts_transmission", "wk1nss.radio_na_ts_transmission", force: true
  add_synonym "radio_na_warn_station", "wk1nss.radio_na_warn_station", force: true
  add_synonym "on_sequence", "wk1nss.on_sequence", force: true
  add_synonym "radio_na_ts_station", "wk1nss.radio_na_ts_station", force: true
  add_synonym "radio_na_lng_rng_chain", "wk1nss.radio_na_lng_rng_chain", force: true
  add_synonym "depth_units_lut", "wk1nss.depth_units_lut", force: true
  add_synonym "beacon_points", "wk1nss.beacon_points", force: true
  add_synonym "archive_device_lut", "wk1nss.archive_device_lut", force: true
  add_synonym "caveat_lut", "wk1nss.caveat_lut", force: true
  add_synonym "sound_signal_type_lut", "wk1nss.sound_signal_type_lut", force: true
  add_synonym "s119", "wk1nss.s119", force: true
  add_synonym "dgps_pub_feat_attr", "wk1nss.dgps_pub_feat_attr", force: true
  add_synonym "dnc_edition", "wk1nss.dnc_edition", force: true
  add_synonym "f183", "wk1nss.f183", force: true
  add_synonym "distribution_statement_lut", "wk1nss.distribution_statement_lut", force: true
  add_synonym "sounding_height_datum_lut", "wk1nss.sounding_height_datum_lut", force: true
  add_synonym "f206", "wk1nss.f206", force: true
  add_synonym "rock_points", "wk1nss.rock_points", force: true
  add_synonym "country_releasability_lut", "wk1nss.country_releasability_lut", force: true
  add_synonym "light_vessel_lightship_points", "wk1nss.light_vessel_lightship_points", force: true
  add_synonym "world_port_index", "wk1nss.world_port_index", force: true
  add_synonym "sde_layer", "wk1nss.sde_layer", force: true
  add_synonym "platform_points", "wk1nss.platform_points", force: true
  add_synonym "length_code_key", "wk1nss.length_code_key", force: true
  add_synonym "geo_shdr", "wk1nss.geo_shdr", force: true
  add_synonym "f250", "wk1nss.f250", force: true
  add_synonym "height_units_lut", "wk1nss.height_units_lut", force: true
  add_synonym "price_category_lut", "wk1nss.price_category_lut", force: true
  add_synonym "bw_master", "wk1nss.bw_master", force: true
  add_synonym "eol", "wk1nss.eol", force: true
  add_synonym "reason_lut", "wk1nss.reason_lut", force: true
  add_synonym "radio_na_dfrs_geo_area", "wk1nss.radio_na_dfrs_geo_area", force: true
  add_synonym "radiobeacon_type_lut", "wk1nss.radiobeacon_type_lut", force: true
  add_synonym "bw_subregion_lut", "wk1nss.bw_subregion_lut", force: true
  add_synonym "chart_depth_tab_correction", "wk1nss.chart_depth_tab_correction", force: true
  add_synonym "s69", "wk1nss.s69", force: true
  add_synonym "chart_catalog_region", "wk1nss.chart_catalog_region", force: true
  add_synonym "radio_na_dfrs_station", "wk1nss.radio_na_dfrs_station", force: true
  add_synonym "s206", "wk1nss.s206", force: true
  add_synonym "audio_timing", "wk1nss.audio_timing", force: true
  add_synonym "chart_note_correction", "wk1nss.chart_note_correction", force: true
  add_synonym "publication_version", "wk1nss.publication_version", force: true
  add_synonym "wreck_points", "wk1nss.wreck_points", force: true
  add_synonym "atg_note_text", "wk1nss.atg_note_text", force: true
  add_synonym "depth_tab_attributes", "wk1nss.depth_tab_attributes", force: true
  add_synonym "catalog_lut", "wk1nss.catalog_lut", force: true
  add_synonym "f260", "wk1nss.f260", force: true
  add_synonym "f146", "wk1nss.f146", force: true
  add_synonym "feature_correction", "wk1nss.feature_correction", force: true
  add_synonym "radio_na_med_advice", "wk1nss.radio_na_med_advice", force: true
  add_synonym "geo_hdr", "wk1nss.geo_hdr", force: true
  add_synonym "publication_version_lut", "wk1nss.publication_version_lut", force: true
  add_synonym "classification_lut", "wk1nss.classification_lut", force: true
  add_synonym "dnc_max_feat", "wk1nss.dnc_max_feat", force: true
  add_synonym "s59", "wk1nss.s59", force: true
  add_synonym "nih_sounding_datum_lut", "wk1nss.nih_sounding_datum_lut", force: true
  add_synonym "iala_color_lut", "wk1nss.iala_color_lut", force: true
  add_synonym "chartlet_attributes", "wk1nss.chartlet_attributes", force: true
  add_synonym "chart_chartlet_correction", "wk1nss.chart_chartlet_correction", force: true
  add_synonym "s146", "wk1nss.s146", force: true
  add_synonym "s144", "wk1nss.s144", force: true
  add_synonym "light_elevation_units_lut", "wk1nss.light_elevation_units_lut", force: true
  add_synonym "temp_feature_source", "wk1nss.temp_feature_source", force: true
  add_synonym "bridge_overpass_viaduct_lines", "wk1nss.bridge_overpass_viaduct_lines", force: true
  add_synonym "compartment_lut", "wk1nss.compartment_lut", force: true
  add_synonym "tod_lut", "wk1nss.tod_lut", force: true
  add_synonym "geo_uhdr", "wk1nss.geo_uhdr", force: true
  add_synonym "radio_na_dfrs_geo_area_freq", "wk1nss.radio_na_dfrs_geo_area_freq", force: true
  add_synonym "world_port_region", "wk1nss.world_port_region", force: true
  add_synonym "radio_na_lng_rng_station", "wk1nss.radio_na_lng_rng_station", force: true
  add_synonym "marad_master", "wk1nss.marad_master", force: true
  add_synonym "rbn_pub_feat_attr", "wk1nss.rbn_pub_feat_attr", force: true
  add_synonym "feature_notes", "wk1nss.feature_notes", force: true
  add_synonym "dnc_lut", "wk1nss.dnc_lut", force: true
  add_synonym "f69", "wk1nss.f69", force: true
  add_synonym "notice", "wk1nss.notice", force: true
  add_synonym "chart_notice", "wk1nss.chart_notice", force: true
  add_synonym "nss_user", "wk1nss.nss_user", force: true
  add_synonym "sensitivity", "wk1nss.sensitivity", force: true
  add_synonym "f188", "wk1nss.f188", force: true
  add_synonym "radiobeacon", "wk1nss.radiobeacon", force: true
  add_synonym "light_points", "wk1nss.light_points", force: true
  add_synonym "port_name", "wk1nss.port_name", force: true
  add_synonym "horizontal_datum_lut", "wk1nss.horizontal_datum_lut", force: true
  add_synonym "s188", "wk1nss.s188", force: true
  add_synonym "wpi_country", "wk1nss.wpi_country", force: true
  add_synonym "s68", "wk1nss.s68", force: true
  add_synonym "color", "wk1nss.color", force: true
  add_synonym "repairs_code_key", "wk1nss.repairs_code_key", force: true
  add_synonym "harbor_size_code_key", "wk1nss.harbor_size_code_key", force: true
  add_synonym "radio_na_warn_geo_area", "wk1nss.radio_na_warn_geo_area", force: true
  add_synonym "publication_catalog_region", "wk1nss.publication_catalog_region", force: true
  add_synonym "f41", "wk1nss.f41", force: true
  add_synonym "port_list_for_charts", "wk1nss.port_list_for_charts", force: true
  add_synonym "dnc_catalog_region", "wk1nss.dnc_catalog_region", force: true
  add_synonym "harbor_type_code_key", "wk1nss.harbor_type_code_key", force: true
  add_synonym "geo_bhdr", "wk1nss.geo_bhdr", force: true
  add_synonym "asam_master", "wk1nss.asam_master", force: true
  add_synonym "vertical_datum_lut", "wk1nss.vertical_datum_lut", force: true
  add_synonym "underwater_danger_points", "wk1nss.underwater_danger_points", force: true
  add_synonym "catalog_correction", "wk1nss.catalog_correction", force: true
  add_synonym "f144", "wk1nss.f144", force: true
  add_synonym "radio_na_ts_geo_area", "wk1nss.radio_na_ts_geo_area", force: true
  add_synonym "tod_edition", "wk1nss.tod_edition", force: true
  add_synonym "chart_overlay_type_lut", "wk1nss.chart_overlay_type_lut", force: true
  add_synonym "test", "wk1nss.test", force: true
  add_synonym "pub_section_status", "wk1nss.pub_section_status", force: true
  add_synonym "electronics_lut", "wk1nss.electronics_lut", force: true
  add_synonym "point_of_contact", "wk1nss.point_of_contact", force: true
  add_synonym "dnc_library", "wk1nss.dnc_library", force: true
  add_synonym "publication", "wk1nss.publication", force: true
  add_synonym "s260", "wk1nss.s260", force: true
  add_synonym "drydock_and_marine_railway_cod", "wk1nss.drydock_and_marine_railway_cod", force: true
  add_synonym "feature_literal_pub", "wk1nss.feature_literal_pub", force: true
  add_synonym "chart_type", "wk1nss.chart_type", force: true
  add_synonym "maxsize_vessel_code_key", "wk1nss.maxsize_vessel_code_key", force: true
  add_synonym "chart_note_caution", "wk1nss.chart_note_caution", force: true
  add_synonym "section", "wk1nss.section", force: true
  add_synonym "s41", "wk1nss.s41", force: true
  add_synonym "s250", "wk1nss.s250", force: true
  add_synonym "audio", "wk1nss.audio", force: true
  add_synonym "chart_ports", "wk1nss.chart_ports", force: true
  add_synonym "chart", "wk1nss.chart", force: true
  add_synonym "buoy_points", "wk1nss.buoy_points", force: true
  add_synonym "characteristic", "wk1nss.characteristic", force: true
  add_synonym "feature", "wk1nss.feature", force: true
  add_synonym "publication_notice", "wk1nss.publication_notice", force: true
  add_synonym "pub_feat_attr", "wk1nss.pub_feat_attr", force: true
  add_synonym "facc_table", "wk1nss.facc_table", force: true
  add_synonym "s66", "wk1nss.s66", force: true

end
