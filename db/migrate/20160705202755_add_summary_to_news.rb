class AddSummaryToNews < ActiveRecord::Migration[5.0]
  def change
    add_column :news, :summary, :string
  end
end
