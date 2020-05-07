require_relative "questions"
require_relative "replies"
require_relative "question_follows"
require_relative "question_likes"

class User

  attr_accessor :id, :first_name, :last_name
  
  def initialize(options)
    @id = options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def self.find_by_id(id)
    user_data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            users
        WHERE
            id = ?
    SQL

    User.new(user_data.first)
  end

  def self.find_by_name(first_name, last_name)
    user_data = QuestionsDatabase.instance.execute(<<-SQL, first_name, last_name)
        SELECT
            *
        FROM
            users
        WHERE
            first_name = ?
        AND 
            last_name = ?
    SQL

    User.new(user_data.first)
  end

  def authored_questions
      Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        AVG(counter) AS avg_like
      FROM
        (SELECT
          COUNT(question_likes.id) AS counter
        FROM
          (SELECT questions.id 
          FROM 
          questions
          WHERE
          author_id = ?) AS qids
        LEFT JOIN
          question_likes ON qids.id = question_likes.question_id
        GROUP BY
          qids.id)
    SQL
  end

  def save
    if id
      QuestionsDatabase.instance.execute(<<-SQL, first_name, last_name, id)
        UPDATE
          users
        SET
          first_name = ?, last_name = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, first_name, last_name)
        INSERT INTO
          users (first_name, last_name)
        VALUES
          (?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

end
