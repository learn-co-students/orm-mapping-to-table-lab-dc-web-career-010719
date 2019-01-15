class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name, @grade = name, grade
  end

  def self.create_table
    sql = "CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students;"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?,?)"
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid()")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    return student
  end


  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
