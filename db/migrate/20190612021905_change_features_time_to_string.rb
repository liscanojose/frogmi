class ChangeFeaturesTimeToString < ActiveRecord::Migration[5.2]
  def change
    change_column :features, :time, :string
  end
end
