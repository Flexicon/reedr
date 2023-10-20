# frozen_string_literal: true

class FeedsController < ApplicationController
  before_action :set_feed, only: %i[show edit update destroy]
  before_action :authenticate_user!
  after_action :verify_policy_scoped, only: %i[index show edit update destroy]

  # GET /feeds or /feeds.json
  def index
    @feeds = policy_scope(Feed).all
  end

  # GET /feeds/1 or /feeds/1.json
  def show; end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit; end

  # POST /feeds or /feeds.json
  def create
    @feed = add_new_feed

    respond_to do |format|
      if @feed.persisted?
        format.html { redirect_to feed_url(@feed), notice: I18n.t('feeds.feed_created') }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1 or /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(update_feed_params)
        format.html { redirect_to feed_url(@feed), notice: I18n.t('feeds.feed_updated') }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1 or /feeds/1.json
  def destroy
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_url, notice: I18n.t('feeds.feed_destroyed') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feed
    @feed = policy_scope(Feed).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def update_feed_params
    params.require(:feed).permit(:title, :subtitle)
  end

  def create_feed_params
    params.require(:feed).permit(:url)
  end

  def add_new_feed
    UseCases::AddNewFeed.call(url: create_feed_params.fetch(:url), user: current_user)
  end
end
