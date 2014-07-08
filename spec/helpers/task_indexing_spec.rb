require 'spec_helper'

describe TaskIndexing do 
  include TaskIndexing 

  describe 'dup and gap methods' do 
    describe 'dup method' do 
      before(:each) do 
        Task.stub(:count).and_return(5)
      end

      it 'returns an integer if there is a duplicate index' do
        @indices = [1, 2, 3, 3, 4]
        expect(dup).to be_an Integer
      end

      it 'returns nil if there is no duplicate index' do 
        @indices = [1, 2, 3]
        expect(dup).to be nil
      end
    end

    describe 'gap method' do 
      before(:each) do 
        Task.stub(:count).and_return(3)
      end

      it 'returns an integer if there is a missing index' do 
        @indices = [1, 3, 4]
        expect(gap).to be_an Integer 
      end

      it 'returns nil if there is no missing index' do 
        @indices = [1, 2, 3]
        expect(gap).to eql nil
      end
    end 

    context 'no tasks' do 
      before(:each) do 
        Task.stub(:count).and_return(0)
      end

      it 'does not identify a duplicate' do 
        expect(dup).to be nil
      end

      it 'does not identify a gap' do 
        expect(gap).to be nil
      end
    end

    context 'two or more tasks' do 
      before(:each) do 
        Task.stub(:count).and_return(2)
      end

      it 'identifies a duplicate' do 
        @indices = [1, 1]
        expect(dup).to eql 1
      end

      it 'identifies a gap' do 
        @indices = [1, 3]
        expect(gap).to eql 2
      end
    end
  end

  describe 'task indexing functionality' do 
    context 'when new task is created' do 
      before(:each) do 
        2.times { |n| FactoryGirl.create(:task, index: n+1) }
      end

      context 'and no index is explicitly set' do 
        before(:each) do 
          FactoryGirl.create(:task)
          update_indices
        end

        it 'sets the new task\'s index to 1' do 
          expect(Task.last.index).to eql 1
        end

        it 'increases the other tasks\' indices' do 
          expect(Task.pluck(:index).sort).to eql [1, 2, 3]
        end
      end

      context 'and the index is explicitly set' do 
        before(:each) do 
          FactoryGirl.create(:task, title: "My New Task", index: 2)
          update_indices
        end

        it 'assigns the given index' do 
          expect(Task.last.index).to eql 2
        end

        it 'moves the task previously at the given index' do 
          expect(Task.pluck(:index).sort).to eql [1, 2, 3]
        end

        it 'doesn\'t move the first task' do 
          expect(Task.first.index).to eql 1
        end
      end
    end
  end
end