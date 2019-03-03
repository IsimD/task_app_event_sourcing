require 'rails_helper'

RSpec.describe API::V1::Users, type: :request do
  let!(:user) { FactoryBot.create :user }

  before do
    Grape::Endpoint.before_each do |endpoint|
      allow(endpoint).to receive(:authenticate_user!).and_return(true)
      allow(endpoint).to receive(:current_user).and_return(user)
    end
  end

  describe '#POST /api/v1/projects' do
    let(:params) do
      {
        id: project_id,
        name: project_name,
        description: project_description
      }
    end
    let(:project_id) { '1' }
    let(:project_name) { 'Some name' }
    let(:project_description) { 'Some description' }

    subject do
      post '/api/v1/projects', params: params
    end

    it 'return expenses for current users' do
      subject
      expect(response).to have_http_status(201)
      response_json = JSON.parse(response.body)
      expect(response_json['message']).to eq('OK')
    end

    it 'create project object' do
      expect { subject }.to change { Project.count }.by(1)
    end

    it 'created project has correct attributes' do
      subject
      project = Project.find(project_id)
      expect(project.name).to eq(project_name)
      expect(project.description).to eq(project_description)
    end
  end
end
