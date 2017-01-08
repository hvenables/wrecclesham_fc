FactoryGirl.define do
  factory :video, class: Video do
    title 'Video Title'
    content 'Video Summary'
    url 'https://www.youtube.com/embed/2iOQ053s_oM'
  end
end
