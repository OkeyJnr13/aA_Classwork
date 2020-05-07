require_relative "users"
require_relative "questions"
require_relative "question_follows"

class QuestionLike
  # @param [Hash] options
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    question_like_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL

    QuestionLike.new(question_like_data.first)
  end

  def self.likers_for_question_id(question_id)
    user_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.first_name, users.last_name
      FROM
        users
      JOIN
        question_likes ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL

    user_data.map { |data| User.new(data) }
  end

  def self.liked_questions_for_user_id(user_id)
    question_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN
        question_likes ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL

    question_data.map { |data| Question.new(data) }
  end  

  def self.num_likes_for_question_id(question_id)
    QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS num_likes
      FROM
        question_likes
      WHERE 
        question_id = ?
    SQL
  end

  def self.most_liked_questions(n)
    question_data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN
        question_likes ON question_likes.question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*)
      LIMIT ?
    SQL

    question_data.map { |data| Question.new(data) }
  end

end
