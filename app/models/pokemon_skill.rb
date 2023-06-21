class PokemonSkill < ApplicationRecord
    belongs_to :pokemon, class_name: "Pokemon"
    belongs_to :skill, class_name: "Skill"
end