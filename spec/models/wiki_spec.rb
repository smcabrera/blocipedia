require 'rails_helper'

RSpec.describe Wiki, type: :model do
  describe '#add_collaborator(user)' do
    it 'creates a collaboration between the wiki and a given user' do
      alice = create(:premium_user, :name => "alice")
      bob = create(:premium_user, :name => "bob")
      bobs_wiki = create(:private_wiki, :user_id => bob.id)

      bobs_wiki.add_collaborator(alice)

      expect(alice.collaborations.first.wiki.id).to be(bobs_wiki.id)
      expect(bobs_wiki.collaborations.count).to be(2)
    end
  end

  describe '#collaborators' do
    it 'returns an array of all users who are collaborating on the wiki' do
      alice = create(:premium_user, :name => "alice")
      bob = create(:user, :name => "bob")
      alices_wiki = create(:private_wiki, :user_id => alice.id )

      alices_wiki.add_collaborator(bob)
      # TODO: I'm not sure if I should be calling that method in this test or not
      # By doing so it kind of makes this a test of both methods
      # While we're on the subject, this also tests the set_owner_as_collaborator method because it expects that to be fired as well

      expect(alices_wiki.collaborations.count).to be(2)
      expect(alices_wiki.collaborators).to eq( [alice, bob] )
    end
  end
end
