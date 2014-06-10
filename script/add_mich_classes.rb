require 'rubygems'
require 'roo'  
 
puts Rails.root.join('final_class_list.xlsx') 
workbook = Roo::Excelx.new(Rails.root.join('final_class_list.xlsx').to_s)
workbook.default_sheet = workbook.sheets[1]

categories = Hash.new
workbook.row(1).each_with_index {|header, i|
   categories[header] = i
}

interests = []
((workbook.first_row+1)..workbook.last_row).each do |row|
  puts row
  interests << workbook.row(row)
end


categories.keys.sort.each do |category|
  index = categories[category]
  category = category.upcase
  c = Category.where(
     name: category,
     ancestry: nil
  ).first_or_create();
  
  p c;
  
  interests.each do |interest|
    course = interest[index]
    next unless course
    course = course.to_i.to_s.strip
    next if course.empty?
   
    pc = Category.where(
          ancestry: c.id.to_s,
          name: "#{category}#{course}" 
         ).first_or_create
    p pc;
  end  

end