class PasswordsController < Devise::PasswordsController
	skip_before_filter :require_no_authentication, :only => [ :update]
	private
end