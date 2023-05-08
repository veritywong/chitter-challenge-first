require_relative './post'

class PostRepository

    def all
        posts = []

        sql = 'SELECT id, peep, time, user_id FROM posts;'
        result_set = DatabaseConnection.exec_params(sql, [])

        result_set.each do |record|
          post = Post.new
          post.id = record['id']
          post.peep = record['peep']
          post.time = record['time']
          post.user_id = record['user_id']
          
          posts << post
        end
    
        return posts
    end

    def create(post)
        sql = 'INSERT INTO posts (peep, time, user_id) VALUES ($1, $2, $3);'
        result_set = DatabaseConnection.exec_params(sql, [post.peep, post.time, post.user_id])
    
        return post
      end
end