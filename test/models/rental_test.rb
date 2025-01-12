require "test_helper"


describe Rental do
  let (:rental) {rentals(:r1)}
  
  describe "validations" do
    
    it "is valid with all fields present and valid" do
      expect(rental.valid?).must_equal true
    end
    
    it "is invalid without a customer_id" do
      rental.customer_id = nil
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :customer_id
    end
    
    it 'is invalid without a customer_id' do
      rental.customer_id = nil
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :customer_id
    end
    
    it 'is invalid without movie_id' do
      rental.movie_id = nil
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :movie_id
    end
    
    it 'is invalid when movie_id is not the right datatype' do
      rental.movie_id = nil
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :movie_id
    end 
  end
  
  before do 
    rental = rentals(:r1)
  end
  
  describe "relations" do
    it "belongs to one customer" do
      expect(rental).must_respond_to :customer
      expect(rental.customer).must_be_instance_of Customer
    end    
    
    it "belongs to one movie" do
      expect(rental).must_respond_to :movie
      expect(rental.movie).must_be_instance_of Movie
    end    
  end
end

