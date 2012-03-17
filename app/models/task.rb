class Task
  include Mongoid::Document
  field :title, type: String
  field :deadline, type: Date
  field :completed, type: Boolean, default: false

  attr_accessible :title, :deadline, :completed

  validates_presence_of :title

  default_scope order_by([:deadline, :desc])
  scope :completed, where(completed: true)
  scope :pending, where(completed: false)
  scope :overdue, where(:deadline.lt => Date.today).pending
  scope :todo, any_of({ :deadline.gt => Date.today }, { deadline: nil }).pending
end
