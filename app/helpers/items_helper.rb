module ItemsHelper
  def count_items(items)
    [].tap do |total|
      items.each do |item|
        total << item.quantity
      end
    end.inject :+
  end
end
