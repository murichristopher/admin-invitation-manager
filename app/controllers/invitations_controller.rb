class InvitationsController < ApplicationController
  before_action :set_company, only: [:index, :new, :create]
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]

  def index
    @invitations = Invitation.all

    if params[:name].present?
      @invitations = @invitations.joins(:user)
                                .where("users.name ILIKE ? OR users.email ILIKE ?", "%#{params[:name]}%", "%#{params[:name]}%")
    end

    if params[:company_id].present?
      @invitations = @invitations.where(company_id: params[:company_id])
    end

    if params[:start_date].present? && params[:end_date].present?
      begin
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        @invitations = @invitations.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
      rescue ArgumentError
        flash.now[:alert] = "Datas inválidas."
      end
    end

    @invitations = @invitations.where(active: true)

    @invitations = @invitations.order(created_at: :desc)
  end

  def show
  end

  def new
    @company = Company.find(params[:company_id])
    @invitation = @company.invitations.build
  end

  def edit
  end

  def create
    @invitation = Invitation.new(invitation_params)

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @invitation, notice: "Invitation was successfully created." }
        format.json { render :show, status: :created, location: @invitation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @invitation, notice: "Invitation was successfully updated." }
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invitation.destroy!

    respond_to do |format|
      format.html { redirect_to invitations_path, status: :see_other, notice: "Invitation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:invitee_name, :invitee_email, :active, :company_id, :user_id)
  end
end
