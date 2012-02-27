require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do
  render_views

  [:index, :sponsors].each do |page|
    describe "on GET to #{page}" do
      before { get page }
      it { should respond_with(:success) }
    end
  end
end
