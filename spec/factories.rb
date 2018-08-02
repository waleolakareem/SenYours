FactoryBot.define do
  factory :companion, class: User do
    first_name "Joe"
    last_name "Companion"
    email "joe@gmail.com"
    password "password"
    dob "1993-01-02"
    identification "Companion"
    phone_number "12025550177"
  end

  factory :senior, class: User do
    first_name "Gladys"
    last_name "Senior"
    email "gladys@gmail.com"
    password "password"
    dob "1930-01-02"
    identification "Senior"
    phone_number "12025550117"
  end

  factory :user do
    first_name "Test"
    last_name "User"
    email "test_user@gmail.com"
    password "password"
    dob "1950-02-05"
    identification "Companion"
    phone_number "12025550197"
  end
end
