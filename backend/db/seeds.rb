require 'faker'

Form.destroy_all

5.times do |i|
  form = Form.create(title: Faker::Name.title)
  number_of_rows = Random.new.rand(1..5)
  number_of_rows.times do |i|
    number_of_option = Random.new.rand(1..5)
    options = (1..number_of_option).map{ |i| { id:SecureRandom.hex , value: Faker::Hipster.word } }
    Row.create(form: form, options: options)
  end
end
