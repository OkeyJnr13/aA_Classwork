require 'sqlite3'
require 'singleton'
require_relative "users"
require_relative "replies"
require_relative "question_follows"


class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class Question

    attr_accessor :id, :title, :body, :author_id

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def self.find_by_id(id)
        question_data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL

        Question.new(question_data.first)
    end

    def self.find_by_author_id(author_id)
        question_data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE
                author_id = ?
        SQL

        question_data.map {|question| Question.new(question)}
    end

    def author
        User.find_by_id(author_id)
    end

    def replies
        Reply.find_by_question_id(id)
    end

    def followers
        QuestionFollow.followers_for_question_id(id)
    end

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def likers
        QuestionLike.likers_for_question_id(id)
    end

    def num_likes
        QuestionLike.num_likes_for_question_id(id)
    end

    def self.most_liked(n)
        QuestionLike.most_liked_questions(n)
    end

    def save
        if id
            QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id, id)
                UPDATE
                    questions
                SET
                    title = ?, body = ?, author_id = ?
                WHERE
                    id = ?
            SQL
        else
          QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id)
                INSERT INTO
                    questions (title, body, author_id)
                VALUES
                    (?, ?, ?)
          SQL
          @id = QuestionsDatabase.instance.last_insert_row_id
        end
      end

end

