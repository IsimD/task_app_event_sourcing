# require 'rails_helper'
#
# RSpec.describe API::V1::Users, type: :request do
#  let!(:user) { FactoryBot.create :user }
#
#  describe 'GET :index' do
#    subject { get '/api/v1/users', headers: { Authorization: "Bearer #{user.auth_token}" } }
#
#    it 'return expenses for current users' do
#      subject
#      response_json = JSON.parse(response.body)
#    end
#  end
# end
