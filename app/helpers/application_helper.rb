module ApplicationHelper

	def dia_local_lugar data_horario,local
		l(data_horario,format: "%a") +" "+data_horario.strftime("%d/%m/%Y")+" "+local+" "+data_horario.strftime("%H:%M")
	end

	def extenso num
		num.to_s+"º"
	end

	def situacao_rodada situacao
		if situacao == "v"
			'<div class="circle-green"></div>'
		elsif situacao == "d"			
			'<div class="circle-red"></div>'
		else
			'<div class="circle-silver"></div>'
		end			
	end

	def rodada_tem_anterior? rodada,atual
		rodada > 1 and rodada <=atual ? true : false		
	end

	def rodada_tem_proxima? rodada,atual
		rodada >0 and rodada <atual ? true : false		
	end

	def atletas_por_slug slug
		atletas = JSON.parse(RestClient.get("https://api.cartolafc.globo.com/time/slug/"+slug, nil), symbolize_names: true)
	end

	def somar_pontos_por_slug slug
		#token = '1f78a2a43061262a4ca86b1fe12ba3fb12d38656a7571757a73715145614b6774567a65476c466647596c354736624568456d435a324257574e5475773669566865416c6e7547526a38646e4b6865477968436d65346c667a7a55324d4a5a61486130715435413d3d3a303a62657267736f6e7375645f6c696d61'      	
	      if @mercado != "Aberto"
	      	points = JSON.parse(RestClient.get("https://api.cartolafc.globo.com/atletas/pontuados", nil), symbolize_names: true)
	      	points = points[:atletas].with_indifferent_access
	      	atletas = JSON.parse(RestClient.get("https://api.cartolafc.globo.com/time/slug/"+slug, nil), symbolize_names: true)
	      	pontos  = 0      	
	      	atletas[:atletas].each do |atleta|      		
	   				#pontos = pontos+points[atleta[:atleta_id].to_s][:pontuacao].to_i
	      		pontos = pontos+atleta[:pontos_num].to_i
	      	end
	      	pontos
	      else
	      	0
	      end
	end
end
