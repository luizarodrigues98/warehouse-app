class FutureDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "deve ser maior ou igual a data atual.") unless Date.today <= value
  end
end