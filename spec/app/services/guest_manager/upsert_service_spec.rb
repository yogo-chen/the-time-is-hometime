# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuestManager::UpsertService do
  describe '.call' do
    let(:context) { Context.new }
    let(:data) do
      {
        first_name: 'Wayne',
        last_name: 'Woodbridge',
        email: 'wayne_woodbridge@bnb.com',
        phone_number: '639123456789'
      }
    end
    let(:guest) { Guest.new(data) }

    context 'when guest with a guest email is not exist' do
      it 'create a new guest' do
        expect(Guest).to receive(:find_by_email).with(data[:email]).and_return(nil)
        expect(Guest).to receive(:create!).with(data).and_return(guest)

        result = described_class.call(context, data)

        expect(result).to eq(guest)
      end
    end

    context 'when guest with a guest email is already exist' do
      it 'update the guest' do
        expect(Guest).to receive(:find_by_email).with(data[:email]).and_return(guest)
        expect(guest).to receive(:update!).with(data).and_return(guest)
        expect(Guest).not_to receive(:create!)

        result = described_class.call(context, data)

        expect(result).to eq(guest)
      end
    end
  end
end
