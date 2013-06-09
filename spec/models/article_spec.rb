require 'spec_helper'

describe Article do
  it "should test some thing that will pass" do
  	@article = Article.new(:title => "test1")
  	@article.should be_valid
  end
  it 'should test some silly thing that will now pass' do
    @article = Article.new
    @article.should_not be_valid
  end

end
