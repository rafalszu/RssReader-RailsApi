RailsApiAuth.tap do |raa|
  raa.user_model_relation = :user

  raa.force_ssl = Rails.env.production?
end
