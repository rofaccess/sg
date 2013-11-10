class Empleado < Persona
	has_one :user

	def nombre_completo
		self.nombre + " " + self.apellido
	end
end
