require 'rspec'

RSpec.describe `curl -q -I 10.133.22.244:80` do
 it { should match("200 OK") } 
 it { should match("Server: nginx") }
end
