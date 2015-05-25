class UsersController < ActionController::Base
	respond_to :html, :js
	
	def edit_latlong
		respond_to do |format|   
			format.json {      # listen for json post request
				@user = User.find(params["id"])
				# puts "abcxyz"
				# puts params
				@user.update(lat: params["lat"], long: params["long"] )
	        	@user.save
			    head :no_content # Send a no response to whoever sent the post.
				
			}
			format.html {
				# Normal form post request (form_for or w.e.)
			}
		end
	end

	def dishes
		@user = User.find(params["id"])
		@dishes = @user.dishes
		respond_to do |format|
	    	format.js
	  	end
	end

	def jsonify
		respond_to do |format|   
			format.json {      # listen for json post request
				@user = User.find(params["id"])
				json = Jsonify::Builder.new(:format => :pretty)
				json.person do
					json.name @user.name
					json.email @user.email
					json.home @user.home
					json.lat @user.lat
					json.long @user.long
					json.id @user.id
				end
				render :json => json.compile!
			}
			format.html {
				# Normal form post request (form_for or w.e.)
			}
		end
	end

	def get_ids
		ids = []
		User.all.each {|u|
			ids.push(u.id)
		}
		respond_to do |format|
			format.json {
				render json: ids.to_json
			}
			format.html {

			}
		end
	end
	
    private
   		def user_params
      		params.require(:user).permit(:id, :name, :email, :home, :password, :lat, :long)
      	end
end