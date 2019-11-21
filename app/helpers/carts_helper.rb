module CartsHelper
  def self.update(session_id, items, new_session_id = nil)
    cart = Cart.where(session_id: session_id).first_or_create


  end
end
