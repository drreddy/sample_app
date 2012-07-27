class User
  attr_accessor :name, :email

  def initialize(attributes = {})
    @name  = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end

end

def string_shuffle(s)
  s.split('').shuffle.join
end

def string_reverse(q)
  q.reverse
end

def password_generator(r)
  pass=('a'..'z').to_a.shuffle(0..8).join
  puts "the password generated for '#{r}' is '#{pass}' ."
end