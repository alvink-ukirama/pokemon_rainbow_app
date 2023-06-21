class PokemonBattleCalculator 

    ELEMENT_CHART = {
        normal:   { normal: 1.0, fire: 1.0, water: 1.0, electric: 1.0, grass: 1.0, ice: 1.0, fighting: 1.0, poison: 1.0, ground: 1.0, flying: 1.0, psychic: 1.0, bug: 1.0, rock: 0.5, ghost: 0.0, dragon: 1.0, dark: 1.0, steel: 0.5, fairy: 1.0 },
        fire:     { normal: 1.0, fire: 0.5, water: 0.5, electric: 1.0, grass: 2.0, ice: 2.0, fighting: 1.0, poison: 1.0, ground: 1.0, flying: 1.0, psychic: 1.0, bug: 2.0, rock: 0.5, ghost: 1.0, dragon: 0.5, dark: 1.0, steel: 2.0, fairy: 1.0 },
        water:    { normal: 1.0, fire: 2.0, water: 0.5, electric: 1.0, grass: 0.5, ice: 1.0, fighting: 1.0, poison: 1.0, ground: 2.0, flying: 1.0, psychic: 1.0, bug: 1.0, rock: 2.0, ghost: 1.0, dragon: 0.5, dark: 1.0, steel: 1.0, fairy: 1.0 },
        electric: { normal: 1.0, fire: 1.0, water: 2.0, electric: 0.5, grass: 0.5, ice: 1.0, fighting: 1.0, poison: 1.0, ground: 0.0, flying: 2.0, psychic: 1.0, bug: 1.0, rock: 1.0, ghost: 1.0, dragon: 0.5, dark: 1.0, steel: 1.0, fairy: 1.0 },
        grass:    { normal: 1.0, fire: 0.5, water: 2.0, electric: 1.0, grass: 0.5, ice: 1.0, fighting: 1.0, poison: 0.5, ground: 2.0, flying: 0.5, psychic: 1.0, bug: 0.5, rock: 2.0, ghost: 1.0, dragon: 0.5, dark: 1.0, steel: 0.5, fairy: 1.0 },
        ice:      { normal: 1.0, fire: 0.5, water: 0.5, electric: 1.0, grass: 2.0, ice: 0.5, fighting: 1.0, poison: 1.0, ground: 2.0, flying: 2.0, psychic: 1.0, bug: 1.0, rock: 1.0, ghost: 1.0, dragon: 2.0, dark: 1.0, steel: 0.5, fairy: 1.0 },
        fighting: { normal: 2.0, fire: 1.0, water: 1.0, electric: 1.0, grass: 1.0, ice: 2.0, fighting: 1.0, poison: 0.5, ground: 1.0, flying: 0.5, psychic: 0.5, bug: 0.5, rock: 2.0, ghost: 0.0, dragon: 1.0, dark: 2.0, steel: 2.0, fairy: 0.5 },
        poison:   { normal: 1.0, fire: 1.0, water: 1.0, electric: 1.0, grass: 2.0, ice: 1.0, fighting: 1.0, poison: 0.5, ground: 0.5, flying: 1.0, psychic: 1.0, bug: 1.0, rock: 0.5, ghost: 0.5, dragon: 1.0, dark: 1.0, steel: 0.0, fairy: 2.0 },
        ground:   { normal: 1.0, fire: 2.0, water: 1.0, electric: 2.0, grass: 0.5, ice: 1.0, fighting: 1.0, poison: 2.0, ground: 1.0, flying: 0.0, psychic: 1.0, bug: 0.5, rock: 2.0, ghost: 1.0, dragon: 1.0, dark: 1.0, steel: 2.0, fairy: 1.0 },
        flying:   { normal: 1.0, fire: 1.0, water: 1.0, electric: 0.5, grass: 2.0, ice: 1.0, fighting: 2.0, poison: 1.0, ground: 1.0, flying: 1.0, psychic: 1.0, bug: 2.0, rock: 0.5, ghost: 1.0, dragon: 1.0, dark: 1.0, steel: 0.5, fairy: 1.0 },
        psychic:  { normal: 1.0, fire: 1.0, water: 1.0, electric: 1.0, grass: 1.0, ice: 1.0, fighting: 2.0, poison: 2.0, ground: 1.0, flying: 1.0, psychic: 0.5, bug: 1.0, rock: 1.0, ghost: 1.0, dragon: 1.0, dark: 0.0, steel: 0.5, fairy: 1.0 },
        bug:      { normal: 1.0, fire: 0.5, water: 1.0, electric: 1.0, grass: 2.0, ice: 1.0, fighting: 0.5, poison: 0.5, ground: 1.0, flying: 0.5, psychic: 2.0, bug: 1.0, rock: 1.0, ghost: 0.5, dragon: 1.0, dark: 2.0, steel: 0.5, fairy: 0.5 },
        rock:     { normal: 1.0, fire: 2.0, water: 1.0, electric: 1.0, grass: 1.0, ice: 2.0, fighting: 0.5, poison: 1.0, ground: 0.5, flying: 2.0, psychic: 1.0, bug: 2.0, rock: 1.0, ghost: 1.0, dragon: 1.0, dark: 1.0, steel: 0.5, fairy: 1.0 },
        ghost:    { normal: 0.0, fire: 1.0, water: 1.0, electric: 1.0, grass: 1.0, ice: 1.0, fighting: 0.0, poison: 1.0, ground: 1.0, flying: 1.0, psychic: 2.0, bug: 1.0, rock: 1.0, ghost: 2.0, dragon: 1.0, dark: 0.5, steel: 1.0, fairy: 1.0 },
        dragon:   { normal: 1.0, fire: 1.0, water: 1.0, electric: 1.0, grass: 1.0, ice: 1.0, fighting: 1.0, poison: 1.0, ground: 1.0, flying: 1.0, psychic: 1.0, bug: 1.0, rock: 1.0, ghost: 1.0, dragon: 2.0, dark: 1.0, steel: 0.5, fairy: 0.0 },
        dark:     { normal: 1.0, fire: 1.0, water: 1.0, electric: 1.0, grass: 1.0, ice: 1.0, fighting: 0.5, poison: 1.0, ground: 1.0, flying: 1.0, psychic: 2.0, bug: 1.0, rock: 1.0, ghost: 2.0, dragon: 1.0, dark: 0.5, steel: 1.0, fairy: 0.5 },
        steel:    { normal: 1.0, fire: 0.5, water: 0.5, electric: 0.5, grass: 1.0, ice: 2.0, fighting: 1.0, poison: 1.0, ground: 1.0, flying: 1.0, psychic: 1.0, bug: 1.0, rock: 2.0, ghost: 1.0, dragon: 1.0, dark: 1.0, steel: 0.5, fairy: 2.0 },
        fairy:    { normal: 1.0, fire: 0.5, water: 1.0, electric: 1.0, grass: 1.0, ice: 1.0, fighting: 2.0, poison: 0.5, ground: 1.0, flying: 1.0, psychic: 1.0, bug: 1.0, rock: 1.0, ghost: 1.0, dragon: 2.0, dark: 2.0, steel: 0.5, fairy: 1.0 }
    }.freeze

    def self.calculate_damage(attacker_id, defender_id, skill_id)
        attacker = Pokemon.find(attacker_id)
        defender = Pokemon.find(defender_id)
        skill = Skill.find(skill_id)
        if skill.element_type == defender.element_type 
            stab = 1.5
        else 
            stab = 1  
        end
         rand_num = rand(85..100) / 100.0
        effectiveness = ELEMENT_CHART[skill.element_type.to_sym][defender.element_type.to_sym]
        modifier = stab * effectiveness * rand_num
        damage = (((2 * attacker.level / 5 + 2) * attacker.attack * skill.power / defender.defense) / 50 + 2) * modifier
        damage.to_i
        return damage
    end

    def self.calculate_experience(defender_level)
        rand_num = rand(20..150)
        gained_exp = rand_num * defender_level
        return gained_exp
    end


    def self.level_up?(winner_level, total_pokemon_exp)
        exp_level_limit = 2**winner_level * 100
        if total_pokemon_exp >= exp_level_limit 
            return true 
        else 
            return false
        end
    end

    def self.calculate_level_up_extra_stats
        health_point = rand(10..20)
        attack_point = rand(1..5)
        defense_point = rand(1..5)
        speed_point = rand(1..5)
    end
end