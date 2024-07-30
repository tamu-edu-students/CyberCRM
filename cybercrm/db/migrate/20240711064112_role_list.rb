class RoleList < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role_list, :string, array: true, default: ['student_worker']

    # Migrate existing user roles to the new array column
    User.reset_column_information
    User.find_each do |user|
      user.update_column(:role_list, [user.role, 'student_worker'])
    end
  end
end
