class TaskPolicy < ApplicationPolicy
  attr_reader :user, :task

  def initialize(user, task)
    @user = user
    @task = task
  end

  def create?
    user.admin? || user.project_manager? || user
  end

  def update?
    user.admin? || user.project_manager? || task.user == user
  end

  def destroy?
    user.admin? || user.project_manager? || task.user == user
  end
end
