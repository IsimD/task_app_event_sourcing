require 'rails_helper'

RSpec.describe API::V1::TimeTracking, type: :request do
  let!(:user)    { FactoryBot.create :user }
  let!(:project) { FactoryBot.create :project }
  let!(:task)    { FactoryBot.create :task, project: project }

  before do
    Grape::Endpoint.before_each do |endpoint|
      allow(endpoint).to receive(:authenticate_user!).and_return(true)
      allow(endpoint).to receive(:current_user).and_return(user)
    end
  end

  describe '#POST /api/v1/time_tracking/:id/start' do
    let(:params) do
      {
        task_id: task_id,
        start_time: start_time
      }
    end
    let(:task_id)    { task.id }
    let(:start_time) { Time.now }

    subject do
      post "/api/v1/time_tracking/#{task.id}/start", params: params
    end

    context 'non started task' do
      it 'has correct response' do
        subject
        expect(response).to have_http_status(201)
        response_json = JSON.parse(response.body)
        expect(response_json['message']).to eq('OK')
      end

      it 'create time tracking point' do
        expect { subject }.to change { TimeTrackingPoint.count }.by(1)
      end
    end

    context 'already started task' do
      let!(:time_tracking_point) do
        FactoryBot.create(:time_tracking_point, user_id: user.id, task_id: task_id, stop_time: nil)
      end

      it 'return an error' do
        subject
        expect(response).to have_http_status(422)
        response_json = JSON.parse(response.body)
        expect(response_json['message']).to eq('Task already started')
      end

      it 'create time not tracking point' do
        expect { subject }.to_not change { TimeTrackingPoint.count }
      end
    end
  end

  describe '#PUT /api/v1/time_tracking/:id/stop' do
    subject do
      put "/api/v1/time_tracking/#{task.id}/stop", params: params
    end

    context 'started task' do
      let!(:time_tracking_point) do
        FactoryBot.create(
          :time_tracking_point,
          user_id: user.id,
          task_id: task_id,
          start_time: 10.minutes.ago.change(usec: 0),
          stop_time: nil
        )
      end

      let(:params) do
        {
          task_id: task_id,
          stop_time: stop_time
        }
      end

      let(:task_id) { task.id }
      let!(:stop_time) { 2.minutes.ago.change(usec: 0) }

      it 'has correct response' do
        subject
        expect(response).to have_http_status(200)
        response_json = JSON.parse(response.body)
        expect(response_json['message']).to eq('OK')
      end

      it 'update time tracking point' do
        expect { subject }.to change { time_tracking_point.reload.stop_time }
          .from(nil).to(stop_time)
      end

      context 'first time point for project' do
        it 'create time for task' do
          expect { subject }.to change { ProjectTimeTracked.count }.by(1)
        end

        it 'created time for task has correct value' do
          subject
          expect(task.task_time_tracked.time_tracked).to eq(480.0)
        end

        it 'create time project' do
          expect { subject }.to change { TaskTimeTracked.count }.by(1)
        end

        it 'created time for project has correct value' do
          subject
          expect(task.project.project_time_tracked.time_tracked).to eq(480.0)
        end
      end

      context 'project with other time points' do
        let!(:project_time_tracked) do
          FactoryBot.create(:project_time_tracked, project: project, time_tracked: 30.0)
        end

        it 'create time for task' do
          expect { subject }.to change { TaskTimeTracked.count }.by(1)
        end

        it 'update time project' do
          expect { subject }.to change { project_time_tracked.reload.time_tracked }.by(480.0)
        end
      end

      context 'task with other time tracking points' do
        let!(:task_time_tracked) do
          FactoryBot.create(:task_time_tracked, task: task, time_tracked: 15.0)
        end

        let!(:project_time_tracked) do
          FactoryBot.create(:project_time_tracked, project: project, time_tracked: 30.0)
        end

        it 'update time for task' do
          expect { subject }.to change { task_time_tracked.reload.time_tracked }.by(480.0)
        end

        it 'update time project' do
          expect { subject }.to change { project_time_tracked.reload.time_tracked }.by(480.0)
        end
      end
    end

    context 'already stoped task' do
      let!(:time_tracking_point) do
        FactoryBot.create(
          :time_tracking_point,
          user_id: user.id,
          task_id: task_id,
          start_time: 10.minutes.ago.change(usec: 0),
          stop_time: 3.minute.ago
        )
      end

      let(:task_id)    { task.id }
      let!(:stop_time) { 2.minutes.ago.change(usec: 0) }
      let(:params) do
        {
          task_id: task_id,
          stop_time: stop_time
        }
      end

      it 'return an error' do
        subject
        expect(response).to have_http_status(422)
        response_json = JSON.parse(response.body)
        expect(response_json['message']).to eq('Task not started')
      end
    end
  end
end
