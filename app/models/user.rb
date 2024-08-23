class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :date_of_birth, presence: true
  validate :password_complexity
  validate :validate_full_width_characters

  has_many :products
  has_many :orders

  private

  def password_complexity
    return if password.blank? || (password =~ /(?=.*[a-zA-Z])(?=.*\d)/)

    errors.add :password, 'must include both letters and numbers'
  end

  def validate_full_width_characters
    validate_full_width(last_name, 'last_name')
    validate_full_width(first_name, 'first_name')
    validate_full_width(last_name_kana, 'last_name_kana', /\A[ァ-ヶー－]+\z/)
    validate_full_width(first_name_kana, 'first_name_kana', /\A[ァ-ヶー－]+\z/)
  end

  def validate_full_width(attribute, field_name, regex = /\A[ぁ-んァ-ン一-龥々〆〤]+\z/)
    value = send(attribute)
    puts "Validating #{attribute}: #{value}" # デバッグ用出力
    return if value.blank?

    return if value =~ regex

    puts "Validation failed for #{attribute}" # デバッグ用出力
    errors.add field_name.to_sym, 'must be in full-width characters'
  end
end
