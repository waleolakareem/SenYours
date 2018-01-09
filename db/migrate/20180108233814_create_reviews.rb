class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :reviewer_id
      t.integer :user_id
      t.integer :wyr_rating
      t.integer :comm_rating
      t.integer :comp_rating

      t.timestamps
    end
  end
end
