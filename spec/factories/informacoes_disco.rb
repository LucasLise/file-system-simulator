FactoryGirl.define do
  factory :informacao_disco do
    tipo nil
    descricao nil
    association :disco
    cor_bloco nil
    pos_indice nil
  end
end
