# frozen_string_literal: true

admin = User.find_or_initialize_by(email: 'admin@admin.com')
admin.password = 'admin123'
admin.password_confirmation = 'admin123'
admin.role = 'admin'
admin.save!

team_member = User.find_or_initialize_by(email: 'user@user.com')
team_member.password = 'team_member'
team_member.password_confirmation = 'team_member'
team_member.role = 'team_member'
team_member.save!
