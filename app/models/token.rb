class Token < ApplicationRecord
    before_create :create_token
    def create_token
        self.value=SecureRandom.hex
        self.expired_at=24.hours.from_now
    end
end
