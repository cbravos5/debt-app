class DebtsController < ApplicationController
  before_action :set_debt, only: %i[ show edit update destroy ]
  helper_method :get_balance_color

  # GET /debts or /debts.json
  def index
    @debts = Debt.where(u_id: current_user.id)
    @balance = set_balance
  end

  # GET /debts/1 or /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    @debt = Debt.new
  end

  # GET /debts/1/edit
  def edit
  end

  # POST /debts or /debts.json
  def create
    parameters = debt_params
    parameters[:u_id] = current_user.id
    @debt = Debt.new(parameters)

    respond_to do |format|
      if @debt.save
        format.html { redirect_to debts_path, notice: "Debt was successfully created." }
        format.json { render :show, status: :created, location: @debt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debts/1 or /debts/1.json
  def update
    respond_to do |format|
      if @debt.update(debt_params)
        format.html { redirect_to debts_path, notice: "Debt was successfully updated." }
        format.json { render :show, status: :ok, location: @debt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debts/1 or /debts/1.json
  def destroy
    @debt.destroy
    respond_to do |format|
      format.html { redirect_to debts_url, notice: "Debt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt
      @debt = Debt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def debt_params
      params.require(:debt).permit(:value, :title, :descp)
    end

    def set_balance
      total = 0;
      @debts.each do |debt|
        total += debt.value;
      end
      return total;
    end

    def get_balance_color
      if @balance == 0
        return 'text-light'
      elsif @balance > 0
        return 'text-success'
      else
        return 'text-danger'
      end
    end
end
