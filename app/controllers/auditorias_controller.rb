class AuditoriasController < ApplicationController
  before_filter :authenticate_user!
  before_action :authorize, only: [:index]
  respond_to :html, :js

  def authorize
    authorize! :manage, :all
  end

  def index
  	@search = PaperTrail::Version.search(params[:q])
  	@logs = @search.result.order('created_at desc').page(params[:page]).per(25)
  end

  def buscar
    index
    render 'index'
  end
end