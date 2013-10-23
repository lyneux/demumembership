module MembersHelper
	
	def state_label(state)
	  	case state.to_s
	    	when "complete"
	      		"success"
	    	when "pending"
	      		"warning"
	    	else
	      		"default"
	    end
	end

	def membership_state_label(state)
	  	case state.to_s
	    	when "live"
	      		"success"
	    	when "expired"
	      		"warning"
	      	when "quit"
	      		"important"
	    	else
	      		"default"
	    end
	end

end
