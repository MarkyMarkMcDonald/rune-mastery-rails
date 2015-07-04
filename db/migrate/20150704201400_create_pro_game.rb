class CreateProGame < ActiveRecord::Migration
  def change
    create_table :pro_games do |t|
      t.string 'champion_name'
      t.string 'player_name'
      t.json 'runes'

      t.timestamps
    end
  end
end
