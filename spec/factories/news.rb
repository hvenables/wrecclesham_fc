FactoryGirl.define do
  factory :news, class: News do
    title 'Title'
    summary 'Summary'
    content 'Content'
    image { File.new("#{Rails.root}/spec/support/fixtures/image.png") }
  end
end
