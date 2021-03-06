require 'spec_helper'

describe Task do 
  describe 'attributes' do 
    it { should respond_to(:title) }
    it { should respond_to(:status) }
    it { should respond_to(:position) }
    it { should respond_to(:deadline) }
    it { should respond_to(:description) }
    it { should respond_to(:priority) }
  end

  describe 'general methods' do 
    it { should respond_to(:complete?) }
    it { should respond_to(:incomplete?) }
    it { should respond_to(:to_hash) } # to integrate with Sinatra-Backbone
  end

  describe 'acts_as_list methods' do 
    it { should respond_to(:insert_at) }
    it { should respond_to(:move_lower) }
    it { should respond_to(:move_higher) }
    it { should respond_to(:move_to_bottom) }
    it { should respond_to(:move_to_top) }
    it { should respond_to(:remove_from_list) }
    it { should respond_to(:increment_position) }
    it { should respond_to(:decrement_position) }
    it { should respond_to(:set_list_position) }
    it { should respond_to(:first?) }
    it { should respond_to(:last?) }
    it { should respond_to(:in_list?) }
    it { should respond_to(:not_in_list?) }
    it { should respond_to(:default_position?) }
    it { should respond_to(:higher_item) }
    it { should respond_to(:lower_item) }
    it { should respond_to(:higher_items) }
    it { should respond_to(:lower_items) }
  end

  describe 'validations' do 
    before(:each) do 
      @task = Task.new
    end

    context 'pertaining to title' do 
      it 'is invalid without a title' do 
        expect(@task).not_to be_valid
      end
    end

    context 'pertaining to status' do 
      it 'doesn\'t permit invalid status' do 
        @task.title = "Foo"
        @task.status = "Bar"
        expect(@task).not_to be_valid
      end
    end

    context 'pertaining to priority' do 
      it 'doesn\'t permit invalid priorities' do 
        @task.title = 'Foo'
        @task.priority = 'Bar'
        expect(@task).not_to be_valid
      end
    end
  end

  describe 'default behavior' do 
    before(:each) do 
      2.times { FactoryGirl.create(:task) }
      Task.create!(title: "New task", task_list_id: 1)
      @task = Task.last
    end

    it 'instantiates at position 1' do 
      expect(@task.position).to eql 1
    end

    it 'sets status to \'new\'' do
      expect(@task.status).to eql 'new'
    end

    it 'sets priority to \'normal\'' do 
      expect(@task.priority).to eql 'normal'
    end
  end
end