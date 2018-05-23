class DeletePostsWithoutAuthor < ActiveRecord::Migration[5.2]
  def change
    Article.all.find_in_batches(batch_size: 250).each do |group|
      ActiveRecord::Base.transaction do
        group.each do |article|
          article.destroy if article.author_id.nil?
        end
      end
    end
  end
end
