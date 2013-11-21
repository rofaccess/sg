class Empleado < Persona
	has_one :user
	acts_as_paranoid

	has_paper_trail meta: {type_subclase: 'Empleado'}

	def nombre_completo
		self.nombre + " " + self.apellido
	end
end
