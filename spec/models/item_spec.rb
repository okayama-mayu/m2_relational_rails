require 'rails_helper' 

RSpec.describe Item, type: :model do 
    describe 'data validations' do 
        it { should validate_presence_of :name }
        it { should validate_presence_of :price }

        it { should allow_value(true).for(:need_restock) }
        it { should allow_value(false).for(:need_restock) }
    end
    
    it { should belong_to(:section) }
end