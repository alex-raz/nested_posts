# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  get '/:parent_slug', to: 'posts#show', as: :parent_post
  get '/:parent_slug/:child_slug', to: 'posts#show', as: :child_post
end
