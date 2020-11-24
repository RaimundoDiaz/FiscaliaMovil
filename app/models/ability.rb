# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    #If the user is a prosecutor:
    if user.prosecutor.present? and user.admin == false
      #Procedures
      #Can manage all procedures of local_prosecution
      can :manage, Procedure, local_prosecution_in_charge: user.prosecutor.local_prosecution
      #Except the drafts made by other prosecutors of the same local_prosecution
      cannot :manage, Procedure do |pro|
        (pro.state == "Draft" && pro.creator_id != user.id)
      end
      #Messages
      can [:create,:read], Message do |msg|
        Procedure.find(msg.procedure_id).local_prosecution_in_charge.id == user.prosecutor.local_prosecution.id
      end

    #If the user is a policeman:
    elsif user.police_unit.present? and user.admin == false
      #Can manage all procedures of police_unit
      can :manage, Procedure, police_unit_in_charge: user.police_unit
      #Except the drafts made by other policemen of the same police_unit
      cannot :manage, Procedure do |pro|
        (pro.state == "Draft" && pro.creator_id != user.id)
      end
      #Messages
      can [:create,:read], Message do |msg|
        Procedure.find(msg.procedure_id).police_unit_in_charge.id == user.police_unit.id
      end

    #Local Prosecution admin
    elsif user.admin == true and user.local_prosecution.present?
      can :read, Procedure
      can :manage, Prosecutor, local_prosecution: user.local_prosecution
      can :manage, User
      can :manage, LocalProsecution, id: user.local_prosecution.id

    #Police Unit admin
    elsif user.admin == true and user.police_unit.present?
      can :read, Procedure
      can :manage, PoliceMan
      can :manage, User
      can :manage, PoliceUnit, id: user.police_unit.id


      #If neither of them the it must be an national admin
    elsif user.admin == true and user.local_prosecution.nil? and user.police_unit.nil?
      can :manage, :all
    end
  end
end
