class Project <ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge

  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def contestant_count
    contestants.count
  end

  def average_experience
    return "n/a" if contestants.empty?
    contestants.average(:years_of_experience)
  end
end
