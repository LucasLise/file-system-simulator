Rails.application.routes.draw do
  resources :usuarios, only: [:new, :create] do
    resources :discos, only: [:show] do
      member do
        put :deletar_bloco
        put :restaurar_disco
        put :defragmentar_disco
        put :gravar_disco
      end
    end
  end

  root 'usuarios#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
