class Todo < ApplicationRecord
  include AASM
  has_attached_file :image, styles: { medium: "100x100", thumb: "20x20" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
  do_not_validate_attachment_file_type :image

  aasm :column => :status do 
    state :pending, :initial => true
    state :completed
    state :cancel
 
    event :completed do
      transitions :from => [:pending, :cancel], :to => [:completed]
    end
    event :cancel do
      transitions :from => [:pending, :completed], :to => [:cancel]
    end 
    event :pending do
      transitions :from => [:completed, :cancel], :to => [:pending]
    end
  end 

  def perform_event(event)
    if event == 'completed'
      self.completed!
    elsif event == 'cancel'
      self.cancel! 
    elsif event == 'pending'
      self.pending! 
    end
  end
end
