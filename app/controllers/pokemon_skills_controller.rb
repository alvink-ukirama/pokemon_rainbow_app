class PokemonSkillsController < ApplicationController

  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    if @pokemon.pokemon_skills.length <= 3
        @pokemon_skill = @pokemon.pokemon_skills.build(pokemon_skill_params)
        @pokemon_skill.current_pp = @pokemon_skill.skill.max_pp
        @pokemon_skill.save
        flash[:success] = 'Skill added successfully.'
        redirect_to @pokemon
    else
        flash[:danger] = "Pokemon already has 4 moves, please delete one of them to add!"
        redirect_to @pokemon
    end
  end

def destroy
    @pokemon = PokemonSkill.find(params[:id])
    @pokemon = @pokemon.pokemon_id
    PokemonSkill.find(params[:id]).destroy
    flash[:success] = "Skill sucessfully deleted"
    redirect_to pokemon_path(@pokemon)
end


  private

  def pokemon_skill_params
    params.permit(:pokemon_id, :skill_id)
  end
end