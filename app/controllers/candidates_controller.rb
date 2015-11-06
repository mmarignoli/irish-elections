class CandidatesController < ApplicationController
  api :GET, '/candidates'

  def index
    @candidates = candidates
    respond_to do |format|
      format.html
      format.json { render_for_api :default, json: @candidates }
      format.xml { render_for_api :default, xml: @candidates }
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"candidates-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def show
    @candidate = Candidate.friendly.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render_for_api :default, json: @candidate }
      format.xml { render_for_api :default, xml: @candidate }
    end
  end

  protected

  def candidates
    if params[:q].present?
      Candidate.search(params[:q])
    else
      Candidate.list
    end
  end

end