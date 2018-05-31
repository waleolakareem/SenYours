class Blog < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  self.per_page = 10
  mount_uploader :image, BlogImageUploader

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    Blog.next(self.id).first
  end

  def previous
    Blog.previous(self.id).first
  end


end
