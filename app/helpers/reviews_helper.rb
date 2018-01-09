module ReviewsHelper
  def individaul_rating(review)
    total_rating = review.comp_rating + review.comm_rating + review.wyr_rating
    average_rating = total_rating/3.to_f
    average_rating.round(2)
  end

  # def final_rating
  #   y = 0
  #   current_user.reviews.each do |review|
  #     y += individaul_rating(review)
  #   end

  # end
end
