require_relative '20171127150433_remove_uniq_idx_from_tasks'

class RevertUniqIdxRemoval < ActiveRecord::Migration[5.1]
  def change
    revert RemoveUniqIdxFromTasks
  end
end
