class ChangeResultUrlToResultsUrl < ActiveRecord::Migration[5.0]
  def change
    rename_column :cups, :result_url, :results_url
  end
end
