class ShippingAddress < ApplicationRecord
    belongs_to :customer
    
    def full_shipping_address
        self.postcode + self.address + self.name
    end
end
