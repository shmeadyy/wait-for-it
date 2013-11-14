require 'spec_helper'

describe Guest do
  it { should have_many(:reservations) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :name }
  it { should validate_presence_of :password }
  it { should validate_uniqueness_of :email }
  it { should have_secure_password }

  it { should_not allow_value("blah").for(:email) }
  it { should allow_value("blah@email.com").for(:email) }
  it { should_not allow_value("000").for(:phone_number) }
  it { should allow_value("555-555-5555").for(:phone_number) }
end