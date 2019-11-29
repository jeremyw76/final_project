module OrdersHelper
  GST_RATE = 0.05
  ###### REMOVE THIS!!!!!
  @current_user = User.where(id: 25).first

  def self.create_order(params)
    ####### REMOVE THIS!!!!!!
    current_user = @current_user
    customer = Customer.find_by_user_id(current_user.id)

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
        province: Province.find_by_name(address:province),
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
    pst = 0
    gst = 0

    line_items = params[:cart][:items].map do |line_item|
      case line_item[:type]
      when 'Photo'
        item = Photo.find_by_id(line_item[:id])
      when 'Package'
        item = Package.find_by_id(line_item[:id])
      end

      pst = pst + (pst_rate * item.value)
      gst = gst + (GST_RATE * item.value)

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
        amount: pst
      )

      Tax.create(
        line_item: item,
        code: 'G',
        rate: GST_RATE,
        amount: gst
      )
    end

    order
  end

  # t.bigint "line_item_id", null: false
  #   t.string "code"
  #   t.decimal "rate", precision: 3, scale: 2
  #   t.integer "amount"

  # t.bigint "order_id", null: false
  #   t.string "item_type", null: false
  #   t.bigint "item_id", null: false
  #   t.integer "quantity"
  #   t.integer "value"
  #   t.boolean "taxable"

  # params = {
  #   "cart"=>{
  #     "items"=>[
  #       {"type"=>"Photo", "id"=>4, "qty"=>1},
  #       {"type"=>"Photo", "id"=>2, "qty"=>1}
  #     ]},
  #   "currentAddress"=>{
  #     "address1"=>"Box 623",
  #     "address2"=>nil,
  #     "city"=>"Kerrobert",
  #     "province"=>"Nunavut",
  #     "country"=>"Canada",
  #     "postalCode"=>"S0L 1R0"
  #   },
  #   "provinceId"=>8,
  #   "saveAddress"=>true,
  #   "payment"=>{}}
end