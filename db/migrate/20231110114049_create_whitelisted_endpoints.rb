class CreateWhitelistedEndpoints < ActiveRecord::Migration[7.0]
  def change
    create_table :whitelisted_endpoints do |t|
      t.string :role
      t.string :endpoint

      t.timestamps
    end
  end
end
