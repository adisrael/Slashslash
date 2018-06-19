class SpotifyApi
	include HTTParty
	base_uri 'https://api.spotify.com/v1'

	def initialize
		# Client credential flow
		credentials = "#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}"
		auth = Base64.encode64(credentials).gsub("\n", "")

		response = self.class.post( #HTTParty.post(
			'https://accounts.spotify.com/api/token',
			{
				headers: {
					'Authorization' => 'Basic #{auth}'
				},
				body:{
					grant_type: 'client_credentials'
				}
			}
		)
		@token = response['access_token']
	end


	def auth_header
		{
			'Authorization' => "Bearer #{@token}"
		}
	end

	def search_artist(name)
		self.class.get(
			'/search?q=#{name}&type=artist',
			{
				headers: auth_header
			}
		)
	end

end
