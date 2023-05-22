require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'validations' do
    subject {
      Guest.new(email: "sample@sample.com", first_name:"Ae", last_name: "Bee", phone_numbers:["639123456789"])
    }

    it 'must validates all fields' do
      expect(subject).to be_valid
      expect(subject.save).to be true
    end
  end
  
end
