class AddAttachmentToConfiguraciones < ActiveRecord::Migration
  def change
    add_attachment :configuraciones, :imagen
  end
end
