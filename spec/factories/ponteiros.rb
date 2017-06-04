FactoryGirl.define do
  factory :ponteiro do
    posicao nil
    valor nil
    association :disco
  end
end
