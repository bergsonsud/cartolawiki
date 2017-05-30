class HomeController < ApplicationController
before_action :set_status_liga, only: [:minha_liga]
before_action :set_status,:set_rodada


require 'open-uri'
require 'rest-client'
require 'rubygems'
require 'json'


  def index 
  	@players = JSON.parse(open("https://api.cartolafc.globo.com/mercado/destaques").read, symbolize_names: true)  	  	  	  	
  end

  def actual_games

  end

  def minha_liga
  	@teams = @ads[:times]
  end

  def rodada

  end

  def trocar_rodada
      @rodada  = params[:rodada]      
  end  


private
    def status

      token = '1f78a2a43061262a4ca86b1fe12ba3fb12d38656a7571757a73715145614b6774567a65476c466647596c354736624568456d435a324257574e5475773669566865416c6e7547526a38646e4b6865477968436d65346c667a7a55324d4a5a61486130715435413d3d3a303a62657267736f6e7375645f6c696d61'      
        RestClient.get("https://api.cartolafc.globo.com/auth/liga/adsfn2013-2", {'X-GLB-Token' => token}) do |f|        
          x = JSON.parse(f, symbolize_names: true)
          
          if x[:mensagem].to_s != "Mercado em manutenção."
            @ads = JSON.parse(RestClient.get("https://api.cartolafc.globo.com/auth/liga/adsfn2013-2", {'X-GLB-Token' => token}), symbolize_names: true)
          else
            redirect_to root_path            
          end

        end 
        
      
    end

    def set_rodada
      @rodada = @status[:rodada_atual].to_s
      @rodada = params[:rodada].to_s if params[:rodada].present? and !@rodada.empty? 
      data = JSON.parse(open("https://api.cartolafc.globo.com/partidas/"+@rodada).read, symbolize_names: true)                
      @games = data[:partidas]
      @teams = data[:clubes]
      @teams = @teams.with_indifferent_access 
    end

    def set_status     
      @status = JSON.parse(open("https://api.cartolafc.globo.com/mercado/status").read, symbolize_names: true)          
    end  

    def set_status_liga  
      status
      
    end      
 
end
