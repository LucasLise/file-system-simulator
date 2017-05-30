Rails.application.routes.draw do
  resources :usuarios, only: [:new, :create]
  resources :discos, only: [:index] do
    member do
      resources :alocacao_contigua, only: [:index] do
        collection do
          put :deletar_bloco
          put :restaurar
          put :defragmentar
          put :gravar_bloco
        end
      end
      resources :alocacao_encadeada, only: [:index] do
        collection do
          put :deletar_bloco
          put :restaurar
          put :gravar_bloco
        end
      end
    end
  end

  root 'usuarios#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
