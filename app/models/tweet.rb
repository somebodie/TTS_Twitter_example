class Tweet < ApplicationRecord
  belongs_to :user

  has_many :tweet_tags
  has_many :tags, through: :tweet_tags

  before_validation :link_check, on: :create

  validates :message, presence: true
  validates :message, length: {maximum: 140,
  too_long: "A tweet is only 140 max. Everybody knows that!"}

  after_validation: apply_link, on: :create

  private

  def link_check
  if self.message.include? "http://"
    arr = self.message.split

    # .map is another Array iterator (as see ".collect")
    # it will return in an new Array the outcome
    # of our code within the curly brackets,
    # which in this case is true or false
    index = arr.map { |x| x.include? "http://" }.index(true)
    # we then find which index has the value of "true"
    # this will be the index in "arr" that has the URL

    self.link = arr[index]

    if arr[index].length > 23
      arr[index] = "#{arr[index][0..20]}..."
    end

    self.message = arr.join(" ")
  end
end

def apply_link
	arr = self.message.split
	index = arr.map { |x| x.include? "http://" }.index(true)
	url = arr[index]

	arr[index] = "<a href='#{self.link}' target='_blank'>#{url}</a>"

	self.message = arr.join(" ")

end

def


end
