module OrdersHelper
  GST_RATE = 0.05

  def self.create_order(params, user)
    customer = Customer.find_by_user_id(user.id)

    address = params[:currentAddress]

    selected_addresses = customer.addresses.select do |a|
      a.address1 == address[:address1] &&
      a.address2 == address[:address2] &&
      a.city == address[:city] &&
      a.province.name == address[:province] &&
      a.postal_code == address[:postalCode]
    end

    selected_address = selected_addresses.first

    if selected_address == nil then
      selected_address = Address.create(
        address1: address[:address1],
        address2: address[:address2],
        city: address[:city],
        province: Province.find_by_name(address[:province]),
        postal_code: address[:postalCode],
        customer_id: params[:saveAddress] ? customer.id : nil
      )
    end

    order = Order.create(
      customer_id: customer.id,
      status: 'pending',
      address: selected_address
    )

    pst_rate = selected_address.province.tax_rate
    tax_code = selected_address.province.tax_code

    line_items = params[:cart][:items].map do |line_item|
      case line_item[:type]
      when 'Photo'
        item = Photo.find_by_id(line_item[:id])
      when 'Package'
        item = Package.find_by_id(line_item[:id])
      end

      pst = pst_rate * item.value * line_item[:qty]
      gst = GST_RATE * item.value * line_item[:qty]

      item = LineItem.create(
        order: order,
        item_type: line_item[:type],
        item_id: line_item[:id],
        quantity: line_item[:qty],
        value: item.value,
        taxable: true
      )

      Tax.create(
        line_item: item,
        code: tax_code,
        rate: pst_rate,
        amount: pst.round
      )

      Tax.create(
        line_item: item,
        code: 'G',
        rate: GST_RATE,
        amount: gst.round
      )
    end

    order
  end
end