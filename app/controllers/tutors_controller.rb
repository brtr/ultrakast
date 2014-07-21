class TutorsController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!

  def index
    @tutors = Tutor.all

    respond_with @tutors
  end

  def show
    @tutor = Tutor.find(params[:id])

    respond_with @tutor 
  end

  def new
    @tutor = Tutor.new

    respond_with @tutor
  end

  def edit
    @tutor = Tutor.find(params[:id])
  end

  def create
    @tutor = Tutor.new(params[:tutor])

    if @tutor.save
      redirect_to @tutor, notice: 'Tutor was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @tutor = Tutor.find(params[:id])

    if @tutor.update_attributes(params[:tutor])
      redirect_to @tutor, notice: 'Tutor was successfully updated.'
    else
      render action: "edit"
    end
  end


  def destroy
    @tutor = Tutor.find(params[:id])
    @tutor.destroy

    redirect_to tutors_url
  end

  def import
  end

  def upload
    Tutor.import(params[:file])
    redirect_to tutors_url, notice: 'Tutors imported'
  end
end
