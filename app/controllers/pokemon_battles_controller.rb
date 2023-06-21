require 'pokemon_battle_calculator'
class PokemonBattlesController < ApplicationController
    def index
        flash.clear
    end
    
    def new
        @pokemon_battles = PokemonBattle.new
        @pokemon = Pokemon.new
        @pokemons = Pokemon.all.order('id')        
    end

     def create
        @pokemon_battle = PokemonBattle.new(pokemon_battle_params)
        
        if @pokemon_battle.pokemon1.current_health_point == 0 
            flash[:danger] = "Please heal your " + @pokemon_battle.pokemon1.name + ", HP cant be 0"
            return redirect_to new_pokemon_battle_path
        elsif @pokemon_battle.pokemon2.current_health_point == 0 
            flash[:danger] = "Please heal your " + @pokemon_battle.pokemon2.name + ", HP cant be 0"
            return redirect_to new_pokemon_battle_path
        elsif @pokemon_battle.pokemon1.id == @pokemon_battle.pokemon2.id
             flash[:danger] = "Pokemon can't battle their self"
             return redirect_to new_pokemon_battle_path
        end

        # if @pokemon_battles.pokemon1.speed > @pokemon_battles.pokemon2.speed
        #     @pokemon_battles.turn = @pokemon_battles.pokemon1.id
        # elsif @pokemon_battles.pokemon2.speed > @pokemon_battles.pokemon1.speed
        #      @pokemon_battles.turn = @pokemon_battles.pokemon2.id
        # elsif @pokemon_battles.pokemon1.speed == @pokemon_battles.pokemon2.speed
        #     @pokemon_battles.turn = [@pokemon_battles.pokemon1.id, @pokemon_battles.pokemon2.id].sample
        # end

        @pokemon_battle.current_turn = 1
        @pokemon_battle.state = "Ongoing"
        @pokemon_battle.pokemon1_max_health_point = @pokemon_battle.pokemon1.max_health_point
        @pokemon_battle.pokemon2_max_health_point = @pokemon_battle.pokemon2.max_health_point
        
        if @pokemon_battle.save
            redirect_to pokemon_battle_path(@pokemon_battle)
        else
            flash[:danger] = @pokemon_battles.errors.full_message
            redirect_to new_pokemon_battle_path
        end
    end

    def show 
        @pokemon_battle = PokemonBattle.find(params[:id])
        @pokemon1_skills = PokemonSkill.where(["pokemon_id = ?", @pokemon_battle.pokemon1.id]).order('id')
        @pokemon2_skills = PokemonSkill.where(["pokemon_id = ?", @pokemon_battle.pokemon2]).order('id')
        if @pokemon_battle.current_turn.odd?
            @disable_pokemon2_action_if_not_turn = @pokemon_battle.current_turn 
        else 
            @disable_pokemon1_action_if_not_turn = @pokemon_battle.current_turn
        end
        if @pokemon_battle.pokemon_winner.present? 
            @disable_all_action = @pokemon_battle.pokemon_winner
            flash[:success] =  @pokemon_battle.pokemon_winner.name.capitalize + " wins!"
        end
    end

    def attack 
        @pokemon_battle = PokemonBattle.find(params[:id])
        if @pokemon_battle.current_turn.odd?
            @attacker = @pokemon_battle.pokemon1
            @defender = @pokemon_battle.pokemon2
            @skill = Skill.find(params[:pokemon1_skill])
            @pokemon_skill = @attacker.pokemon_skills.find_by(skill_id: params[:pokemon1_skill])
            
        else
            @attacker = @pokemon_battle.pokemon2
            @defender = @pokemon_battle.pokemon1
            @skill = Skill.find(params[:pokemon2_skill])
            @pokemon_skill = @attacker.pokemon_skills.find_by(skill_id: params[:pokemon2_skill])
        end
        
        damage = PokemonBattleCalculator.calculate_damage(@attacker.id, @defender.id, @skill.id) 
        @defender.current_health_point = @defender.current_health_point - damage
        @pokemon_skill..current_pp = @pokemon_skill.current_pp - 1
        @pokemon_battle.current_turn += 1
        
        if @defender.current_health_point == 0
            @pokemon_battle.pokemon_winner = @attacker
            @pokemon_battle.pokemon_loser = @defender
            gained_exp = PokemonBattleCalculator.calculate_experience( @pokemon_battle.pokemon_loser.level)
            @pokemon_battle.pokemon_winner.current_experience += gained_exp
            while PokemonBattleCalculator.level_up?(@pokemon_battle.pokemon_winner.level, @pokemon_battle.pokemon_winner.current_experience)
                stat_increase = PokemonBattleCalculator.calculate_level_up_extra_stats 
                @pokemon_battle.pokemon_winner.max_health_point
                @pokemon_battle.pokemon_winner.attack = stat_increase.attack_point
                @pokemon_battle.pokemon_winner.defense = stat_increase.defense_point
                @pokemon_battle.pokemon_winner.speed = stat_increase.speed_point
                @pokemon_battle.pokemon_winner.level += 1
            end
        end
        save!
        redirect_to pokemon_battle_path(@pokemon_battle)
    end

    private

    def save!
        @pokemon_battle.pokemon1.save
        @pokemon_battle.pokemon2.save
        @pokemon_battle.save
        @pokemon_skill.save
    end

    def pokemon_battle_params 
        params.require(:pokemon_battle).permit(:pokemon1_id, :pokemon2_id, :current_turn)
    end
end
