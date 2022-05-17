class ListService

  def initialize(params)
    @params = params
  end

  def call
    insert_todo_in_database
  end

  private

  def insert_todo_in_database 
    Todo.create(title: @params['title'], label:  @params['label'], deadline:  @params['deadline'])
  end

end
