require 'rails_helper'

describe DiscussionsController, :type => :controller do
  context 'autorized user ' do
    let(:user) {FactoryGirl.create(:user)}
    #SetUp
    before do
      sign_in user
    end
    ##INDEX
    describe '#index' do
      let (:discussion) { FactoryGirl.create(:discussion, user: user)}
      it 'GET request to be success' do
        get :index
        expect(response).to be_success
      end
      it 'renders index template' do
        get :index
        expect(response).to render_template :index
      end
      it 'assigns @discussion' do
        get :index
        expect(assigns(:discussions)).to eq([discussion])
      end
    end
    ##SHOW
    describe '#show' do
      let (:discussion) { FactoryGirl.create(:discussion, user: user)}
      it 'GET request to be success' do
        get :show, id: discussion.id
        expect(response).to be_success
      end
      it 'renders index template' do
        get :show, id: discussion.id
        expect(response).to render_template :show
      end
      it 'assigns @discussion' do
        get :show, id: discussion.id
        expect(assigns(:discussion)).to eq(discussion)
      end
    end
    ##NEW
    describe '#new' do
      it 'GET request to be success' do
        get :new
        expect(response).to be_success
      end
      it 'renders new template' do
        get :new
        expect(response).to render_template :new
      end
      it 'assigns @discussion' do
        get :new
        expect(assigns(:discussion)).to be_a_new Discussion
      end
    end
    ##CREATE
    describe '#create' do
      context 'when valid' do
        let (:valid_discussion) { FactoryGirl.attributes_for(:discussion, user: user)}
        it 'it redirects to the #show action' do
          post :create, discussion: valid_discussion
          expect(response).to redirect_to discussion_path assigns[:discussion]
        end
        it 'it redirects to show' do
          post :create, discussion: valid_discussion
          expect(response).to redirect_to discussion_path Discussion.last
        end
      end
      context 'when invalid' do
        let (:bad_discussion) {FactoryGirl.attributes_for(:discussion, title: nil, user: user)}
        it 'renders :new' do
          post :create, discussion: bad_discussion
          expect(response).to render_template :new
        end
      end
    end
    ##EDIT
    describe '#edit' do
      let (:discussion) { FactoryGirl.create(:discussion, user: user) }
      it 'GET request to be success' do
        get :edit, id: discussion.id
        expect(response).to be_success
      end
      it 'renders edit template' do
        get :edit, id: discussion.id
        expect(response).to render_template :edit
      end
      it 'assigns @discussion' do
        get :edit, id: discussion.id
        expect(assigns(:discussion)).to eq discussion
      end
    end
    ##UPDATE
    describe '#update' do
      let (:discussion) { FactoryGirl.create(:discussion, user: user) }
      let (:id) { discussion.id }
      before(:each) { patch :update, discussion:{** new_values}, id: id }
      context 'when valid' do
        let (:new_values)  {  FactoryGirl.attributes_for(:discussion) }
        it 'redirects to #show' do
          expect(response).to redirect_to discussion_path discussion
        end
        it 'saves and assigns user to @discussion' do
          expect(assigns(:discussion)).to eq discussion
        end
        it 'saves updates' do
          expect { discussion.reload }.to change { discussion.title }.to(new_values[:title])
        end
      end
      context 'when invalid' do
        let (:new_values)  {  FactoryGirl.attributes_for(:discussion, title: nil) }
        it 'renders :edit template' do
          expect(response).to render_template :edit
        end
        it "object don't changing" do
          expect{ discussion.reload }.to_not change { discussion.title}
        end
      end
    end
    ##DESTROY
    describe '#destroy' do
      context 'when requested object existed' do
        let (:discussion) { FactoryGirl.create(:discussion, user: user) }
        before(:each) { delete :destroy, id: discussion.id }

        it 'redirects to #index' do
          expect(response).to redirect_to discussions_path
        end

        describe 'removes discussion form DB' do
          it 'Discussion not including destroyed discussion' do
            expect(Discussion.all).not_to include discussion
          end
          it 'throws ActiveRecord::RecordNotFound when accesing destroyed discussion' do
            expect { discussion.reload }.to raise_exception ActiveRecord::RecordNotFound
          end
        end
      end
      context "when requested object doesn't exist" do
        it 'throws ActiveRecord::RecordNotFound' do
          expect { delete :destroy, id: -1 }.to raise_exception ActiveRecord::RecordNotFound
        end
      end
    end
  end

end