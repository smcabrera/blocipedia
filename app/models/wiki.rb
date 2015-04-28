class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  validates :user, presence: true

  after_save :set_owner_as_collaborator

  def add_collaborator(user)
    Collaboration.create(:user_id => user.id, :wiki_id => self.id)
  end

  def collaborators
    self.collaborations.map { |c| c.user }
  end

  private

  def set_owner_as_collaborator
    user = self.user
    Collaboration.create(:user_id => user.id, :wiki_id => self.id)
  end
end
