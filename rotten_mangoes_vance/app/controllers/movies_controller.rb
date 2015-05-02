class MoviesController < ApplicationController
  
  def index
    search = params[:movie_search]
    runtime = params[:runtime_in_minutes]
    
    if search 
      case runtime 
      when "short"
        @movies = Movie.where("title OR director like ? AND runtime_in_minutes < 90", search)
        binding.pry 
      when "medium"
        @movies = Movie.where("title OR director like ? AND runtime_in_minutes BETWEEN 90 AND 120", search)
      when "long" 
        @movies = Movie.where("title OR director like ? AND runtime_in_minutes > 120", search)
      else 
        raise "unknown runtime" 
      end 
      flash[:success] = "Search complete"
    else
      @movies = Movie.all 
    end 
  end 


  def show 
    @movie = Movie.find(params[:id])
  end


  def new
    @movie = Movie.new
  end


  def edit
    @movie = Movie.find(params[:id])
  end


  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end


  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end


  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end


  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :poster 
    )
  end


end
