class TodosController < ApplicationController
    before_action :authenticate_user!
	before_action :find_todo, :only => [:show,:edit, :update, :destroy]

	def index
    if params[:type].present?
      @todos = Todo.order(:created_at => "#{params[:type]}")
    elsif params[:filter].present? and params[:filter] == "all"
      @todos = Todo.all
    elsif params[:filter].present? and params[:filter] == "completed"
      @todos = Todo.where(:status => "completed")
    elsif params[:filter].present? and params[:filter] == "upcoming"
      @todos = Todo.where("completion_time >?", Time.now)       
    else
      @todos = Todo.all
    end
	end
   
  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    respond_to do |format|
      if @todo.save
      	format.html{redirect_to todos_path, :notice => "Todo was successfully created"}
      	format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  def update
    if params[:status].present?  and params[:manual_approve].present? and params[:manual_approve] == "true"
      @todo.perform_event(params[:status])
      redirect_to todos_path
    else 
      respond_to do |format|
      	if @todo.update_attributes(todo_params)
      		format.html{redirect_to todos_path, :notice => "Todo was successfully updated."}
      		format.json {render :show, status: :created, location: @todo }
      	else
      		format.html {render :new}
      		format.json {render json:@todo.errors, status: :unprocessable_entity}
      	end
      end
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path
  end

  private
  def todo_params
  	params.require(:todo).permit!
  end

  def find_todo
  	@todo = Todo.find(params[:id])
  end
end
