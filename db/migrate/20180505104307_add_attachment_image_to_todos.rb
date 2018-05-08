class AddAttachmentImageToTodos < ActiveRecord::Migration[5.1]
  def self.up
    change_table :todos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :todos, :image
  end
end
