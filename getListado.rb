require File.dirname(__FILE__) + '/functions.rb'

# Establece conexion a la BBDD
db = dbCon('localhost', 'root', '', 3306, 'estacionamientos')

# Abre navegador
b = abrirNavegador()

i = 1

while i <= 31 do
	b.goto "http://www.paginasamarillas.com.ar/b/estacionamiento-para-vehiculos/ciudad-de-buenos-aires/p-#{i.to_s}/"

	puts "**** PAGINA #{i.to_s} ****"
	# Captura todos los avisos
	ad = b.elements(:css, "li.business")

	# Recorre cada aviso para extraer información
	ad.each do |a|
		id = a.attribute_value("data-id")
		url = a.attribute_value("data-href")

		puts "id: #{id.to_s} | ficha: #{url}"
		db.query("INSERT INTO estacionamientos.listado_fichas VALUES (NULL, '#{id}', '#{url}')")
	end

	i +=1

end




# Cierra BBDD y Browser
db.close
b.close
