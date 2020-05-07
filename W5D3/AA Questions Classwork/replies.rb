require_relative "questions"
require_relative "replies"

class Reply
  attr_accessor :id, :question_id, :parent_id, :user_id, :body


  # @param [Hash] options
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def self.find_by_id(id)
    reply_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    Reply.new(reply_data.first)
  end

  def self.find_by_user_id(user_id)
    reply_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    Reply.new(reply_data.first)
  end

  def self.find_by_question_id(question_id)
    reply_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    reply_data.map {|reply| Reply.new(reply)}
  end

  def author
      User.find_by_id(user_id)
  end

  def question
      Question.find_by_id(question_id)
  end

  def parent_reply
      return nil if self.parent_id.nil?
      Reply.find_by_id(parent_id)
  end

  def child_replies
    reply_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    reply_data.map {|reply| Reply.new(reply)}
  end

  def save
    if id
      QuestionsDatabase.instance.execute(<<-SQL, question_id, parent_id, user_id, body, id)
        UPDATE
          replies
        SET
        question_id = ?, parent_id = ?, user_id = ?, body = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, question_id, parent_id, user_id, body)
        INSERT INTO
        replies (question_id, parent_id, user_id, body)
        VALUES
          (?, ?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

end
