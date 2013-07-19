class User < ActiveRecord::Base
    acts_as_authentic

    has_private_messages
end
