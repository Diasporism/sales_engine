class Parser
  def initialize
    customers_file = CSV.open './data/customers.csv', headers: true, header_converters: :symbol
    merchants_file = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
    invoices_file = CSV.open './data/invoices.csv', headers: true, header_converters: :symbol
    invoice_items_file = CSV.open './data/invoice_items.csv', headers: true, header_converters: :symbol
    transactions_file = CSV.open './data/transactions.csv', headers: true, header_converters: :symbol
    items_file = CSV.open './data/items.csv', headers: true, header_converters: :symbol

    Customer.build_customer(customers_file)
    Merchant.build_merchant(merchants_file)
    Invoice.build_invoice(invoices_file)
    InvoiceItem.build_invoice_item(invoice_items_file)
    Transaction.build_transaction(transactions_file)
    Item.build_item(items_file)
  end
end