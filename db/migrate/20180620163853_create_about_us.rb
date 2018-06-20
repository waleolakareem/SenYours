class CreateAboutUs < ActiveRecord::Migration[5.1]
  def change
    create_table :about_us do |t|

      t.timestamps
    end
  end
end
