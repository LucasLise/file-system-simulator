Rails.application.routes.draw do
  resources :usuarios, only: [:new, :create]
  resources :discos, only: [:index] do
    member do
      get :contigua
      get :encadeada
      get :encadeada_indice
      put :deletar_bloco
      put :restaurar
      put :defragmentar
      put :gravar_bloco
    end
  end

  root 'usuarios#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
