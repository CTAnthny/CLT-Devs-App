module ProjectsHelper
  # Returns member full name from id
  def print_member(member_id)
    if member_id
      member = Member.find(member_id)
      full_name = "#{member.first_name} " + "#{member.last_name}"
    end
  end
end
