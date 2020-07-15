class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.belongs_to :game
      t.string :username
      t.string :password
      t.string :session_cookie
      t.string :language
      t.string :email
      t.timestamps
    end
  end
end
