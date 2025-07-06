# frozen_string_literal: true

require "rails_helper"

RSpec.describe SubscribersController, type: :controller do
  let(:valid_attributes) {
    { name: 'John Doe', email: 'john@example.com', status: 'active' }
  }

  let(:invalid_attributes) {
    { name: 'John Doe', email: '', status: 'active' }
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "returns subscribers with pagination" do
      subscriber = Subscriber.create! valid_attributes
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response['subscribers']).to be_an(Array)
      expect(json_response['pagination']).to be_present
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Subscriber" do
        expect {
          post :create, params: { subscriber: valid_attributes }
        }.to change(Subscriber, :count).by(1)
      end

      it "renders a JSON response with the new subscriber" do
        post :create, params: { subscriber: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(/application\/json/)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new subscriber" do
        post :create, params: { subscriber: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(/application\/json/)
      end
    end
  end

  describe "PATCH #update" do
    let(:subscriber) { Subscriber.create! valid_attributes }

    context "with valid params" do
      let(:new_attributes) {
        { status: 'inactive' }
      }

      it "updates the requested subscriber" do
        patch :update, params: { id: subscriber.to_param, subscriber: new_attributes }
        subscriber.reload
        expect(subscriber.status).to eq('inactive')
      end

      it "renders a JSON response with the subscriber" do
        patch :update, params: { id: subscriber.to_param, subscriber: new_attributes }
        expect(response).to be_successful
        expect(response.content_type).to match(/application\/json/)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the subscriber" do
        patch :update, params: { id: subscriber.to_param, subscriber: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(/application\/json/)
      end
    end

    context "with non-existent subscriber" do
      it "returns not found status" do
        patch :update, params: { id: 999, subscriber: valid_attributes }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
