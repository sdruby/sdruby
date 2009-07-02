require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

def mock_job(stubs={})
    @mock_job ||= mock_model(Job, stubs)
end

describe JobsController do
  fixtures(:jobs)

  describe 'GET index' do
    it 'assigns published jobs to @jobs' do
      Job.stub_chain(:published, :newest_first).and_return([mock_job])
      get :index
      assigns[:jobs].should == [mock_job]
    end

    specify 'jobs are displayed in descending order of creation' do
      get :index
      assigns[:jobs].should == [jobs(:my_great_job), jobs(:older_job)]
    end

  end

  describe 'GET show' do
    before do
      Job.stub(:find).with('42').and_return(mock_job)
      get :show, :id => 42
    end

    it "assigns the requested job as @job" do
      assigns[:job].should == mock_job
    end
  end

  describe 'GET edit' do
    before do
      @job = jobs(:my_great_job)
    end

    context 'logged in' do
      context 'as the job creator' do
        before do
          set_session_for users(:job_creating_rubyist)
          get :edit, :id => @job.id
        end

        it 'should not redirect' do
          response.should_not be_redirect
        end

        it 'should render the edit template' do
          response.should render_template(:edit)
        end
      end

      context 'as a user who did not create the job' do
        before do
          set_session_for users(:loyal_rubyist)
          get :edit, :id => @job.id
        end

        it 'should redirect to /jobs' do
          response.should redirect_to(jobs_path)
        end
      end
    end
    
    context 'not logged in' do
      before do
        get :edit
      end

      it 'should redirect to the login path' do
        response.should redirect_to(login_path)
      end
    end
  end

  describe 'POST create' do
    context 'not logged in' do
      before do
        post :create
      end

      it 'should redirect to the login path' do
        response.should redirect_to(login_path)
      end
    end

    context 'logged in' do
      before do
        @job_creator = users(:job_creating_rubyist)
        set_session_for @job_creator
      end

      # TODO: better way to test current_user.jobs.build than the []= expectation?
      context 'with valid params' do
        it 'assigns the newly created job as @job' do
          Job.stub!(:new).with({'these' => 'params'}).and_return(mock_job(:save => true))
          mock_job.should_receive(:[]=)

          post :create, :job => {:these => 'params'}
          assigns[:job].should equal(mock_job)
        end

        it 'redirects to the newly created job' do
          Job.stub!(:new).and_return(mock_job(:save => true))
          mock_job.should_receive(:[]=)

          post :create, :job => {}
          response.should redirect_to(job_url(mock_job))
        end
      end

      context 'with invald params' do
        it "assigns a newly created but unsaved job as @job" do
          Job.stub!(:new).with({'these' => 'params'}).and_return(mock_job(:save => false))
          mock_job.should_receive(:[]=)

          post :create, :job => {:these => 'params'}
          assigns[:job].should equal(mock_job)
        end

        it "re-renders the 'new' template" do
          Job.stub!(:new).and_return(mock_job(:save => false))
          mock_job.should_receive(:[]=)
          
          post :create, :job => {}
          response.should render_template('new')
       end
      end
    end
  end

  describe 'PUT update' do
    context 'logged in as the job creator' do
      before do
        set_session_for users(:job_creating_rubyist)
      end

      context 'with valid params' do
        it 'updates the requested job' do
          Job.should_receive(:find).with('42').and_return(mock_job)
          mock_job.should_receive(:created_by?).with(users(:job_creating_rubyist)).and_return(true)
          mock_job.should_receive(:update_attributes).with({'snoop' => 'dogg'})
          put :update, :id => 42, :job => {:snoop => 'dogg'}
        end

        it 'assigns the requested job as @job' do
          Job.stub!(:find).and_return(mock_job({:update_attributes => true, :created_by? => true}))
          put :update, :id => 42
          assigns[:job].should == mock_job
        end

        it 'redirects to the job' do
          Job.stub!(:find).and_return(mock_job({:update_attributes => true, :created_by? => true}))
          put :update, :id => 42
          response.should redirect_to(job_path(mock_job))
        end
      end

      context 'with invald params' do
        it 'updates the requested job' do
          Job.should_receive(:find).with('42').and_return(mock_job)
          mock_job.should_receive(:created_by?).with(users(:job_creating_rubyist)).and_return(true)
          mock_job.should_receive(:update_attributes).with({'snoop' => 'dogg'})
          put :update, :id => 42, :job => {:snoop => 'dogg'}
        end

        it 'assigns the requested job as @job' do
          Job.stub!(:find).and_return(mock_job({:update_attributes => false, :created_by? => true}))
          put :update, :id => 42
          assigns[:job].should == mock_job
        end

        it 're-renders the edit template' do
          Job.stub!(:find).and_return(mock_job({:update_attributes => false, :created_by? => true}))
          put :update, :id => 42
          response.should render_template('edit')
        end
      end
    end

    context 'not logged in as the job creator' do
      before do
        set_session_for users(:loyal_rubyist)
        put :update, :id => jobs(:my_great_job).id, :job => {:title => 'some other title'}
      end

      it 'should redirec to /jobs' do
        response.should redirect_to(jobs_path)
      end
    end

    context 'not logged in' do
      before do
        put :update
      end

      it 'should redirect to /login' do
        response.should redirect_to(login_path)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'logged in as the job creator' do
      before do
        set_session_for users(:job_creating_rubyist)
      end

      it 'destroys the requested job' do
        Job.stub!(:find).with('42').and_return(mock_job(:created_by? => true))
        mock_job.should_receive(:destroy)
        delete :destroy, :id => 42
      end

      it 'redirects to /jobs' do
        Job.stub!(:find).and_return(mock_job({:destroy => true, :created_by? => true}))
        delete :destroy, :id => 42
        response.should redirect_to(jobs_path)
      end
    end

    context 'not logged in as the job creator' do
      before do
        set_session_for users(:loyal_rubyist)
      end

      it 'does not destroy the requested job' do
        Job.stub!(:find).with('42').and_return(mock_job(:created_by? => false))
        mock_job.should_not_receive(:destroy)
        delete :destroy, :id => 42
      end

      it 'redirects to /jobs' do
        Job.stub!(:find).with('42').and_return(mock_job(:created_by? => false))
        delete :destroy, :id => 42
        response.should redirect_to(jobs_path)
      end
    end

    context 'not logged in' do
      it 'redirects to /login' do
        delete :destroy, :id => jobs(:my_great_job).id
        response.should redirect_to(login_path)
      end
    end
  end
end

