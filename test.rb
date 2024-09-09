def checkAtSign
  email = gets.chomp
  len = email.length  
  checkAt  = email.index("@") 
  countAt = email.scan("@").length

  if countAt == 1
    afterAt = email.slice(checkAt,len-1)
    if afterAt.include?(".")
      return true
    else
      return false
    end
  end
  
end

# @を最低1つは含んでいること、@の後にドットがあること

checkAtSign


