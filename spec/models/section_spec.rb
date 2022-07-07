require 'rails_helper' 

RSpec.describe Section, type: :model do 
    describe 'data validations' do 
        it { should validate_presence_of :name }
        # it { should validate_presence_of :vegan_options } 
        it { should validate_presence_of :labor_intensity }
    end

    it { should have_many :items }    
end