require 'rails_helper' 

RSpec.describe Item, type: :model do 
    describe 'data validations' do 
        it { should validate_presence_of :name }
        # it { should validate_presence_of :need_restock }
        it { should validate_presence_of :price }
    end
    
    it { should belong_to(:section) }
end