require "get_home_best/version"
require 'json'
require 'pp'
require 'HTTParty'
require 'mechanize'


module GetHomeBest
  
  def self.journeys start_point=nil, end_point=nil

    raise ArgumentError, "You need to provide a start point" if start_point.nil?
    raise ArgumentError, "You need to provide an end point" if end_point.nil?

    @start_point = start_point.gsub(" ", "%20")
    @end_point = end_point.gsub(" ", "%20")

    response_taxi = pp JSON.parse HTTParty.get("http://maps.googleapis.com/maps/api/directions/json?origin=#{@start_point}&destination=#{@end_point}&sensor=false&mode=driving").response.body
    response_biking = pp JSON.parse HTTParty.get("http://maps.googleapis.com/maps/api/directions/json?origin=#{@start_point}&destination=#{@end_point}&sensor=false&mode=bicycling").response.body
    response_walking = pp JSON.parse HTTParty.get("http://maps.googleapis.com/maps/api/directions/json?origin=#{@start_point}&destination=#{@end_point}&sensor=false&mode=transit&departure_time=#{Time.now.to_i}").response.body
    response_public = pp JSON.parse HTTParty.get("http://maps.googleapis.com/maps/api/directions/json?origin=#{@start_point}&destination=#{@end_point}&sensor=false&mode=walking").response.body
    
    @taxi_distance = response_taxi["routes"][0]["legs"][0]["distance"]["text"][0..-4].to_f

    @time_taxi = response_taxi["routes"][0]["legs"][0]["duration"]["text"]
    @time_biking = response_biking["routes"][0]["legs"][0]["duration"]["text"]
    @time_walking = response_walking["routes"][0]["legs"][0]["duration"]["text"]
    @time_public = response_public["routes"][0]["legs"][0]["duration"]["text"]

    taxi_cost
    {:taxi => @time_taxi, :bike => @time_biking, :walking => @time_walking, :public => @time_public, :taxi_cost => @cost}
  end

  def self.taxi_cost

    agent = Mechanize.new
    page = agent.get("http://www.taxiautofare.com/uk/Default.aspx?LocationID=203&Distance=#{@taxi_distance}&Source=#{@start_point}&Destination=#{@end_point}") 
    @cost = page.title[3..100]

    {:taxi => @taxi_time, :bike => @time_biking, :walking => @time_walking, :public => @time_public, :taxi_cost => @cost}
  end

end
