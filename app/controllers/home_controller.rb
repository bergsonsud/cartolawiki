class HomeController < ApplicationController
before_action :set_status
#before_action :authenticate, except: [ :index ]

require 'open-uri'
require 'rest-client'
require 'rubygems'
require 'json'
require 'pp'


  def index 
  	@players = JSON.parse(open("https://api.cartolafc.globo.com/mercado/destaques").read, symbolize_names: true)  	  	  	  	
  end

  def actual_games
	data = JSON.parse(open("https://api.cartolafc.globo.com/partidas/"+@status[:rodada_atual].to_s).read, symbolize_names: true)  	  	  	  	
	@games = data[:partidas]
	@teams = data[:clubes]
	@teams = @teams.with_indifferent_access	
  end


private
    def set_status
      @status = JSON.parse(open("https://api.cartolafc.globo.com/mercado/status").read, symbolize_names: true)  	
      jdata =  JSON.parse('{"payload":{"email":"bergsonsud@gmail.com","password":"","serviceId": 438}}')  		                
      #@request = RestClient.post('https://login.globo.com/api/authentication', jdata)
      #@request = RestClient.post('https://login.globo.com/api/authentication', jdata.to_json, content_type: :json)
      @ads = JSON.parse(open("https://api.cartolafc.globo.com/ligas?q=adsfn2013.2").read, symbolize_names: true)      



    end  

	def authenticate
	  authenticate_or_request_with_http_token do |token, options|
	    # Compare the tokens in a time-constant manner, to mitigate
	    # timing attacks.
	    ActiveSupport::SecurityUtils.secure_compare(
	      ::Digest::SHA256.hexdigest(token),
	      ::Digest::SHA256.hexdigest(TOKEN)
	    )
	  end
	end    
end
