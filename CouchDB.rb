require 'sinatra'
require 'haml' # template engine
require 'couchrest'
require 'json'
 
 
db=nil
 
def get_couch_db(creds) 
  url = creds['url']
  if !url.end_with?('/')
    url = url + '/'
  end
  url = url + 'lennartdb2'
  puts 'Using URL: ' + url
  #This will create the DB if it does not exist, however it will fail if you do not  have permissions
  db = CouchRest.database!(url)
end
 
 
# control part of MVC
# an HTTP method paired with a URL-matching pattern
get '/' do
  # page variable
  @version = RUBY_VERSION
  @os = RUBY_PLATFORM
  @env = {}
  ENV.each do |key, value|
    begin
      hash = JSON.parse(value)
      @env[key] = hash
    rescue
      @env[key] = value
    end
  end
       
  appInfo = @env["VCAP_APPLICATION"]
  services = @env["VCAP_SERVICES"]
 
 
  if ENV['VCAP_SERVICES'] 
    svcs = JSON.parse ENV['VCAP_SERVICES'] 
    cloudant = svcs.detect { |k,v| k =~ /^cloudantNoSQLDB/ }.last.first 
    creds = cloudant['credentials'] 
  end 
 
  db = get_couch_db(creds) 
 
  mydoc= {:name => 'Lennart', :info => 'Some text'}
  puts mydoc
  db.save_doc(mydoc)
 
  # render template
  haml :hi
end
