module Admin::SemestersHelper
  def school_year year
    year.to_s + "/" + (year+1).to_s
  end
end
