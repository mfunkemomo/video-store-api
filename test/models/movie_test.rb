require "test_helper"

describe Movie do
  before do 
    @valid_movie = movies(:m1)
  end
  
  describe "relations" do
    it "can have one or many rentals" do
      @valid_movie.must_respond_to :rentals
      @valid_movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end    
  end

  describe "validations" do 
    describe "title" do 
      it "should validiate movie with title (presence)" do 
        result = @valid_movie.valid?
        expect(result).must_equal true
      end 
  
      it "should not validate movie without title (presence)" do 
        @valid_movie.title = nil 
        result = @valid_movie.valid?
        expect(result).must_equal false
      end 
    end 
    
    describe "release_date" do 
      it "should validiate movie with release_date (presence)" do 
        result = @valid_movie.valid?
        expect(result).must_equal true
      end 
  
      it "should not validate movie without release_date (presence)" do 
        @valid_movie.release_date = nil 
        result = @valid_movie.valid?
        expect(result).must_equal false
      end 
  
      # FOR WHEN WE WANT TO ADD FORMAT VALIDATIONS 
      # it "should validate correct release_date format" do 
      #   result = @valid_movie.valid?
      #   expect(result).must_equal true
      # end
      
      # it "should not validate incorrect release_date format" do 
      #   result = @invalid_release_date_movie.valid?
      #   expect(result).must_equal false
      # end 
    end 
    
    describe "inventory" do 
      it "should validiate movie with inventory (presence)" do 
        result = @valid_movie.valid?
        expect(result).must_equal true
      end 
  
      it "should not validate movie without inventory (presence)" do 
        @valid_movie.inventory = nil 
        result = @valid_movie.valid?
        expect(result).must_equal false
      end 
  
      # FOR WHEN WE WANT TO ADD NUMERICAL VALIDATION 
      # it "should validate inventory with integer" do 
      #   result = @valid_movie.valid?
      #   expect(result).must_equal true
      # end 

      # it "should not validate inventory not with integer" do 
      #   result = @invalid_inventory_movie.valid?
      #   binding.pry
      #   expect(result).must_equal false
      # end 
    end 
  end 
end
