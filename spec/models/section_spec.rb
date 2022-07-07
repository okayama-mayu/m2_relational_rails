require 'rails_helper' 

RSpec.describe Section, type: :model do 
    describe 'data validations' do 
        it { should validate_presence_of :name } 
        it { should validate_presence_of :labor_intensity }
        it { should allow_value(true).for(:vegan_options) }
        it { should allow_value(false).for(:vegan_options) }
    end

    it { should have_many :items }    
end