# frozen_string_literal: true

require 'constraints/post_route'

Rails.application.routes.draw do
  root 'pages#home'

  constraints(PostRoute) do
    get '/:parent_slug', to: 'posts#show', as: :parent_post
    get '/:parent_slug/:child_slug', to: 'posts#show', as: :child_post
  end

  get '/mounted_to_root', to: 'pages#mounted_to_root'
end
