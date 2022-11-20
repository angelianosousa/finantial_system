require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        :title => "Title",
        :value => "9.99",
        :user_profile => nil
      ),
      Account.create!(
        :title => "Title",
        :value => "9.99",
        :user_profile => nil
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
