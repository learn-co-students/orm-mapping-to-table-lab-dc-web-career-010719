class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name, @grade, @id = name, grade, id
  end

  def self.create_table
    sql = <<-SQL
    create table students (
      id integer primary key,
      name text,
      grade integer
    );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("drop table students;")
  end

  def save
    sql = <<-SQL
    insert into students (name, grade)
    values(?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("select last_insert_rowid()")[0][0]
  end

  def self.create(name:, grade:)
    new_student = Student.new(name, grade)
    new_student.save
    new_student
  end

end
