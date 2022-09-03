class CreateJwDenylists < ActiveRecord::Migration[7.0]
  def change
    create_table :jw_denylists do |t|
      t.string :jti
      t.datetime :exp

      t.timestamps
    end
    add_index :jw_denylists, :jti
  end
end
