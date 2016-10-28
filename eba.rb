require File.dirname(__FILE__) + '/Functions.rb'

# Abre navegador y web
# b = Abrir_Navegador(File.dirname(__FILE__))
b = Abrir_Navegador()
puts 'Se abrió el navegador!'

# Selecciona y abre el primer item de la lista
b.element(:css, "li[data-id='ad0']").click

sleep(5)
# Rastrea Datos
if name = b.element(:css, "h1[itemprop='name']").exists?
	name = b.element(:css, "h1[itemprop='name']").text
end
if address = b.element(:css, "span[itemprop='streetAddress']").exists?
	address = b.element(:css, "span[itemprop='streetAddress']").text
end
if locality = b.element(:css, "span[itemprop='addressLocality']").exists?
	locality = b.element(:css, "span[itemprop='addressLocality']").text
end
if telephone = b.element(:css, "span[itemprop='telephone']").exists?
	telephone = b.element(:css, "span[itemprop='telephone']").text
end
if description = b.element(:css, "span[itemprop='description']").exists?
	description = b.element(:css, "span[itemprop='description']").text
end
#services = []


# Imprime los datos
puts 'DATOS DEL ESTACIONAMIENTO'
puts '========================='
puts 'Nombre: ' + name
puts 'Direccion: ' + address
puts 'Localidad: ' + locality
puts 'Telefono: ' + telephone
puts '-------------------------'
#puts 'Informacion general: ' + description


# Aguarda y cierra el navegador
puts 'Cerrando Navegador...'
sleep(3)
b.close
