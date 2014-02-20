class CreateAsams < ActiveRecord::Migration
  def change
    create_table :asams do |t|

      t.timestamps
    end
  end
end
