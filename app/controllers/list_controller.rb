class ListController < ApplicationController
  layout false

  def index
    @folder = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}"
  end

  def show
    report = params[:id] + '.erb'
    render "%s/%s/%s" % [Rails.root, Autotest::CONFIG.test_folder, report], layout: false
  end

  def nightly
    report = params[:id] + '.erb'
    render "%s/%s/%s/%s" % [Rails.root, Autotest::CONFIG.test_folderm, params[:folder], report], layout: false
  end

  def reports
    @folder = params[:theDate]
    render :index
  end
  
end
