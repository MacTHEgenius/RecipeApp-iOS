FactoryGirl.define do
  factory :recipe do
    name "My recipe"
    cooking_duration { rand * 1 }
    baking_duration 1
    author
  end
end
