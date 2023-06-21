class PokemonsController < ApplicationController
    def index
        @pokemons = Pokemon.paginate(page: params[:page]).order('id')
    end

    def show 
        @pokemon = Pokemon.find(params[:id])
        @skill = Skill.where(["element_type = ?", @pokemon.element_type]).order('id')
        
        respond_to do |format| 
            # for default show page in html format
            format.html 
            # to render the dog object in JSON format
            format.json { render json: @pokemon.to_json(:include => :pokemon_skills) }
        end 
    end

    def new
        @pokedexes = Pokedex.all.order('id')
        @pokemon = Pokemon.new
    end

    def create
        @pokemon = Pokemon.new
        
        @pokedex_data = Pokedex.find(params[:pokemon][:pokemon_id])
        @pokemon.pokedex_id = @pokedex_data.id
        @pokemon.name = @pokedex_data.name
        @pokemon.level = 1
        @pokemon.max_health_point = @pokedex_data.base_health_point
        @pokemon.current_health_point = @pokemon.max_health_point
        @pokemon.attack = @pokedex_data.base_attack
        @pokemon.defense = @pokedex_data.base_defence
        @pokemon.speed = @pokedex_data.base_speed
        @pokemon.current_experience = 0
        @pokemon.image_url = @pokedex_data.image_url
        @pokemon.element_type = @pokedex_data.element_type
        
        if @pokemon.save
            flash[:success] = "Pokemon successfully added to field!"
            redirect_to pokemon_path(@pokemon)
        else
            puts @pokemon.errors.full_messages
        end
    end
    
    
    def heal(id: params[:id], heal_all_flag: false)
        @pokemon = Pokemon.find(id)
        @pokemon.current_health_point = @pokemon.max_health_point
            @pokemon.pokemon_skills.each do |skill|
            skill.current_pp = skill.skill.max_pp
            skill.save
        end
        if @pokemon.save
            if heal_all_flag 
                return 
            else
                flash[:success] = "Your pokemon are fighting fit!"
                redirect_to pokemon_path
            end
        end
    end

    def heal_all 
        @pokemons = Pokemon.all.order('id')
        @pokemons.each do |pokemon|
            heal(id: pokemon.id, heal_all_flag: true)
        end
        if @pokemon.save
            flash[:success] = "All of your pokemon are fighting fit!"
            redirect_to pokemons_path
        end
    end

    def edit 
        @pokemon = Pokemon.find(params[:id])
        # @pokemon.pokemon_skills_attributes = @pokemon.pokemon_skills
        # @skill = Skill.all.order('id')
          respond_to do |format| 
            # for default show page in html format
            format.html 
            # to render the pokemon object in JSON format
            format.json { render json: @pokemon.to_json(pokemon: @pokemon, pokemon_skill: @skill ) }
        end 
    end

    def update
        @pokemon = Pokemon.find(params[:id])
        @pokemon.pokemon_skills.destroy_all

        if @pokemon.update(pokemon_params)
            redirect_to pokemon_path
        end
    end

    def destroy 
        Pokemon.find(params[:id]).destroy
        redirect_to pokemons_path
    end

    private

    def pokemon_params 
        params.require(:pokemon).permit(:name, :element_type, :current_health_point, :attack, :defense, :speed, :image_url, pokemon_skills_attributes:[:pokemon_id, :skill_id])
    end
end