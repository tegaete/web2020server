class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
           t.string :game_desc
      t.timestamps
    end
  end
end
