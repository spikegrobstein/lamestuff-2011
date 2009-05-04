module ResumeHelper
  
  def indent(pdf, amount) 
    pdf.span(pdf.bounds.width - amount, :position => amount) do 
      yield 
    end 
  end
end
