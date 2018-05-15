class Bingo

  #シートを作成
  def sheet (numbers)
    sheet = (1..5).map {numbers.slice!(0, 5)}
    sheet[2][2] = nil
    sheet
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
    (1..99).to_a. shuffle
  end

  #1〜99の数字配列から25までの数字を取り出す
  def create_numbers(random_numbers)
    random_numbers.shuffle.slice(0, 25)
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
            bingo = true
          elsif side_count == 4
            last_one = true
          end
        end
        if sheet[i][j] == nil
          height_count += 1
          if height_count == 5
            bingo = true
          elsif height_count == 4
            last_one = true
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
            bingo = true
          elsif slant_count == 4
            last_one = true
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
            bingo = true
          elsif slant_count == 4
            last_one = true
          end
        end
      end
      slant_count = 0
    end
    return bingo,last_one
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
      bingo,last_one = bingo.judgement(sheet)
      #出力
      bingo.display(sheet)

      if bingo
        print "ビンゴです"
        break
      elsif last_one
        print "リーチです"
      end
    end
  end
end
