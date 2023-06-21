class SkillsController < ApplicationController
    def index
        @skills = Skill.paginate(page: params[:page]).order('id')
    end

    def new 
        @skill = Skill.new
        @element_type = Elements::ELEMENT_TYPE
    end

    def create 
        @skill = Skill.new(skill_params)
        if @skill.save 
            redirect_to skills_url
        end
    end

    def edit 
        @skill = Skill.find(params[:id])
    end

    def update 
        @skill = Skill.find(params[:id])
        if @skill.update(skill_params)
            redirect_to skills_url
        end
    end

    def destroy 
        Skill.find(params[:id]).destroy
        redirect_to skills_url
    end

    private

    def skill_params 
        params.require(:skill).permit(:name, :power, :max_pp, :element_type)
    end
end
