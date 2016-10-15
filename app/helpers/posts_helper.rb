module PostsHelper


      def display_likes(post)
	    votes = post.votes_for.up.by_type(User)
	    return list_likers(votes) if votes.size <= 8
	    count_likers(votes)
      end

	def likers_of(post)
	       votes = post.votes_for.up.by_type(User)
	       usernames = []
	       unless votes.blank?
	           votes.voters.each do |voter|
	           		 usernames.push(link_to voter.username,
	            		profile_path(voter.username),
	            		class: 'user-name')
                   end
                   usernames.to_sentence.html_safe + like_plural(votes)
             end
      end

    def list_likers(votes)
      usernames = []
      unless votes.blank?
        votes.each do |vote|
          usernames.push(link_to vote.voter.username,
                                    profile_path(vote.voter.username),
                                    class: 'user-name')
        end
        usernames.to_sentence.html_safe + like_plural(votes)
      end
    end
    

      def liked_post(post)  
      		 if current_user
	      		return 'glyphicon-thumbs-up' if  current_user.voted_for? post
	  	end 
	      'glyphicon-thumbs-down'
	 end

       private

	 def like_plural(votes)
	   	return ' like this' if votes.count > 1
	      ' likes this'
	 end
end
