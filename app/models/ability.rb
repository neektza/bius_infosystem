class Ability
  include CanCan::Ability

  def initialize(member)

    if member.admin?
      can :manage, :all
      can :read, :all
    end

    if member.section_leader?
      can :read, :all
      can :update, Section do |section|
        section.try(:leaders).include? member
      end
    end

    if member.grunt?
      # Members
      can :read, Member
      can :update, Member do |member|
        member.try(:id) == current_member.id
      end

      # Sections
      can :read, Section
      can :read, SectionMembership
      can :apply, SectionMembership

      # Projects
      can :read, Project
      can :read, ProjectParticipation
      can :apply, ProjectParticipation

      can :read, Item
      can :read, Book
      can :read, Loan
    end
  end

end
