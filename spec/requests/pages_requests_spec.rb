# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET #home' do
    it 'responds with 200' do
      create(:post, title: 'Parent Post')

      get '/'

      expect(response).to have_http_status(:ok)
      body = response.body
      expect(body).to include('<h1>Nested Posts</h1>')
      expect(body).to include('Parent Post')
    end
  end

  describe 'GET #mounted_to_root' do
    it 'responds with 200' do
      get '/mounted_to_root'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #page_that_does_not_exists' do
    it 'raises ActionController::RoutingError' do
      expect { get '/page_that_does_not_exists' }.to raise_error(ActionController::RoutingError)
    end
  end
end
