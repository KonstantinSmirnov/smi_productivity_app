# spec/models/project.rb
require 'rails_helper'

describe Project do
  it "has a valid factory" do
    expect(FactoryGirl.create(:project)).to be_valid
  end
  
  it "is invalid without a title" do
    expect(FactoryGirl.build(:project, title: nil)).not_to be_valid
  end
  it "is invalid without a lastname"
  it "returns a contact's full name as a string"
  
end

