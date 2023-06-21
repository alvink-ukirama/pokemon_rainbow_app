Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pokemon_battles#index'
  post 'pokemon/:id', to: 'pokemons#heal', as: 'heal'
  post 'pokemon/', to: 'pokemons#heal_all', as: 'heal_all'
  post 'pokemon_battles/:id', to: 'pokemon_battles#attack', as: 'attack'
  resources :pokemons do 
    resources :pokemon_skills, only: [:create]
  end
  resources :pokedexes
  resources :skills
  resources :pokemon_skills
  resources :pokemon_battles
end
