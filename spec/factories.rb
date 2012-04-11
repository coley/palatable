Factory.define :user do |user|
  user.username              "maryjones9"
  user.full_name             "Mary Jones"
  user.email                 "maryjones@gmail.com"
  user.password              "foobar12"
  user.password_confirmation "foobar12"
end

Factory.define :bookmark do |bookmark|
  bookmark.url              "http://www.google2.com"
  bookmark.name             "Google2"
  bookmark.user_id          1
end