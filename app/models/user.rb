class User < ActiveRecord::Base
  has_many :questions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable, :omniauth_providers => [:facebook]

  enum role: {guest: 1,member: 2, moderator: 3, admin: 4}

  def feed
    users = followee_ids
    users << id

  end

  def follow_relation user_id
    return UserRelations::SELF if id == user_id
    if FollowMapping.where(:followee_id => user_id, :follower_id => id).length > 0
      return UserRelations::FOLLOWED
    else
      return UserRelations::NOTFOLLOWED
    end
  end

  def can_follow user_id
    return follow_relation(user_id) == UserRelations::NOTFOLLOWED
  end

  def can_unfollow user_id
    return follow_relation(user_id)==UserRelations::FOLLOWED
  end

  def followee_ids
    FollowMapping.where(followee_id: id).pluck(:followee_id)

  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  class UserRelations
    SELF = 0
    FOLLOWED = 1
    NOTFOLLOWED = 2
  end
end
