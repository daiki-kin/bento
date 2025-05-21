class RenameCommentToReviewInPosts < ActiveRecord::Migration[7.2]
  def change
    rename_column :posts, :comment, :review
  end
end
