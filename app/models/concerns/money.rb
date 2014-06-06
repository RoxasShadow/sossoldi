module Money
  include CurrencyHelper
  extend ActiveSupport::Concern

  included do
    column_names.each do |attribute|
      if column_types[attribute].type == :float
        define_method("print_#{attribute}".to_sym) do
          pretty_money_printing send(attribute), (currency rescue account.currency)
        end
      end
    end
  end
end