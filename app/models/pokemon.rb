class Pokemon < ApplicationRecord
    belongs_to :pokemon, class_name: "Pokedex", optional: true
    has_many :pokemon_skills, dependent: :destroy
    has_many :skills, through: :pokemon_skills
    has_many :pokemon_battles, dependent: :destroy
    accepts_nested_attributes_for :pokemon_skills
end
