require File.dirname(__FILE__) + '/../lib/group_open_id'

describe GroupOpenID do
  it "should return nil unless it can't discovers a membership location" do
    client = GroupOpenID::Client.new
    client.fetcher = fetcher(:head => {})
    client.membership_location('').should == nil
  end
  
  it "should discover the membership location" do
    client = GroupOpenID::Client.new
    client.fetcher = fetcher(:head => {'x-myid-membership-location' => 'http://member.url'})
    client.membership_location('').should == 'http://member.url'
  end
  
  it "should return where given openid is a member of the specific group id" do
    client = GroupOpenID::Client.new
    client.fetcher = fetcher(:head => {'x-myid-membership-location' => 'http://member.url', 'x-myid-membership' => 'true'})
    client.member?('', 'http://user.myid.net').should be_true   
  end
  
  it "should return member lists" do
    sample = <<-EOF
    <relations>
      <relation>
        <name>user1</name>
        <openid>http://user1.myid.net/</openid>
        <email>user1@mail.com</email>
      </relation>
      <relation>
        <name>user2</name>
        <openid>http://user2.myid.net/</openid>
        <email>user2@mail.com</email>
      </relation>
    </relations>
    EOF
    
    client = GroupOpenID::Client.new
    client.fetcher = fetcher(:head => {'x-myid-membership-location' => 'http://member.url'}, :get => sample)
    members = client.members('')
    
    members.length.should == 2
    members[0].name.should == 'user1'
    members[0].openid.should == 'http://user1.myid.net/'
    members[0].email.should == 'user1@mail.com'
  end
  
  def fetcher(ret)
    fetcher = mock('Fetcher')
    ret.each { |k,v| fetcher.should_receive(k).any_number_of_times.with(any_args).and_return(v) }
    fetcher
  end  
end