require 'rails_helper'

describe CommentsController, :type => :controller do
  context 'autorized user ' do
    let(:user) {FactoryGirl.create(:user)}
    #SetUp
    before do
      sign_in user
    end
    ##DESTROY
    describe '#destroy' do
      context 'when requested object existed' do
        let (:discussion) { create(:discussion, user: user) }
        let (:comment) { create(:comment, user: user, discussion: discussion) }
        before(:each) { delete :destroy, id: comment.id, discussion_id: discussion.id }

        it 'redirects to #index' do
          expect(response).to redirect_to discussion_path discussion
        end

        describe 'removes comment form DB' do
          it 'not including destroyed comment' do
            expect(Comment.all).not_to include comment
          end
          it 'throws ActiveRecord::RecordNotFound when accesing destroyed comment' do
            expect { comment.reload }.to raise_exception ActiveRecord::RecordNotFound
          end
        end
      end
      context "when requested object doesn't exist" do
        it 'throws ActiveRecord::RecordNotFound' do
          expect { delete :destroy, id: -1, discussion_id: 1 }.to raise_exception ActiveRecord::RecordNotFound
        end
      end
    end
  end

end