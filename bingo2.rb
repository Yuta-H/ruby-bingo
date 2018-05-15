class Bingo

  #シートを作成
  def sheet (numbers)
    sheet = Array.new(5).map{Array.new(5)}
    row = 0
    field = 0
    numbers.each { |number|
      sheet[row][field] = number
      field += 1
      if field >= 5
        field = 0
        row += 1
      end
    }
    sheet[2][2] = nil
    return sheet
  end

  #出力
  def display(sheet)
    sheet.each do |row|
      print "|"
      row.each do |field|
        if field.nil?
          print "  |"
        else
          printf("%2d|",field)
        end
      end
      puts "\n"
    end
  end

  #1〜99の数字を作成
  def create_random_numbers
    numbers = [*(1..99)]
    numbers.shuffle
  end

  #1〜99の数字配列から25までの数字を取り出す
  def create_numbers(random_numbers)
    numbers = []
    for num in 0..24 do
      numbers.push(random_numbers[num])
    end

    return numbers
  end

  def judgement(sheet)

    #判定
    bingo = nil
    last_one = nil
    side_count = 0
    height_count = 0
    sheet.each_with_index do |row,i|
      row.each_with_index do |field,j|
        if sheet[i][j] == nil
          side_count += 1
          if side_count == 5
            bingo = 2
          elsif side_count == 4
            last_one = 1
          end
        end
        if sheet[i][j] == nil
          height_count += 1
          if height_count == 5
            bingo = 2
          elsif height_count == 4
            last_one = 1
          end
        end
      end
      side_count = 0
      height_count = 0
    end

    #斜め判定
    slant_count = 0
    sheet.each do |row|
      row.each_with_index do |field,j|
        if sheet[j][j] == nil
          slant_count += 1
          if slant_count == 5
            bingo = 2
          elsif slant_count == 4
            last_one = 1
          end
        end
      end
      slant_count = 0
    end
    slant_count = 0
    reverse_sheet = sheet.reverse
    reverse_sheet.each do |row|
      row.each_with_index do |field,j|
        if sheet[j][j] == nil
          slant_count += 1
          if slant_count == 5
            bingo = 2
          elsif slant_count == 4
            last_one = 1
          end
        end
      end
      slant_count = 0
    end
    return last_one,bingo
  end



  bingo = Bingo.new

  #1〜99までのランダムな数字を生成
  random_numbers = bingo.create_random_numbers

  #ランダムな数字をシートのサイズに抽出
  numbers = bingo.create_numbers(random_numbers)
  #シートを取得
  sheet = bingo.sheet(numbers)
  #初回出力
  bingo.display(sheet)

  bingo.create_random_numbers.each do |judge|
    names = gets
    if names == "\n"

      p "現在の当選結果は#{judge}です"

      sheet.each do |row|
        row.each_with_index do |field, i|
          if field == judge
            row[i] = nil
          end
        end
      end
      #判定
      result = bingo.judgement(sheet)
      #出力
      bingo.display(sheet)

      if result[1] == 2
        print "ビンゴです"
        break
      elsif result[0] == 1
        print "リーチです"
      end
    end
  end
end
