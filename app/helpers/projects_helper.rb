module ProjectsHelper
  # Returns member full name from id
  def print_member(member_id)
    if member_id
      member = Member.find(member_id)
      full_name = "#{member.first_name} " + "#{member.last_name}"
    end
  end

  def print_memberships
    member_string = ""
    @project.members.each do |member|
      member_string << print_member(member.id)
      unless member.equal?(@project.members.last)
        member_string << ", "
      end
    end
    member_string
  end
end
