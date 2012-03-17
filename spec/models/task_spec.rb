require 'spec_helper'

describe Task do

  it { should have_fields(:title, :deadline) }
  it { should have_field(:completed).of_type(Boolean).with_default_value_of(false) }
  it { should validate_presence_of(:title) }

  describe "scopes" do

    before do
      @overdue_task = FactoryGirl.create(:overdue_task)
      @completed_task = FactoryGirl.create(:completed_task)
      @todo_task = FactoryGirl.create(:todo_task)
    end

    describe "#completed" do
      subject { Task.completed }

      it { should include(@completed_task) }
      it { should_not include(@overdue_task) }
      it { should_not include(@todo_task) }      
    end

    describe "#pending" do
      subject { Task.pending }

      it { should include(@overdue_task) }
      it { should include(@todo_task) }
      it { should_not include(@completed_task) }
    end

    describe "#overdue" do
      subject { Task.overdue }

      it { should include(@overdue_task) }
      it { should_not include(@completed_task) }
      it { should_not include(@todo_task) }
    end

    describe "#todo" do
      subject { Task.todo }

      it { should include(@todo_task) }
      it { should_not include(@completed_task) }
      it { should_not include(@overdue_task) }
    end
  end
end
