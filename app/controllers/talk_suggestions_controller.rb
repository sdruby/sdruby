class TalkSuggestionsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]

  # GET /talk_suggestions
  # GET /talk_suggestions.json
  def index
    @talk_suggestions = TalkSuggestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @talk_suggestions }
    end
  end

  # GET /talk_suggestions/1
  # GET /talk_suggestions/1.json
  def show
    @talk_suggestion = TalkSuggestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @talk_suggestion }
    end
  end

  # GET /talk_suggestions/new
  # GET /talk_suggestions/new.json
  def new
    @talk_suggestion = TalkSuggestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @talk_suggestion }
    end
  end

  # GET /talk_suggestions/1/edit
  def edit
    @talk_suggestion = TalkSuggestion.find(params[:id])
    if @talk_suggestion.created_by_id != current_user.id
      redirect_to talk_suggestions_path, notice: 'You can not edit other peoples suggestions'
    end
  end

  # POST /talk_suggestions
  # POST /talk_suggestions.json
  def create
    @talk_suggestion = TalkSuggestion.new(params[:talk_suggestion])

    respond_to do |format|
      if @talk_suggestion.save
        format.html { redirect_to talk_suggestions_path, notice: 'Talk suggestion was successfully created.' }
        format.json { render json: @talk_suggestion, status: :created, location: @talk_suggestion }
      else
        format.html { render action: "new" }
        format.json { render json: @talk_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /talk_suggestions/1
  # PUT /talk_suggestions/1.json
  def update
    @talk_suggestion = TalkSuggestion.find(params[:id])

    respond_to do |format|
      if @talk_suggestion.update_attributes(params[:talk_suggestion])
        format.html { redirect_to talk_suggestions_path, notice: 'Talk suggestion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @talk_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talk_suggestions/1
  # DELETE /talk_suggestions/1.json
  def destroy
    @talk_suggestion = TalkSuggestion.find(params[:id])
    @talk_suggestion.destroy

    respond_to do |format|
      format.html { redirect_to talk_suggestions_url }
      format.json { head :no_content }
    end
  end

  def vote
    @talk_suggestion = TalkSuggestion.find(params[:id])
    current_user.update_attribute(:last_voted_at, Time.now)
    @talk_suggestion.update_attribute(:vote_count, @talk_suggestion.vote_count + 1)
    respond_to do |format|
      format.html { redirect_to talk_suggestions_path, notice: 'Your vote has been added. You can vote again in 24 hours.' }
    end
  end

end
