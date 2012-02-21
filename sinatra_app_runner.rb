require 'rubygems'
require 'sinatra'
require 'siteswap'

@@siteswap = Siteswap.new(@pattern_length, @objects)

get '/' do
  html = ""
  html << @@siteswap.values
  return html
end

post '/patterns' do
  html = ""
  @@siteswap.get_values(params[:props], params[:length], params[:required], params[:excluded])
  html << @@siteswap.all_patterns
  return html
end