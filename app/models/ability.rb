class Ability
  include CanCan::Ability
  def initialize(user)
    # En application_controller se hace la misma consulta en @rol, pero
    # aqui tengo que hacerlo de vuelta porque no me lo toma
    @rol = Interfaz.get_interfaces_secciones(user)
    if @rol[:interfaces].include?("Pedidos de Compra")
      can :manage, PedidoCompra
    end 
    if @rol[:interfaces].include?('Pedidos de Cotizacion')
      can :manage, PedidoCotizacion
    end 
    if @rol[:interfaces].include?('Ordenes de Compra')
      can :manage, OrdenCompra
    end 
    if @rol[:interfaces].include?('Facturas Recibidas')
      can :manage, FacturaCompra
    end 
    if @rol[:interfaces].include?('Devoluciones')
      can :manage, OrdenDevolucion
    end 
    if @rol[:interfaces].include?('Notas de Credito')
      can :manage, NotaCreditoCompra
    end 
    if @rol[:interfaces].include?('Notas de Debito')
      can :manage, NotaDebitoCompra
    end 
    if @rol[:interfaces].include?('Proveedores')
      can :manage, Proveedor
    end  

    if @rol[:interfaces].include?('Depositos')
      can :manage, Deposito
    end  
    if @rol[:interfaces].include?('Componentes')
      can :manage, Componente
    end  
    if @rol[:interfaces].include?('Marcas')
      can :manage, Marca
    end  
    if @rol[:interfaces].include?('Categorias')
      can :manage, ComponenteCategoria
    end  

    if @rol[:interfaces].include?('Asientos Contables')
      can :manage, AsientoContable
    end  
    if @rol[:interfaces].include?('Asientos Modelo')
      can :manage, AsientoModelo
    end  
    if @rol[:interfaces].include?('Cuentas Contables')
      can :manage, CuentaContable
    end  

    if @rol[:interfaces].include?('Datos de la Empresa')
      can :manage, Configuracion
    end 
    if @rol[:interfaces].include?('Localidades')
      # No se como hacer referencia
    end
    if @rol[:interfaces].include?('Facturacion')
      # No se como hacer referencia
    end
    if @rol[:interfaces].include?('Usuarios')
      can :manage, User
    end 
    if @rol[:interfaces].include?('Roles')
      can :manage, Role
    end
    if @rol[:interfaces].include?('Auditoria')
      # No se como hacer referencia
    end   
       

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
