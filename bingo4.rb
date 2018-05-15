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

  # 1〜99の数字を作成
  def create_random_numbers
    (1..99).to_a. shuffle
  end

  #1〜99の数字配列から25までの数字を取り出す
  def create_numbers(random_numbers)
    random_numbers.shuffle.slice(0, 25)
  end

  def judgement(sheet)

    #横
    bingo = false
    last_one = false
    sheet.each do |row|
      if row.count(nil) == 5
        bingo = true
      elsif row.count(nil) == 4
        last_one = true
      end
    end

    #縦
    sheet.transpose.each do |row|
      if row.count(nil) == 5
        bingo = true
      elsif row.count(nil) == 4
        last_one = true
      end
    end

    #斜め
    slant_numbers = []
    transpose_slant_numbers = []
    (0..4).to_a.each do |j|
      if sheet[j][j].nil?
        slant_numbers.push(nil)
        p slant_numbers
        if slant_numbers.count(nil) == 5
          bingo = true
        elsif slant_numbers.count(nil) == 4
          last_one = true
        end
      end
      if sheet[j][4 - j].nil?
        transpose_slant_numbers.push(nil)
        if transpose_slant_numbers.count(nil) == 5
          bingo = true
        elsif transpose_slant_numbers.count(nil) == 4
          last_one = true
        end
      end
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
      is_bingo,is_last_one = bingo.judgement(sheet)
      #出力
      bingo.display(sheet)

      if is_bingo
        print "ビンゴです"
        break
      elsif is_last_one
        print "リーチです"
      end
    end
  end
end
