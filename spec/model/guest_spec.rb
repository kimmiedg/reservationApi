require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'validations' do
    subject {
      Guest.new(email: "sample@sample.com")
    }

    it 'validates uniqueness of guests email' do
      expect(subject).to validate_uniqueness_of(:email)
    end

    it 'must validates all fields' do
      %i[email first_name last_name phone_numbers].each do |f|
        expect(subject).to validate_presence_of(f)
      end
    end

  end
end
