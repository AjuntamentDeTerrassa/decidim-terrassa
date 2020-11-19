require "rails_helper"

RSpec.describe AgeAuthorizationHandler do
  let(:authorizer_class) { AgeAuthorizationHandler }
  let(:component) { double('component') }
  let(:resource) { double('resource', component: true) }

  it 'authorizes with age metadata' do
    authorizer = authorizer_class.new(authorization_for('1970/11/21'), { age: '20' }, component, resource)
    expect(authorizer.authorize).to include(:ok)
  end

  it 'does not authorize the user if the authorization is not present' do
    authorizer_without_authorization = authorizer_class.new(nil, { age: nil }, component, resource)
    expect(authorizer_without_authorization.authorize).to include(:missing)
  end

  describe 'when max_age is present' do
    it 'authorizes if is older that :age and yonger that :max_age' do
      birthdate = 21.years.ago.strftime('%Y/%m/%d')
      authorizer = authorizer_class.new(authorization_for(birthdate), { 'age' => '20', 'max_age' => '22' }, component, resource)
      expect(authorizer.authorize).to include(:ok)
    end

    it 'authorizes if is older that :age and equal that :max_age' do
      birthdate = 22.years.ago.strftime('%Y/%m/%d')
      authorizer = authorizer_class.new(authorization_for(birthdate), { 'age' => '20', 'max_age' => '22' }, component, resource)
      expect(authorizer.authorize).to include(:ok)
    end

    it 'not authorizes if is older of :max_age' do
      birthdate = 23.years.ago.strftime('%Y/%m/%d')
      authorizer = authorizer_class.new(authorization_for(birthdate), { 'age' => '20', 'max_age' => '22' }, component, resource)
      expect(authorizer.authorize).to include(:unauthorized)
    end

    it 'not authorizes if is younger of :age' do
      birthdate = 19.years.ago.strftime('%Y/%m/%d')
      authorizer = authorizer_class.new(authorization_for(birthdate), { 'age' => '20', 'max_age' => '22' }, component, resource)
      expect(authorizer.authorize).to include(:unauthorized)
    end
  end

  def authorization_for(date)
    OpenStruct.new(metadata: { 'birthdate' => date },
                   granted?: true)
  end
end
