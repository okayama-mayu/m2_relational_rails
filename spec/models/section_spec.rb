require 'rails_helper' 

RSpec.describe Section, type: :model do 
    describe 'data validations' do 
        it { should validate_presence_of :name } 
        it { should validate_presence_of :labor_intensity }
        it { should allow_value(true).for(:vegan_options) }
        it { should allow_value(false).for(:vegan_options) }
    end

    it { should have_many :items }    

    describe 'instance methods' do 
        describe '#order_by_time_created' do 
            before :each do 
                @phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
                @vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
                @sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
                @drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
                @kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)
                @sections = Section.all
            end 
    
            it 'returns @sections with the newest section first and the oldest section last' do 
                expect(@sections.order_by_time_created.first).to eq @kids
                expect(@sections.order_by_time_created.last).to eq @phillys            
            end
        end
    end
end