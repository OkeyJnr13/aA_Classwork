require_relative "users"
require_relative "questions"

class QuestionFollow

  attr_accessor :id, :question_id, :user_id

  # @param [Hash] options
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end


  def self.find_by_id(id)
    question_follow_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL

    QuestionFollow.new(question_follow_data.first)
  end

  def self.followers_for_question_id(question_id)
    user_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.first_name, users.last_name
      FROM
        users
      JOIN
        question_follows ON question_follows.user_id = users.id
      WHERE
        question_follows.question_id = ?
    SQL

    user_data.map { |data| User.new(data) }
  end

  def self.followed_questions_for_user_id(user_id)
    question_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL

    question_data.map { |data| Question.new(data) }
  end  

  def self.most_followed_questions(n)
    question_data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*)
      LIMIT ?
    SQL

    question_data.map { |data| Question.new(data) }
  end
end
