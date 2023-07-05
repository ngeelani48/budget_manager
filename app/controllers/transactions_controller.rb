class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    @transactions = current_user.transactions
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.author = current_user

    # Assign the first non-blank group_id to the transaction
    @transaction.group_id = params[:transaction][:group_ids].reject(&:blank?).first

    respond_to do |format|
      if @transaction.save
        if @transaction.group_id.present?
          format.html { redirect_to Group.find(@transaction.group_id), notice: 'Transaction was successfully created.' }
        else
          format.html do
            redirect_to @transaction, notice: 'Transaction was successfully created, but no group was assigned.'
          end
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy
    redirect_to group_path, notice: 'Transaction was successfully destroyed.'
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :amount, group_ids: [])
  end
end
