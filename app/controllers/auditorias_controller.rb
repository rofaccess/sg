class AuditoriasController < ApplicationController
  before_filter :authenticate_user!
  before_action :authorize, only: [:index]
  respond_to :html, :js

  def authorize
    authorize! :manage, :all
  end

  def index
    if defined? params[:q][:item_type_eq]
      if params[:q][:item_type_eq] == 'Empleado'
        params[:q][:item_type_eq] = ""
        params[:q] = params[:q].merge(type_subclase_eq: "Empleado")
      elsif params[:q][:item_type_eq] == 'Proveedor'
        params[:q][:item_type_eq] = ""
        params[:q] = params[:q].merge(type_subclase_eq: "Proveedor")
      end
    end
  	@search = PaperTrail::Version.search(params[:q])
  	@logs = @search.result.order('created_at desc').page(params[:page]).per(25)
  end

  def buscar
    index
    render 'index'
  end

  def detalles
    if params[:model][:model] == 'Persona'
      @partial_show = params[:model][:type_subclase].underscore + '_detalles'
    else
      @partial_show = params[:model][:model].underscore + '_detalles'
    end
    @version = PaperTrail::Version.find(params[:id])
    @model = params[:model][:model].constantize.with_deleted.find(params[:model][:id]).version_at(params[:model][:created_at])
  end
end