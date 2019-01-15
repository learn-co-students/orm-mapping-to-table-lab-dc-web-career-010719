class Student
	attr_reader :id, :name, :grade
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  def initialize(name, grade)
  	@name, @grade = name, grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY, 
      name TEXT,
      grade INTEGER
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    sql = <<-SQL
      SELECT id FROM students WHERE name = (?)
    SQL
    @id = DB[:conn].execute(sql, self.name)[0][0]
  end

  def self.create(student_hash)
    new_stud = Student.new(student_hash[:name], student_hash[:grade])
  	new_stud.save
  	new_stud
  	  # binding.pry
  	
  end
  
end
