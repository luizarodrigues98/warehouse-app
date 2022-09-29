class FutureDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !value.nil? && Date.today >= value
      record.errors.add(attribute, "deve ser maior que a data atual.") unless Date.today < value
    end
  end 
end