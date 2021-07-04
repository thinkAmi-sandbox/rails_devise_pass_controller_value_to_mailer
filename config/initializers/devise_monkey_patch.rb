module DeviseMonkeyPatch
  def send_reset_password_instructions(attributes = {})
    # attributesより、Controllerから渡された値を取り出す
    controller_value = attributes.delete :controller_value

    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)

    if recoverable.persisted?
      # attr_accessorとして用意した項目に入れる
      recoverable.controller_value = controller_value

      recoverable.send_reset_password_instructions
    end

    recoverable
  end
end


Devise::Models::Recoverable::ClassMethods.module_eval do
  prepend DeviseMonkeyPatch
end
