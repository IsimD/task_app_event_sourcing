require 'rails_helper'

RSpec.describe API::V1::Tasks, type: :request do
  let!(:user)    { FactoryBot.create :user }
  let!(:project) { FactoryBot.create :project }

  before do
    Grape::Endpoint.before_each do |endpoint|
      allow(endpoint).to receive(:authenticate_user!).and_return(true)
      allow(endpoint).to receive(:current_user).and_return(user)
    end
  end

  describe '#POST /api/v1/tasks' do
    let(:params) do
      {
        id: task_id,
        project_id: project.id,
        name: task_name,
        description: task_description
      }
    end
    let(:task_id) { '1' }
    let(:task_name) { 'Some name' }
    let(:task_description) { 'Some description' }

    subject do
      post '/api/v1/tasks', params: params
    end

    it 'has correct response' do
      subject
      expect(response).to have_http_status(201)
      response_json = JSON.parse(response.body)
      expect(response_json['message']).to eq('OK')
    end

    it 'create task object' do
      expect { subject }.to change { Task.count }.by(1)
    end

    it 'created task has correct attributes' do
      subject
      task = Task.find(task_id)
      expect(task.name).to eq(task_name)
      expect(task.description).to eq(task_description)
    end
  end

  describe '#PUT /api/v1/tasks/:id' do
    let!(:task) { FactoryBot.create(:task, project: project) }
    subject do
      put "/api/v1/tasks/#{task.id}", params: params
    end
    let(:params) do
      {
        id: task_id,
        name: task_name,
        description: task_description
      }
    end
    let(:task_id) { task.id }
    let(:task_name) { 'Some name' }
    let(:task_description) { 'Some description' }

    it 'has correct response' do
      subject
      expect(response).to have_http_status(200)
      response_json = JSON.parse(response.body)
      expect(response_json['message']).to eq('OK')
    end

    it 'doesn t create new task' do
      expect { subject }.to_not change { Task.count }
    end

    it 'update task name' do
      expect { subject }.to change { task.reload.name }.from(task.name).to(task_name)
    end

    it 'update task description' do
      expect { subject }.to change { task.reload.description }
        .from(task.description)
        .to(task_description)
    end
  end
end
