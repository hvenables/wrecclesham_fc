desc 'Delete Cancelled Fixtures'
task delete_cancelled: :environment do
  Fixture.delete_cancelled
end
