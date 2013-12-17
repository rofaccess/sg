class DepositoMateriaPrima < Deposito
	#has_many :deposito_stocks
	has_paper_trail meta: {type_subclase: 'DepositoMateriaPrima'}
end
