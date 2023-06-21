class AddAllRequiredForeignKeyOnPokemonBattles < ActiveRecord::Migration[6.1]
  def change
   add_foreign_key :pokemon_battles, :pokemons, column: "pokemon1_id"
   add_foreign_key :pokemon_battles, :pokemons, column: "pokemon2_id"
   add_foreign_key :pokemon_battles, :pokemons, column: "pokemon_winner_id"
   add_foreign_key :pokemon_battles, :pokemons, column: "pokemon_loser_id"
  end
end
