require_relative '../helpers/db_helpers.rb'

describe 'create' do
  it 'creates a new user' do
    customer = Customer.create(email: 'test@example.com' , password: 'password123')
    persisted_data = persisted_data_customers(id: customer.customer_id)
    expect(customer).to be_a Customer
    expect(customer.customer_id).to eq persisted_data['customer_id']
    expect(customer.email).to eq 'test@example.com'

  end

  it 'encrypts the password' do
    expect(BCrypt::Password).to receive(:create).with('password123')
    Customer.create(email: 'test@example.com', password: 'password123')
  end
end

describe '#find' do
  it 'returns the customer object based on email and password' do
    customer = Customer.create(email: 'test@example.com' ,
      password: 'password123')
    found_customer = Customer.find(email: customer.email)
    expect(found_customer.email).to eq customer.email
  end
end
