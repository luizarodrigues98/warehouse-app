class CnpjValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid_registration_number) unless CNPJ.valid? value
  end
end