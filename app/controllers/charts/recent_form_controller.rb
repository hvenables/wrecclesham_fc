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
        data: [@team.seasons.last.won, @team.seasons.last.drawn, @team.seasons.last.lost],
        background_color: ['#007bff', '#28a745', '#dc3545'],
        hoverBackgroundColor: ['#007bff', '#28a745', '#dc3545']
      }],
      labels: %w[Won Drawn Lost]
    }
  end

  def load_team
    @team = Team.find(params[:team_id])
  end
end
