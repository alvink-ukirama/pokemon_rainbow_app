class AddForeignKeyOnPokedexes < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :pokemons, :pokedexes, column: "pokedex_id"
  end
end
