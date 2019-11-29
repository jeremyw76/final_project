module StripeHelper
  def self.get_stripe_session(order)
    Stripe.api_key = Rails.application.credentials.dig(:DEVELOPMENT_STRIPE_SECRET_KEY)

    pst = 0.0
    gst = 0.0

    line_items = order.line_items.map do |line_item|
      pst = pst + line_item.taxes.where.not(code: 'G').reduce(0) { |sum, tax| sum + tax.amount }
      gst = gst + line_item.taxes.where(code: 'G').reduce(0) { |sum, tax| sum + tax.amount }

      item = {
        name: line_item.item_type,
        description: line_item.item.description,
        amount: line_item.value,
        currency: 'cad',
        quantity: line_item.quantity
      }
    end

    if pst > 0 then
      tax_line_item = {
        name: "#{order.address.province.tax_code}ST",
        amount: pst.to_i,
        quantity: 1,
        currency: 'cad'
      }

      line_items.push tax_line_item
    end

    if order.address.province.tax_code != 'H' then
      gst_line_item = {
        name: "GST",
        amount: gst.to_i,
        quantity: 1,
        currency: 'cad'
      }

      line_items.push gst_line_item
    end

    session = Stripe::Checkout::Session.create(
      client_reference_id: order.id,
      payment_method_types: ['card'],
      line_items: line_items,
      success_url: "http://localhost:8080/payment_success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "http://localhost:8080/payment_error?session_id={CHECKOUT_SESSION_ID}"
    )
  end
end