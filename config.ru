rootie_tootie = File.expand_path "../pub", __FILE__
use Rack::Static, :urls => %w[/stylesheets /javascripts /images /fonts],
  :root => rootie_tootie

run proc {[200, { 'Content-Type' => 'text/html' }, File.read(File.join(rootie_tootie, "index.html")).lines ]}
