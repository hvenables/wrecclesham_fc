# frozen_string_literal: true

class Charts::RecentFormController < ApplicationController
  before_action :load_team, only: :show

  def show
    render json: chart_data.to_json
  end

  private

  def chart_data
    {
      datasets: [{
        data: [@team.current_season.won, @team.current_season.drawn, @team.current_season.lost],
        background_color: ['#28a745','#007bff',  '#dc3545'],
        hover_background_color: ['#28a745', '#007bff','#dc3545']
      }],
      labels: %w[Won Drawn Lost]
    }
  end

  def load_team
    @team = Team.find(params[:team_id])
  end
end
