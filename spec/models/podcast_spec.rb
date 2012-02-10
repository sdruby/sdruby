require 'spec_helper'

describe Podcast do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:movie_link) }
end