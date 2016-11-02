require 'watir'
require 'mysql2'

##
# Inicia navegador
#
# Retorna instancia browser
def abrirNavegador()
	browser = Watir::Browser.new :firefox

	browser
end


##
# Abre conexion a base de datos
#
# Retorna instancia conexion a base de datos
def dbCon(host, user, pass, port, database)

	@host = host
	@user = user
	@pass = pass
	@port = port
	@database = database

	db = Mysql2::Client.new(
		:host => @host,
		:username => @user,
		:password => @pass,
		:port => @port,
		:database => @database
		)

	db
end
