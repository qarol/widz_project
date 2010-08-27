namespace :db do
  desc 'Recreate role names'
  task(:recreate_role_names => :environment) do
    Role.find_or_create_by_name('admin')
    Role.find_or_create_by_name('student')
    Role.find_or_create_by_name('teacher')
    Role.find_or_create_by_name('parent')
  end
end
