class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  # I'm not sure if I want wikis to destroy but otherwise I have to
  # add a whole lot of logic relating to wikis without users

  # A little confusing--users have their own wikis (aliased as owned_wikis) but they also have wikis through collaborations
  # Note that for this to make sense we also have to set all users as collaborators on their own wikis otherwise we won't be able to call User.wikis and get all the wikis they're collaborators on.
  # TODO: This is a little confusing and it could be worth writing a blog post explaining this

  has_many :owned_wikis, class_name: "Wiki", dependent: :destroy
  has_many :collaborations
  has_many :wikis, through: :collaborations
  has_one :subscription, dependent: :destroy

  after_initialize :init

  def init
    self.role ||= "free"
  end

  def subscribed?
    self.subscription != nil
  end

  def collaborator?(user)

  end
end
