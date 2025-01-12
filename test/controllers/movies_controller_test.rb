require "test_helper"
require 'pry'

describe MoviesController do
  MOVIE_FIELDS = ['id','inventory','overview','release_date','title']
  
  describe "index" do 
    it "responds with JSON and success" do
      get movies_path
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    it "will give a list of all movies" do
      get movies_path
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal Movie.count
      
      body.each do |movie_hash| 
        # binding.pry
        expect(movie_hash).must_be_instance_of Hash
        expect(movie_hash.keys.sort).must_equal MOVIE_FIELDS
      end 
    end
    
    it "will respond with an empty array when there are no movies" do
      Movie.destroy_all
      
      get movies_path
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end 
  
  describe "show" do 
    it "retrieves one movie" do 
      movie = movies(:m1)
      
      get movie_path(movie.id)
      body = JSON.parse(response.body)
      
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal MOVIE_FIELDS
    end
  end
  
  describe "create" do
    let(:movie_data) {
      { 
        title: "Everything cool", 
        release_date: Date.today, 
        overview: "Best movie ever!", 
        inventory: 4 }
      }
      
      it "responds with created status when request is good" do
        expect{ post movies_path, params: movie_data }.must_differ "Movie.count", 1
        must_respond_with :created
        
        body = JSON.parse(response.body)
        expect(body.keys).must_equal ['id']
      end
      
      it "responds with bad_request when request has no name" do 
        movie_data[:title] = nil 
        
        expect{post movies_path, params: movie_data}.wont_change "Movie.count"
        must_respond_with :bad_request
        
        body = JSON.parse(response.body)
        expect(body['errors'].keys).must_include 'title'
      end 
    end
  end
  