class HomeController < ApplicationController
before_action :set_status

require 'open-uri'
require 'rest-client'
require 'rubygems'
require 'json'


  def index 
  	@players = JSON.parse(open("https://api.cartolafc.globo.com/mercado/destaques").read, symbolize_names: true)  	  	  	  	
  end

  def actual_games
	data = JSON.parse(open("https://api.cartolafc.globo.com/partidas/"+@status[:rodada_atual].to_s).read, symbolize_names: true)  	  	  	  	
	@games = data[:partidas]
	@teams = data[:clubes]
	@teams = @teams.with_indifferent_access	
  end

  def minha_liga
  	@teams = @ads[:times]
  end


private
    def set_status
      @status = JSON.parse(open("https://api.cartolafc.globo.com/mercado/status").read, symbolize_names: true)  	
      jdata =  JSON.parse('{"payload":{"email":"bergsonsud@gmail.com","password":"","serviceId": 438}}')  		                
      #@request = RestClient.post('https://login.globo.com/api/authentication', jdata)
      @request = RestClient.post('https://login.globo.com/api/authentication', jdata.to_json, content_type: :json)
      #@aads = JSON.parse(open("https://api.cartolafc.globo.com/ligas?q=adsfn2013.2").read, symbolize_names: true)      
      token = '1f78a2a43061262a4ca86b1fe12ba3fb12d38656a7571757a73715145614b6774567a65476c466647596c354736624568456d435a324257574e5475773669566865416c6e7547526a38646e4b6865477968436d65346c667a7a55324d4a5a61486130715435413d3d3a303a62657267736f6e7375645f6c696d61'
      @ads = JSON.parse(RestClient.get("https://api.cartolafc.globo.com/auth/liga/adsfn2013-2", {'X-GLB-Token' => token}), symbolize_names: true)
    end  
 
end
