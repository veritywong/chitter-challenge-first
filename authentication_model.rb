# file: lib/user_repository.rb

class UserRepository
    def create(new_user)
      # Encrypt the password to save it into the new database record.
      encrypted_password = BCrypt::Password.create(new_user.password)
  
      sql = '
        INSERT INTO users (email, password)
          VALUES($1, $2);
      '
      sql_params = [
        new_user.email,
        encrypted_password
      ]
    end
  
    def sign_in(email, submitted_password)
      user = find_by_email(email)
  
      return nil if user.nil?
  
      # Compare the submitted password with the encrypted one saved in the database
      stored_password = BCrypt::Password.new(user.password)
      if stored_password == submitted_password
        # login success
        return true
      else
        # wrong password
      end
    end
  
    def find_by_email(email)
      # ...
    end
  end