class AddAssessmentToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :assessment, :string, default:"no"
  end
end
