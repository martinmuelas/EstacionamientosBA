require File.dirname(__FILE__) + '/Functions.rb'

# Abre navegador y web
# b = Abrir_Navegador(File.dirname(__FILE__))
b = Abrir_Navegador()
puts "\nSe abrió el navegador!\n\n"

adIndex = 0

puts "*****************"
puts "\nAnuncio Nro: " + adIndex.to_s
puts "*****************"

##################################
# BARRE LOS ANUNCIOS DE UNA PAGINA
##################################
while b.element(:css, "li[data-id='ad#{adIndex.to_s}']").exists?

	# Selecciona y abre el primer item de la lista
	b.element(:css, "li[data-id='ad#{adIndex.to_s}']").click

	# Agurda a que la página esté completamente cargada
	# puts "Duerme: " + Time.now.to_s
	# b.element(:css, "footer").wait_until_present
	# puts "Despierta: " + Time.now.to_s
	sleep(5)

	################################
	# COMIENZA OBTENCION DE DATOS
	################################

	# DATOS PRINCIPALES
	puts "DATOS DEL ESTACIONAMIENTO"
	puts "========================="
	puts "\n"

	if b.element(:css, "input[name='idAdvertisement']").exists?
		id = b.element(:css, "input[name='idAdvertisement']").attribute_value("value")
		puts "id: " + id
	end
	if b.element(:css, "span[itemprop='geo']").exists?
		latitude = b.element(:css, "meta[itemprop='latitude']").attribute_value("content")
		longitude = b.element(:css, "meta[itemprop='longitude']").attribute_value("content")
		puts "Latitud: " + latitude
		puts "Longitud: " + longitude
	end
	if b.element(:css, "h1[itemprop='name']").exists?
		name = b.element(:css, "h1[itemprop='name']").text
		puts 'Nombre: ' + name
	end
	if b.element(:css, "[itemprop='streetAddress']").exists?
		address = b.element(:css, "[itemprop='streetAddress']").text
		puts 'Direccion: ' + address
	end
	if b.element(:css, "[itemprop='addressLocality']").exists?
		locality = b.element(:css, "[itemprop='addressLocality']").text
		puts 'Localidad: ' + locality
	end
	if b.element(:css, "[itemprop='telephone']").exists?
		telephone = b.element(:css, "[itemprop='telephone']").text
		puts 'Telefono: ' + telephone
	end
	puts "\n========================="

	# INFORMACION GENERAL
	if b.element(:css, "[itemprop='description']").exists?
		description = b.element(:css, "[itemprop='description']").text
		puts "\nInformacion general:"
		puts "--------------------\n"
		puts description
	end

	# SERVICIOS Y PRODUCTOS
	if b.element(:css, "ul.l-threeCol>li").exists?
		services = Array.new
		i = 1
		while b.element(:css, "ul.l-threeCol>li:nth-child(#{i.to_s})").exists?
			services.push(b.element(:css, "ul.l-threeCol>li:nth-child(#{i.to_s})").text)
			i += 1
		end
		puts "\nServicios y productos:"
		puts "----------------------\n"
		puts services
	end

	# HORARIOS DE ATENCIÓN
	if b.element(:css, "[itemprop='openingHoursSpecification']").exists?
		openingHours = Array.new
		i = 1
		while b.element(:css, "[itemprop='openingHoursSpecification']>div:nth-of-type(#{i.to_s})>[itemprop='dayOfWeek']>p").exists?
			day = b.element(:css, "[itemprop='openingHoursSpecification']>div:nth-of-type(#{i.to_s})>[itemprop='dayOfWeek']>p").text
			opens = b.element(:css, "[itemprop='openingHoursSpecification']>div:nth-of-type(#{i.to_s})>[itemprop='opens']").text
			closes = b.element(:css, "[itemprop='openingHoursSpecification']>div:nth-of-type(#{i.to_s})>[itemprop='closes']").text
			dayHours = day + ": " + opens + " - " + closes

			openingHours.push(dayHours)
			i += 1
		end
		puts "\nHorarios de Atención:"
		puts "---------------------\n"
		puts openingHours
	end

	# FORMAS DE PAGO
	if b.element(:css, "[itemprop='paymentAccepted']").exists?
		paymentMethods = Array.new
		i = 1
		while b.element(:css, "[itemprop='paymentAccepted']:nth-of-type(#{i.to_s})").exists?
			paymentMethods.push(b.element(:css, "[itemprop='paymentAccepted']:nth-of-type(#{i.to_s})").text)
			i += 1
		end
		puts "\nFormas de Pago:"
		puts "---------------\n"
		puts paymentMethods
	end

	# #OTROS
	# if b.element(:css, ".info-row").exists?
	# 	while b.element(:css, "h5.m-bip-content-title").exist?
	# 		titulo = b.element(:css, "h5.m-bip-content-title").text
	# 	end
	# end
	b.back
	sleep(5)
	adIndex +=1
end

puts '========================='

# Aguarda y cierra el navegador
puts 'Cerrando Navegador...'
#sleep(1)
b.close
