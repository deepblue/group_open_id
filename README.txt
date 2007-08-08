= Group Open ID

* Homepage: http://deepblue.springnote.com/pages/406396
* Author: Bryan Kang (http://myruby.net)

== DESCRIPTION:
  
Wrapper library for myID.net's Group ID API

== FEATURES/PROBLEMS:
  
* TBD

== SYNOPSIS:

 require 'group_open_id'
 
 # Initialize a client
 GroupOpenID::Client.app_key = 'your_application_key'
 client = GroupOpenID::Client.new('user_open_id_url', 'user_key')
 group_id = GroupOpenID::URI.new('http://ruby.myid.net', client)
 
 # Get the membership location
 puts group_id.membership_location # => 'http://some.url/'
 
 # Get member lists
 puts group_id.members # => array of GroupOpenID::Member 
 
 # Determine where a given open_id is the member of a group id
 puts group_id.member?('http://deepblue.myid.net') # => true

== REQUIREMENTS:

* rest_open_uri
* Hpricot

== INSTALL:

* sudo gem install group_open_id

== LICENSE:

(The MIT License)

Copyright (c) 2007 Bryan Kang

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
