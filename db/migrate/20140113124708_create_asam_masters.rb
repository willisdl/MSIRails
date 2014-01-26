class CreateAsamMasters < ActiveRecord::Migration
  def change
    create_table :asam_masters do |t|

      t.timestamps
    end
  end
end
