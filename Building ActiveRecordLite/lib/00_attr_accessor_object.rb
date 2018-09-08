class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
    names.each do |new_method|
      define_method(new_method) do
        instance_variable_get("@#{new_method}")
      end
      define_method("#{new_method}=") do |value|
        instance_variable_set("@#{new_method}", value)
      end
    end

  end
end
