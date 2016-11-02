require File.dirname(__FILE__) + '/functions.rb'

# Establece conexion a la BBDD
db = dbCon('localhost', 'root', '', 3306, 'estacionamientos')

# Abre navegador
b = abrirNavegador()

i = 618

while i <= 757 do
	qry = db.query("SELECT ficha FROM estacionamientos.listado_fichas WHERE db_id = #{i.to_s}")
	url = qry.first['ficha']
	puts "*** PÁGINA #{i.to_s} DE 757 ***"
	puts url
	b.goto url

	# DATOS PRINCIPALES
	if b.element(:css => "input.idAdvertisement").exists?
		id = b.element(:css => "input.idAdvertisement").value
	end
	if b.element(:css => "span[itemprop='geo']").exists?
		geo_lat = b.element(:css => "meta[itemprop='latitude']").attribute_value("content")
		geo_lon = b.element(:css => "meta[itemprop='longitude']").attribute_value("content")
	end
	if b.element(:css => "h1[itemprop='name']").exists?
		nombre = db.escape(b.element(:css => "h1[itemprop='name']").text)
	end
	if b.element(:css => "p.info-row>span[itemprop='streetAddress']").exists?
		direccion = db.escape(b.element(:css => "p.info-row>span[itemprop='streetAddress']").text)
	end
	if b.element(:css => "p.info-row>span[itemprop='addressLocality']").exists?
		localidad = db.escape(b.element(:css => "p.info-row>span[itemprop='addressLocality']").text)
	end
	if b.element(:css => "p.info-row>span[itemprop='telephone']").exists?
		telefono = b.element(:css => "p.info-row>span[itemprop='telephone']").text
	end

	# # INFORMACION GENERAL
	# if b.element(:css, "[itemprop='description']").exists?
	# 	description = b.element(:css, "[itemprop='description']").text
	# end

	# # SERVICIOS Y PRODUCTOS
	# if b.element(:css, "ul.l-threeCol>li").exists?
	# 	services = Array.new
	# 	i = 1
	# 	while b.element(:css, "ul.l-threeCol>li:nth-child(#{i.to_s})").exists?
	# 		services.push(b.element(:css, "ul.l-threeCol>li:nth-child(#{i.to_s})").text)
	# 		i += 1
	# 	end
	# end

	# # HORARIOS DE ATENCIÓN
	# if b.element(:css, "[itemprop='openingHoursSpecification']").exists?
	# 	openingHours = Array.new
	# 	i = 1
	# 	while b.element(:css, "[itemprop='openingHoursSpecification']>div:nth-of-type(#{i.to_s})>[itemprop='dayOfWeek']>p").exists?
	# 		day = b.element(:css, "[itemprop='openingHoursSpecification']>div:nth-of-type(#{i.to_s})>[itemprop='dayOfWeek']>p").text
	# 		opens = b.element(:css, "[itemprop='openingHoursSpecification']>div:nth-of-type(#{i.to_s})>[itemprop='opens']").text
	# 		closes = b.element(:css, "[itemprop='openingHoursSpecification']>div:nth-of-type(#{i.to_s})>[itemprop='closes']").text
	# 		dayHours = day + ": " + opens + " - " + closes
	#
	# 		openingHours.push(dayHours)
	# 		i += 1
	# 	end
	# end

	# # FORMAS DE PAGO
	# if b.element(:css, "[itemprop='paymentAccepted']").exists?
	# 	paymentMethods = Array.new
	# 	i = 1
	# 	while b.element(:css, "[itemprop='paymentAccepted']:nth-of-type(#{i.to_s})").exists?
	# 		paymentMethods.push(b.element(:css, "[itemprop='paymentAccepted']:nth-of-type(#{i.to_s})").text)
	# 		i += 1
	# 	end
	# end

	puts "id: #{id.to_s}"
	puts "Lat: #{geo_lat} | Lon: #{geo_lon}"
	puts "Nombre: #{nombre}"
	puts "Direccion: #{direccion}"
	puts "Localidad: #{localidad}"
	puts "Telefono: #{telefono}"

	db.query("INSERT INTO estacionamientos.estacionamiento VALUES(#{id}, '#{geo_lat}', '#{geo_lon}', '#{nombre}', '#{direccion}', '#{localidad}', '#{telefono}', NULL, NULL, NULL, NULL)")

	# Incrementa hacia la siguiente página.
	i +=1

end




# Cierra BBDD y Browser
db.close
b.close
