class PokemonBattle < ApplicationRecord
  belongs_to :pokemon1, class_name: "Pokemon"
  belongs_to :pokemon2, class_name: "Pokemon"
  belongs_to :pokemon_winner, class_name: "Pokemon", optional: true
  belongs_to :pokemon_loser, class_name: "Pokemon", optional: true
  # validate :check_pokemon1_ongoing_battle, on: :create
  # validate :check_pokemon2_ongoing_battle, on: :create

  # private

  # def check_pokemon1_ongoing_battle
  #   if pokemon1.nil? || pokemon1.pokemon_battles.exists?(state: 'ongoing') 
  #     errors.add(:pokemon1, "still have an ongoing battle")
  #   end
  # end

  # def check_pokemon2_ongoing_battle
  #   if pokemon2.nil? || pokemon2.pokemon_battles.exists?(state: 'ongoing') 
  #     errors.add(:pokemon2, "still have an ongoing battle")
  #   end
  # end
end
