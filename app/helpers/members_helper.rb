module MembersHelper
	
	def state_label(state)
	  	case state.to_s
	    	when "complete"
	      		"success"
	    	when "pending"
	      		"warning"
	      	when "failed"
	      		"important"
	      	when "chargedback"
	      		"important"
	      	when "refunded"
	      		"info"
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
