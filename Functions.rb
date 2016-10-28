require 'watir'



##################
# Abrir_Navegador
##################
def Abrir_Navegador()
	browser = Watir::Browser.new :firefox
  browser.goto 'http://www.paginasamarillas.com.ar/b/estacionamiento-para-vehiculos/ciudad-de-buenos-aires/p-1/'

  browser
end
