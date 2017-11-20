class Cart < ActiveRecord::Base

  has_many :line_items, dependent: :destroy
  has_many :items, through: :line_items
  belongs_to :user

  def total
    total = 0
    self.line_items.each do |line_item|
      total = total + (line_item.item.price * line_item.quantity)
    end
    total
  end

  def add_item(item_id)
    line_item = self.line_items.find_by(item_id: item_id)
    if line_item
      line_item.quantity += 1
      line_item.save
      line_item
    else
      self.line_items.build(item_id: item_id)
    end
  end

  def subtract
    self.line_items.each do |line_item|
      line_item.item.update(inventory: line_item.item.inventory - line_item.quantity)
    end
  end

  def checkout
    self.update(status: "submitted")
    self.subtract
  end
end
