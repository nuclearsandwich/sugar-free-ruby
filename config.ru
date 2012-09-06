rootie_tootie = File.expand_path "../pub", __FILE__
use Rack::Static, :urls => %w[/stylesheets /javascripts /images /fonts],
  :root => rootie_tootie

if ENV['RACK_ENV'] == 'production'
  use Rack::Auth::Basic, "Ermagerhd Slerds!" do |username, password|
    [username, password] == ['gogaruco', '2012']
  end
end

run proc {[200, { 'Content-Type' => 'text/html' }, File.read(File.join(rootie_tootie, "index.html")).lines ]}
