FactoryGirl.define do

  factory :overdue_task, :class => Task do
    title 'overdue'
    deadline Date.today - 1
  end

  factory :completed_task, :class => Task do
    title 'completed'
    completed true
    deadline Date.today - 1
  end
  
  factory :todo_task, :class => Task do
    title 'todo'
    deadline Date.today + 1
  end    

end
