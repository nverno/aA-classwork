#!/usr/bin/env ruby
# frozen_string_literal: true

require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton
    
    def initialize
        super('../questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
    
end

class User
    attr_accessor :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| User.new(datum) }
    end

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            users
        WHERE
            id = ?
        SQL
        return nil unless user.length > 0
        User.new(user.first)
    end

    def self.find_by_name(fname, lname)
        user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT
            *
        FROM
            users
        WHERE
            (fname = ? AND lname = ?)
        SQL
        return nil unless user.length > 0
        User.new(user.first)
    end

    def followed_questions
        QuestionFollows.followed_questions_for_user_id(@id)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def create
    raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
            INSERT INTO
                users (fname, lname)
            VALUES
                (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def authored_questions
        a_questions = Question.find_by_author_id(@id)
    end

    def authored_replies
        a_replies = Replies.find_by_user_id(@id)
    end
end

class Question
    attr_accessor :title, :body, :aa_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Question.new(datum) }
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            questions
        WHERE
            id = ?
        SQL
        return nil unless question.length > 0
        Question.new(question.first)
    end

    def self.find_by_q(title, body)
        q = QuestionsDatabase.instance.execute(<<-SQL, title, body)
        SELECT
            *
        FROM
            questions
        WHERE
            (title = ? AND body = ?)
        SQL
        return nil unless q.length > 0
        Question.new(q.first)
    end

    def self.find_by_author_id(author_id)
        q = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT
            *
        FROM
            questions
        WHERE
            aa_id = ?
        SQL
        q.map {|questions| Questions.new(questions)}
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @aa_id = options['aa_id']
    end

    def followers
        QuestionFollows.followers_for_question_id(@id)
    end

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @aa_id)
            INSERT INTO
                questions (title, body, aa_id)
            VALUES
                (?, ?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def author
        User.find_by_id(@aa_id)
    end

    def replies
        r = Replies.find_by_question_id(@id)
    end
end

class QuestionFollows
    attr_accessor :users_id, :questions_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map { |datum| QuestionFollows.new(datum) }
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            question_follows
        WHERE
            id = ?
        SQL
        return nil unless question.length > 0
        QuestionFollows.new(question.first)
    end

    def self.followers_for_question_id(question_id)        
        users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                users.id, fname, lname
            FROM
                users
            JOIN 
                question_follows ON users_id = users.id
            JOIN
                questions ON questions_id = questions.id
            WHERE
                questions.id = ?
        SQL
        users.map {|u| User.new(u) }
    end

    def self.followed_questions_for_user_id(usr_id)        
        questions = QuestionsDatabase.instance.execute(<<-SQL, usr_id)
            SELECT
                questions.id, title, body, aa_id
            FROM
                users
            JOIN 
                question_follows ON users_id = users.id
            JOIN
                questions ON questions_id = questions.id
            WHERE
                users.id = ?
        SQL
        questions.map {|q| Question.new(q) }
    end

    def initialize(options)
        @id = options['id']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end

    def self.most_followed_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT
            questions.id, body, title, aa_id, COUNT(*) AS c
        FROM
            users
        JOIN
            question_follows ON users_id = users.id
        JOIN
            questions ON questions_id = questions.id
        GROUP BY
            questions.id
        ORDER BY c DESC
        LIMIT ?
        SQL
        questions.map {|q| Question.new(q)}
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @users_id, @questions_id)
            INSERT INTO
                question_follows (users_id, questions_id)
            VALUES
                (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end
end

class Replies
    attr_accessor :body, :users_id, :questions_id, :parent_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map { |datum| Replies.new(datum) }
    end

    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            replies
        WHERE
            id = ?
        SQL
        return nil unless reply.length > 0
        Replies.new(reply.first)
    end

    def self.find_by_user_id(usr_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, usr_id)
        SELECT
            *
        FROM
            replies
        WHERE
            users_id = ?
        SQL
        reply.map {|reply| Replies.new(reply)}
    end

    def self.find_by_question_id(question_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            *
        FROM
            replies
        WHERE
            questions_id = ?
        SQL
        reply.map {|reply| Replies.new(reply)}
    end

    def initialize(options)
        @id = options['id']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
        @parent_id = options['parent_id']
        @body = options['body']
    end

    def author
        User.find_by_user_id(@users_id)
    end

    def question
        Question.find_by_id(@questions_id)
    end

    def parent_reply
        Replies.find_by_id(@parent_id)
    end

    def child_replies
        # @parent_id == @id
        children = QuestionsDatabase.instance.execute(<<-SQL, @id)
        SELECT
            *
        FROM
            replies
        WHERE
            parent_id = ?
        SQL
        children.map { |child| Replies.new(child) }
    end
    
    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @users_id, @questions_id, @parent_id, @body)
            INSERT INTO
                replies (users_id, questions_id, parent_id, body)
            VALUES
                (?, ?, ?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end
end

class QuestionLikes
    attr_accessor :users_id, :questions_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map { |datum| QuestionLikes.new(datum) }
    end

    def self.find_by_id(id)
        likes = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            question_likes
        WHERE
            id = ?
        SQL
        return nil unless likes.length > 0
        QuestionLikes.new(likes.first)
    end

    def initialize(options)
        @id = options['id']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @users_id, @questions_id)
            INSERT INTO
                question_likes (users_id, questions_id)
            VALUES
                (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end
end