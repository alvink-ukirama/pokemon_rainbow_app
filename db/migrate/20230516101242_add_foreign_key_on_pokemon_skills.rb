class AddForeignKeyOnPokemonSkills < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :pokemon_skills, :skills, column: "skill_id"
    add_foreign_key :pokemon_skills, :pokemons, column: "pokemon_id"
  end
end
