class EmailBuilder
  include ActiveModel::Model

  CATEGORIES = { inquiry: 'Inquiry', feedback: 'Feedback', acknowledge: 'Acknowledge', sales: 'Sales', marketing: 'Marketing', general: 'General', management: 'Management'}.freeze
  TONES = { formal: 'Formal', casual: 'Casual', polite: 'Polite' }.freeze

  attr_accessor :category, :topic, :tone, :additional_comment, :result

  validates :category, :topic, :tone, presence: true

  def formatted_text!
    "An Inquiry mail for the 2 days sick leave in a polite way to manager from developer, in 3 different ways."
  end

  def category=(value)
    # Check that the value is a valid category
    raise ArgumentError, "Invalid status: #{value}" unless CATEGORIES.key?(value.downcase.to_sym)

    @category = value.downcase.to_sym
  end

  def tone=(value)
    # Check that the value is a valid topic
    raise ArgumentError, "Invalid status: #{value}" unless TONES.key?(value.downcase.to_sym)

    @tone = value.downcase.to_sym
  end

  def category
    CATEGORIES[@category]
  end

  def tone
    TONES[@tone]
  end

  def self.categories
    CATEGORIES.map { |value, label| [label, value.to_s] }
  end

  def self.tones
    TONES.map { |value, label| [label, value.to_s] }
  end
end
