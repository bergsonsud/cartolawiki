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
end
