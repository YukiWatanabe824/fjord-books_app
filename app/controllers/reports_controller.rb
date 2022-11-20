# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  # GET /reports
  def index
    @reports = Report.order(:id)
  end

  # GET /reports/1
  def show
    set_commentable
    @comments = Report.find_by(id: params[:id]).comments.all
    @comment = @commentable.comments.build
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    redirect_to reports_path if @report.user.id != current_user.id
  end

  # POST /reports
  def create
    @report = Report.new(report_params)

    if @report.save
      redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1
  def update
    if @report.update(report_params)
      redirect_to report_url(@report), notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /reports/1
  def destroy
    if @report.user != current_user
      redirect_to reports_path
    else
      @report.destroy
      redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
    end
  end

  private
    def set_commentable
      @commentable = Report.find_by(id: params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:user_id, :title, :content)
    end
  end
