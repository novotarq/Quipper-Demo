require 'spec_helper'

describe "tasks", :type => :request do

  describe "create a task so that I will not forget something to do" do
    it "#good path" do
      visit '/'
      click_link 'New'
      fill_in 'Title', with: 'my task'
      find('.submit_button').click

      page.current_path.should == tasks_path
      page.has_content?('my task').should be true
    end

    it "#bad path" do
      visit '/'
      click_link 'New'
      find('.submit_button').click

      page.current_path.should == tasks_path
      page.has_content?("Title can't be blank").should be true
    end

    it "#with a deadline" do
      visit '/'
      click_link 'New'
      fill_in 'Title', with: 'my deadline task'
      fill_in 'Deadline', with: Date.today - 1
      find('.submit_button').click

      page.current_path.should == tasks_path
      page.has_content?((Date.today - 1).strftime("%Y-%m-%d")).should be true
    end
  end

  describe "edit a task so that I can change a task after I created" do
    before do
      FactoryGirl.create(:todo_task)
    end

    it "#good path" do
      visit '/'
      #TODO this is bad, it should be changed to permalink (or something else which is unique)
      click_link 'edit_todo'

      fill_in 'Title', with: 'my task'
      find('.submit_button').click

      page.current_path.should == tasks_path
      page.has_content?('my task').should be true
    end

    it "#bad path" do
      visit '/'
      #TODO this is bad, it should be changed to permalink (or something else which is unique)
      click_link 'edit_todo'
      fill_in 'Title', with: ''
      find('.submit_button').click

      page.has_content?("Title can't be blank").should be true
    end    
  end

  describe "I want to mark a task as done so that I can distinguish incomplete tasks from complete ones" do
    before do
      FactoryGirl.create(:todo_task)
    end

    it "#good path" do
      visit '/'
      find('#task_completed').click

      page.has_content?('Completed').should be true
    end
  end


  describe "I want to see all tasks which didn't meet deadline as of today" do
    before do
      FactoryGirl.create(:overdue_task)
    end

    it "#good path" do
      visit '/'

      page.has_content?('Overdue').should be true
    end
  end

  describe "I want to delete a task so that I can remove task which is not a task any more", :js => true do
    before do
      FactoryGirl.create(:todo_task)
    end

    it "#good path" do
      visit '/'

      click_link 'Destroy'
      #TODO it's the simplest (and slow) way to do that, think about https://github.com/thoughtbot/capybara-webkit/issues/84
      page.driver.browser.switch_to.alert.accept

      page.has_content?('Todo').should be false
    end
  end

end
