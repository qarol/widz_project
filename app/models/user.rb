require 'digest/sha1'

class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  
  # relacje rodzic-dziecko i dziecko-rodzic
  has_and_belongs_to_many :children, :class_name => "User", :join_table => "parent_children", :association_foreign_key => "parent_id", :foreign_key => "child_id"
  has_and_belongs_to_many :parents, :class_name => "User", :join_table => "parent_children", :association_foreign_key => "child_id", :foreign_key => "parent_id"
  #has_many :parent_child_relationships, :class_name => "ParentChild", :foreign_key => :parent_id
  #has_one :child_parent_relationship, :class_name => "ParentChild", :foreign_key => :child_id
  #has_many :children, :through => :parent_child_relationships
  #has_one :parent, :through => :child_parent_relationship
  accepts_nested_attributes_for :parents, :children#, :child_parent_relationship, :parent_child_relationships 

  # relacje uczeń-klasa
  has_one :classroom_user
  has_one :classroom, :through => :classroom_user
  has_many :classrooms
  has_many :classroom_educators, :class_name => "Classroom", :foreign_key => :user_id
  has_many :teach_subjects, :class_name => 'Subject'
  has_many :attendances, :conditions => "lecture_unit_id IS NOT NULL"
  has_many :marks

  has_and_belongs_to_many :groups

  def has_role?(role_in_question)
    @_list ||= self.roles.collect(&:name)
    return true if @_list.include?("admin")
    (@_list.include?(role_in_question.to_s) )
  end

  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_length_of       :lastname,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :make_activation_code 

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :lastname, :password, :password_confirmation, :parent, :child

  def teacher_subjects semester_id=nil
    semester_id ||= Semester.choosen_or_current(semester_id)
    self.teach_subjects.semester(semester_id)
  end
  
  def subjects semester_id=nil
    semester_id ||= Semester.choosen_or_current(semester_id)
    result = self.groups.map(&:subject).compact.flatten.select{|s| s.semester_id == semester_id.id}
    result += self.classroom.subjects.semester(semester_id.id) unless self.classroom.nil?
    result
  end

  def is_admin?
    self.roles.map(&:name).include?("admin")
  end

  def is_student?
    self.roles.map(&:name).include?("student")
  end

  def is_parent?
    self.roles.map(&:name).include?("parent")
  end

  def is_teacher?
    self.roles.map(&:name).include?("teacher")
  end

  def self.teachers
    User.all.select{|u| u.is_teacher?}
  end

  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end
  
  def recently_activated?
    @activated
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

    protected
      def make_activation_code
            self.activation_code = self.class.make_token
      end
  
end
