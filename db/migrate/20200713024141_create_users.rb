class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.belongs_to :game
      t.string :cookie
      t.timestamps
    end
  end
end
