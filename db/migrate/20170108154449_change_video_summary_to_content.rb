class ChangeVideoSummaryToContent < ActiveRecord::Migration[5.0]
  def change
    rename_column :videos, :summary, :content
  end
end
