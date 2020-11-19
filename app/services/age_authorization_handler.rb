# frozen_string_literal: true
class AgeAuthorizationHandler < Decidim::Verifications::DefaultActionAuthorizer
  def missing_fields
    @missing_fields ||= (valid_metadata? ? [] : [:birthdate])
  end

  def unmatched_fields
    @unmatched_fields ||= set_unmatched_fields
  end

  private

  def set_unmatched_fields
    errors = []
    errors << :birthdate unless valid_age?
    errors
  end

  def valid_metadata?
    return unless authorization

    !authorization.metadata['birthdate'].nil?
  end

  def valid_age?
    return age_between?(age, max_age) if options['max_age'].present?
    
    age <= user_age
  end

  def birthdate
    authorization.metadata['birthdate'].to_date
  end

  def age
    options['age'].to_i
  end

  def max_age
    options['max_age'].to_i
  end

  def age_between?(age, max_age)
    (age..max_age).cover?(user_age)
  end

  def user_age
    return nil if birthdate.blank?

    now = Date.current
    extra_year = (now.month > birthdate.month) || (
      now.month == birthdate.month && now.day >= birthdate.day
    )

    now.year - birthdate.year - (extra_year ? 0 : 1)
  end
end

