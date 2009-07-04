require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
#set_session_for users(:job_creating_rubyist)

describe UserSessionsController do
  describe 'GET new' do
    context 'logged in' do
      before do
        set_session_for users(:loyal_rubyist)
        get :new
      end

      it 'should redirect to /account' do
        response.should redirect_to(account_path)
      end
    end

    context 'not logged in' do
      before do
        get :new
      end

      it 'should render the login page' do
        response.should render_template('new')
      end
    end
  end

  describe 'POST create' do
    context 'logged in' do
      before do
        set_session_for users(:loyal_rubyist)
        post :create
      end

      it 'should redirect to the account page' do
        response.should redirect_to(account_path)
      end
    end

    context 'not logged in' do
      before do
        post :create
      end

      it 'should render the login page' do
        response.should render_template('new')
      end
    end
  end

  describe 'DELETE destroy' do
    context 'not logged in' do

    end

    context 'logged in' do

    end
  end
end

