class PokedexesController < ApplicationController
    def index     
        @pokedexes = Pokedex.paginate(page: params[:page]).order('id')  
    end

    def new 
        @pokedex = Pokedex.new
        @element_type = Elements::ELEMENT_TYPE
    end

    def create 
        @pokedex = Pokedex.new(pokedex_params)
        if @pokedex.save 
            redirect_to pokedexes_url
        end
    end

    def show 
        @pokedex = Pokedex.find(params[:id])
    end

    private 
    def pokedex_params 
        params.require(:pokedex).permit(:name, :base_health_point, :base_attack, :base_defence, :element_type, :image_url)
    end
end