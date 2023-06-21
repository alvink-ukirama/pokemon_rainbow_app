class Skill < ApplicationRecord
    has_many :pokemon_skills
    has_many :pokemons, through: :pokemon_skills
    validates_uniqueness_of :name, on: :create
end