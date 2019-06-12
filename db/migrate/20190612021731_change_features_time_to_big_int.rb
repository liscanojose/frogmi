class ChangeFeaturesTimeToBigInt < ActiveRecord::Migration[5.2]
  def change
    change_column :features, :time, :bigint
  end
end
