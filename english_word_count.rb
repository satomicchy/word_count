full_text = File.open(ARGV[0])

words_counnt = {}
full_text.each do |line|
  words_by_line = line.chomp.delete(".").delete(",").delete("\"").split(" ")
  words_by_line.each do |word|
    next if /[0-9]/ =~ word
    words_counnt[word] = if words_counnt[word] == nil
                           1
                         else
                           words_counnt[word] + 1
                         end
  end
end

# 文頭が大文字の語彙を小文字にして合算
delete_keys = []
words_counnt.select{|k, v| /^[A-Z]/=~k}.each do |k, v|
  if words_counnt.key?(k.downcase)
    words_counnt[k.downcase] = words_counnt[k.downcase] + words_counnt[k]
    delete_keys << k
  end
end

delete_keys.each{|d| words_counnt.delete_if{|k, v| k == d} }
word_list = words_counnt.sort_by{|k, v| v}.reverse.to_h

p "合計語彙数"
p word_list.count
word_list.each do |k, v|
  p k.to_s + " = " + v.to_s
end
