class Task
  include Mongoid::Document
  field :title, :type => String
  field :deadline, :type => Date
  field :completed, :type => Boolean, :default => false
end
