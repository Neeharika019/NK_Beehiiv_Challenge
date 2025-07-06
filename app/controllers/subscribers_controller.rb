# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  ##
  # GET /api/subscribers
  def index
    subscribers = Subscriber.order(created_at: :desc)
    total_records = subscribers.count
    limited_subscribers = subscribers.offset(offset).limit(limit)

    render json: {
      subscribers: limited_subscribers.as_json(only: [:id, :name, :email, :status]),
      pagination: pagination(total_records)
    }, formats: :json
  end

  ##
  # POST /api/subscribers
  def create
    subscriber = Subscriber.new(subscriber_params)
    
    if subscriber.save
      render json: {
        message: "Subscriber created successfully",
        subscriber: subscriber.as_json(only: [:id, :name, :email, :status])
      }, formats: :json, status: :created
    else
      render json: {
        message: "Failed to create subscriber",
        errors: subscriber.errors.full_messages
      }, formats: :json, status: :unprocessable_entity
    end
  end

  ##
  # PATCH /api/subscribers/:id
  def update
    subscriber = Subscriber.find(params[:id])
    
    if subscriber.update(subscriber_params)
      render json: {
        message: "Subscriber updated successfully",
        subscriber: subscriber.as_json(only: [:id, :name, :email, :status])
      }, formats: :json, status: :ok
    else
      render json: {
        message: "Failed to update subscriber",
        errors: subscriber.errors.full_messages
      }, formats: :json, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: {
      message: "Subscriber not found"
    }, formats: :json, status: :not_found
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:name, :email, :status)
  end
end
