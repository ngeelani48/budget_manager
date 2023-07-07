class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @groups = current_user.groups
  end

  def show
    @transactions = @group.transactions.order(created_at: :desc)
    @total_amount = @group.transactions.sum(:amount)
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    @group.image.attach(params[:group][:image]) # Attach the image using Active Storage

    if @group.save
      redirect_to groups_path, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group), notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @group.transactions.destroy_all
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private

  def set_group
    @group = current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
