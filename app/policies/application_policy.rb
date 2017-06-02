class ApplicationPolicy
  attr_reader :user, :record

  delegate :session, to: :context

  def initialize(user, record)
    @user = user
    @record = record
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    def resolve
      scope
    end
  end
end
