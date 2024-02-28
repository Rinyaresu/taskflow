class ProjectPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def create?
    user.admin? || user.project_manager?
  end

  def update?
    user.admin? || user.project_manager?
  end

  def destroy?
    user.admin?
  end
end
