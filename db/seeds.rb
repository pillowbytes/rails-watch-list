require 'httparty'
require 'json'

puts 'Cleaning database...'
Movie.destroy_all

puts 'Fetching 200 movies'
base_url = 'https://tmdb.lewagon.com/movie/top_rated'
total_movies = 0

(1..10).each do |page|
  response = HTTParty.get("#{base_url}?page=#{page}")

  if response.code == 200
    movies = JSON.parse(response.body)['results']

    movies.each do |movie_data|
      Movie.create!(
        title: movie_data['original_title'],
        overview: movie_data['overview'],
        rating: movie_data['vote_average'],
        poster_url: "https://image.tmdb.org/t/p/original#{movie_data['backdrop_path']}"
      )
    end

    total_movies += movies.count
    puts "✅ Page #{page}: Seeded #{movies.count} movies (Total: #{total_movies})"
  else
    puts "❌ Failed to fetch page #{page}: #{response.code} - #{response.message}"
    break
  end
end

puts "[Done] Seeded #{total_movies} movies."
