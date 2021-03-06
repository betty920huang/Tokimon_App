class TokimonsController < ApplicationController
  def index
    @tokimons = Tokimon.all
  end


  def show
    @tokimon = Tokimon.find(params[:id])
    @trainer = @tokimon.trainer
  end 


  def new
    @tokimon = Tokimon.new
  end


  def create
    @tokimon = Tokimon.new(tokimon_params)
    #####
    @trainer = Trainer.find(@tokimon.trainer_id)
    #####
   
    if @tokimon.save
      @tokimon.total  = @tokimon.fire + @tokimon.fight + @tokimon.fly + @tokimon.water + @tokimon.electric + @tokimon.ice
      @tokimon.update_attribute(:total, @tokimon.total)
      redirect_to @tokimon
    else
      render 'new'
    end
  end


  def edit

    @tokimon = Tokimon.find(params[:id])
  end


  def update
    @tokimon = Tokimon.find(params[:id])
    if @tokimon.update_attributes(tokimon_params)
      flash[:success] = "Update successfully! Congratulation!"
      @tokimon.total  = @tokimon.fire + @tokimon.fight + @tokimon.fly + @tokimon.water + @tokimon.electric + @tokimon.ice
      @tokimon.update_attribute(:total, @tokimon.total)
      redirect_to @tokimon
      #Handle a successful update.
    else
      render 'edit'
    end
  end


  def destroy
    @trainer = Trainer.find(Tokimon.find(params[:id]).trainer_id)
    Tokimon.find(params[:id]).destroy
    flash[:success] = "Delete successfully! Congratulation!"
    redirect_to @trainer
  end


  private
    def tokimon_params
      params.require(:tokimon).permit(:name, :fly, :fight, :fire, :water, :electric, :ice,
        :height, :weight, :trainer_id)
    end


end
