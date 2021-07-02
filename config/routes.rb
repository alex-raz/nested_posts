# frozen_string_literal: true

Rails.application.routes.draw do

  get '/:parent_slug', to: 'posts#show', as: :parent_post
  get '/:parent_slug/:child_slug', to: 'posts#show', as: :child_post
end
