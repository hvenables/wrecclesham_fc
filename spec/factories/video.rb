FactoryGirl.define do
  factory :video, class: Video do
    title 'Video Title'
    summary 'Video Summary'
    url 'https://www.youtube.com/embed/2iOQ053s_oM'
    thumbnail 'https://i.ytimg.com/vi/2iOQ053s_oM/mqdefault.jpg'
    after(:build) { |user|
      user.class.any_instance.stub(:add_thumbnail)
    }

    trait :with_before_save_callback do
      after(:build) { |user|
        user.class.any_instance.unstub(:add_thumbnail)
      }
    end
  end
end
