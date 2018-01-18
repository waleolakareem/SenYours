module ReviewsHelper
  def individaul_rating(review)
    # Add up all the ratings of a review and round it to two
    total_rating = review.comp_rating + review.comm_rating + review.wyr_rating
    average_rating = total_rating/3.to_f
    average_rating.round(2)
  end

  def final_rating(user)
    # Add up all review and divide it by the total count
    collector = 0
    user.reviews.each do |review|
      collector += individaul_rating(review)
    end
    rating = collector/user.reviews.count.to_f
    rating.round(2)
  end

  def wyr(user)
    collector = 0
    user.reviews.each do |review|
      collector += review.wyr_rating
    end
    avr_wyr = collector/user.reviews.count
    avr_wyr
  end

  def comp_rate(user)
  collector = 0
  user.reviews.each do |review|
    collector += review.comp_rating
  end
  avr_comp_rate = collector/user.reviews.count
  avr_comp_rate
  end

  def comm_rate(user)
  collector = 0
  user.reviews.each do |review|
    collector += review.comm_rating
  end
  avr_comm_rate = collector/user.reviews.count
  avr_comm_rate
  end
end
