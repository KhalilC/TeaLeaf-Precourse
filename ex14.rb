contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
contacts = {"Joe Smith" => {}}
titles = [:email, :address, :phone]

contacts.each do |name, hash|
  titles.each do |title|
    hash[title] = contact_data.shift
  end
end

puts contacts




