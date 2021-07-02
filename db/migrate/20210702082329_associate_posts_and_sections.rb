class AssociatePostsAndSections < ActiveRecord::Migration[6.1]
  def change
    add_reference :sections, :post, foreign_key: true
    add_reference :posts, :section, foreign_key: true
  end
end
