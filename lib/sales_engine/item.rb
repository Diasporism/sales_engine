module SalesEngine
  class Item
    attr_reader :id, :name, :description, :unit_price, :merchant_id,
                :created_at, :updated_at

    def initialize(row)
      @id = row[:id].to_i
      @name = row[:name].to_s
      @description = row[:description].to_s
      unit_price = row[:unit_price].to_i.round(3) / 100
      @unit_price = BigDecimal.new(unit_price.to_s)
      @merchant_id = row[:merchant_id].to_i
      @created_at = row[:created_at].to_s
      @updated_at = row[:updated_at].to_s
    end

    def self.build_item(contents)
      @@items = []
      contents.each do |row|
        @@items << Item.new(row)
      end
      @@items.count
    end

    def self.clear
      @@items.clear
    end

    def self.random
      @@items.sample
    end

    def self.find_by_id(id)
      @@items.find {|i| i.id == id}
    end

    def self.find_all_by_id(id)
      @@items.select {|i| i.id == id}
    end

    def self.find_by_name(name)
      @@items.find {|i| i.name.downcase == name.downcase}
    end

    def self.find_all_by_name(name)
      @@items.select {|i| i.name.downcase == name.downcase}
    end

    def self.find_by_description(description)
      @@items.find {|i| i.description == description}
    end

    def self.find_all_by_description(description)
      @@items.select {|i| i.description == description}
    end

    def self.find_by_unit_price(price)
      @@items.find {|i| i.unit_price == price}
    end

    def self.find_all_by_unit_price(price)
      @@items.select { |i| i.unit_price == price}
    end

    def self.find_by_merchant_id(id)
      @@items.find {|i| i.merchant_id == id}
    end

    def self.find_all_by_merchant_id(id)
      @@items.select {|i| i.merchant_id == id}
    end

    def self.find_by_created_at(date)
      @@items.find {|i| i.created_at.downcase == date.downcase}
    end

    def self.find_all_by_created_at(date)
      @@items.select {|i| i.created_at.downcase == date.downcase}
    end

    def self.find_by_updated_at(date)
      @@items.find {|i| i.updated_at.downcase == date.downcase}
    end

    def self.find_all_by_updated_at(date)
      @@items.select {|i| i.updated_at.downcase == date.downcase}
    end

    def invoice_items
      InvoiceItem.find_all_by_item_id(id)
    end

    def merchant
      Merchant.find_by_id(merchant_id)
    end

    def self.rank(array, rank)
      array[0..(rank - 1)].map { |item| Item.find_by_id(item[0]) }
    end

    def self.most_revenue(rank)
      rank = 1 if rank == 0
      transactions = Transaction.get_successful_transaction
      items_rank = InvoiceItem.get_item_revenue(transactions)
      items_rank = items_rank.sort_by {|k, v| v }.reverse
      rank(items_rank, rank)
    end

    def self.most_items(rank)
      rank = 1 if rank == 0
      transactions = Transaction.get_successful_transaction
      items_quantity = InvoiceItem.get_item_quantity(transactions)
      items_rank = items_quantity.sort_by {|k, v| v }.reverse
      rank(items_rank, rank)
    end

    def best_day
      transactions = Transaction.get_successful_transaction
      item = InvoiceItem.return_invoice_items_for_item(id, (transactions))
      dates = InvoiceItem.get_quantity_by_invoice_date(item)
      dates = dates.sort_by {|k, v| v}.reverse.flatten
      dates[0]
    end
  end
end
