class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  # I'm not sure if I want wikis to destroy but otherwise I have to
  # add a whole lot of logic relating to wikis without users
  has_many :wikis, dependent: :destroy

  after_initialize :init

  def init
    self.role ||= "free"
  end
end
