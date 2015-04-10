FactoryGirl.define do
  factory :wiki do
    title "Wiki title"
    body "Wiki body"

    factory :public_wiki do
      send("private", false)
    end

    factory :private_wiki do
      send("private", true)
    end
  end
end
