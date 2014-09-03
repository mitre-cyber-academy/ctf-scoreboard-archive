require 'spec_helper'

describe "messages/edit" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :user_id => 1,
      :game_id => 1,
      :text => "MyText"
    ))
  end

  it "renders the edit message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path(@message), :method => "post" do
      assert_select "input#message_user_id", :name => "message[user_id]"
      assert_select "input#message_game_id", :name => "message[game_id]"
      assert_select "textarea#message_text", :name => "message[text]"
    end
  end
end
