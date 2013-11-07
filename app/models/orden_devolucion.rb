class OrdenDevolucion < ActiveRecord::Base

	include Formatter

	protokoll :numero, pattern: '#####'
    paginates_per 15


end
