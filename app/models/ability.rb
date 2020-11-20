# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    #If the user is a prosecutor
    if user.local_prosecution.present?
      can :manage, Procedure, local_prosecution_in_charge: user.local_prosecution
      can :manage, Message do |msg|
        Procedure.find(msg.procedure_id).local_prosecution_in_charge.id == user.local_prosecution.id
      end
    elsif user.police_unit.present?
      can :manage, Procedure, police_unit_in_charge: user.police_unit
      can [:create,:read], Message, procedure: {police_unit_in_charge: user.police_unit}
    end
  end
end
