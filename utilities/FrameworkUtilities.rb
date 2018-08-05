class FrameworkUtilities
  def initialize()

  end

  def is_numeric(o)
    begin
      value = Integer(o)
      return true
    rescue
      return false
    end
  end

  # Creating Random number with required length
  def generate_Random_number()
    randomNo = Random.rand(1000-10) + 10
    number=randomNo.to_s
    return(number)
  end
end