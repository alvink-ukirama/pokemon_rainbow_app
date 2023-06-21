class AddElementTypeInPokemon < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :element_type, :string
  end
end
