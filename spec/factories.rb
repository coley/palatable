Factory.define :user do |user|
  user.username              "maryjones"
  user.full_name             "Mary Jones"
  user.email                 "maryjones@gmail.com"
  user.password              "foobar12"
  user.password_confirmation "foobar12"
end

Factory.define :bookmark do |bookmark|
  bookmark.url              "http://www.google.com"
  bookmark.name             "Google"
  bookmark.date_saved       "2012-02-25 03:20:12"
end