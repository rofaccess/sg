class AuditoriasController < ApplicationController
  before_filter :authenticate_user!
  #before_action :authorize, only: [:index]
  respond_to :html, :js

  def authorize
    authorize! :manage, :all
  end

  def index
    resultados_auditorias(true)
  end

  def resultados_auditorias(paginate)
    if defined? params[:q][:item_type_eq]
      if params[:q][:item_type_eq] == 'Empleado'
        params[:q][:item_type_eq] = ""
        params[:q] = params[:q].merge(type_subclase_eq: "Empleado")
      elsif params[:q][:item_type_eq] == 'Proveedor'
        params[:q][:item_type_eq] = ""
        params[:q] = params[:q].merge(type_subclase_eq: "Proveedor")
      elsif params[:q][:item_type_eq] == 'Componente'
        params[:q][:item_type_eq] = ""
        params[:q] = params[:q].merge(type_subclase_eq: "Componente")
      elsif params[:q][:item_type_eq] == 'DepositoMateriaPrima'
        params[:q][:item_type_eq] = ""
        params[:q] = params[:q].merge(type_subclase_eq: "DepositoMateriaPrima")
      end
    end
    @search = PaperTrail::Version.search(params[:q])
    @logs = @search.result.order('created_at desc')

    if paginate
      @logs = @logs.page(params[:page]).per(25)
    end

  end

  def imprimir_listado
    resultados_auditorias(false)
    respond_to do |format|
      format.pdf { render :pdf => "auditorias",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end
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