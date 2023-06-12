require 'rails_helper'

RSpec.describe Category, type: :model do
  subject {Category::Create.(category: {name: "Rspec rocks!"}) }

  it "is valid with valid_attributes" do
    expect(subject).to be_valid
  end
  
  # it "is not valid without name" do
  #   subject.name=nil
  #   expect(subject).to_not be_valid
  # end 
end
