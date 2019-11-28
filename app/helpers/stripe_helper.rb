module StripeHelper
  GST_RATE = 0.05

  def self.get_stripe_session(params)
    Stripe.api_key = Rails.application.credentials.dig(:DEVELOPMENT_STRIPE_SECRET_KEY)

    pst = 0.0
    gst = 0.0

    province = Province.where(id: params[:provinceId]).first
    pst_rate = province.tax_rate

    line_items = params[:cart][:items].map do |line_item|
      photo = Photo.where(id: line_item[:id]).first

      pst = pst + (pst_rate * photo.value)
      gst = gst + (GST_RATE * photo.value)

      item = {
        name: 'Photo resource',
        description: photo.description,
        amount: photo.value,
        currency: 'cad',
        quantity: line_item[:qty]
      }
    end

    if pst > 0 then
      tax_line_item = {
        name: "#{province.tax_code}ST",
        amount: pst.to_i,
        quantity: 1,
        currency: 'cad'
      }

      line_items.push tax_line_item
    end

    if province.tax_code != 'H' then
      gst_line_item = {
        name: "GST",
        amount: gst.to_i,
        quantity: 1,
        currency: 'cad'
      }

      line_items.push gst_line_item
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      success_url: "http://localhost:8080/payment_success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "http://localhost:8080/payment_error?session_id={CHECKOUT_SESSION_ID}"
    )
  end
end