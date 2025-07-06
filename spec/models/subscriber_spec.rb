require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      subscriber = Subscriber.new(name: 'John Doe', email: 'john@example.com', status: 'active')
      expect(subscriber).to be_valid
    end

    it 'requires an email' do
      subscriber = Subscriber.new(name: 'John Doe', status: 'active')
      expect(subscriber).not_to be_valid
      expect(subscriber.errors[:email]).to include("can't be blank")
    end

    it 'requires a unique email (case insensitive)' do
      Subscriber.create!(name: 'John Doe', email: 'john@example.com', status: 'active')
      subscriber = Subscriber.new(name: 'Jane Doe', email: 'JOHN@EXAMPLE.COM', status: 'active')
      expect(subscriber).not_to be_valid
      expect(subscriber.errors[:email]).to include('has already been taken')
    end

    it 'validates status inclusion' do
      subscriber = Subscriber.new(name: 'John Doe', email: 'john@example.com', status: 'invalid')
      expect(subscriber).not_to be_valid
      expect(subscriber.errors[:status]).to include('is not included in the list')
    end
  end

  describe 'email normalization' do
    it 'normalizes email to lowercase and strips whitespace' do
      subscriber = Subscriber.new(name: 'John Doe', email: '  JOHN@EXAMPLE.COM  ', status: 'active')
      subscriber.valid?
      expect(subscriber.email).to eq('john@example.com')
    end
  end

  describe 'default status' do
    it 'sets default status to active if not provided' do
      subscriber = Subscriber.new(name: 'John Doe', email: 'john@example.com')
      subscriber.valid?
      expect(subscriber.status).to eq('active')
    end
  end
end 