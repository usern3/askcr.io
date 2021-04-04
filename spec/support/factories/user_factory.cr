class UserFactory < Avram::Factory
  def initialize
    email "#{sequence("test-email")}@example.com"
    username sequence("username")
    role User::Role.new(:member)
    encrypted_password Authentic.generate_encrypted_password("password")
  end
end
