class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.integer :hi
      t.string :bye

      t.timestamps
    end
  end
end
