class Bingo

  @@bingo = false
  @@last_one = false
  def bingo_decision(bingo)
    @@bingo = bingo
  end

  def last_one_decision(last_one)
    @@last_one = last_one
  end

  #シートを作成
  def get_sheet (numbers)
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
    field_number = 0
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
    numbers = []
    for num in 1..99 do
      numbers.push(num)
    end
    numbers.shuffle
  end

  #1〜99の数字配列から25までの数字を取り出す
  def get_numbers(random_numbers)
    numbers = []
    for num in 0..24 do
     numbers.push(random_numbers[num])
    end

    return numbers
  end

  def judgement(sheet)

    #判定
     side_count = 0
     height_count = 0
    sheet.each_with_index do |row,i|
      row.each_with_index do |field,j|
        if sheet[i][j] == nil
          side_count += 1
          if side_count == 5
            bingo_decision(true)
          elsif side_count == 4
            last_one_decision(true)
          end
        end
        if sheet[i][j] == nil
          height_count += 1
          if height_count == 5
            bingo_decision(true)
          elsif height_count == 4
            last_one_decision(true)
          end
        end
      end
      side_count = 0
      height_count = 0
    end

    # #横判定
    # judge_count = 0
    # sheet.each_with_index do |row,i|
    #   row.each_with_index do |field,j|
    #     if sheet[i][j] == nil
    #       judge_count += 1
    #       if judge_count == 5
    #         bingo_decision(true)
    #       elsif judge_count == 4
    #         last_one_decision(true)
    #       end
    #     end
    #   end
    #   judge_count = 0
    # end
    #
    # #縦判定
    # sheet.each_with_index do |row, i|
    #   row.each_with_index do |field,j|
    #     if sheet[j][i] == nil
    #       judge_count += 1
    #       if judge_count == 5
    #         bingo_decision(true)
    #       elsif judge_count == 4
    #         last_one_decision(true)
    #       end
    #     end
    #   end
    #   judge_count = 0
    # end
  end



  bingo = Bingo.new

  #1〜99までのランダムな数字を生成
  random_numbers = bingo.create_random_numbers

  #ランダムな数字をシートのサイズに抽出
  numbers = bingo.get_numbers(random_numbers)
  #シートを取得
  sheet = bingo.get_sheet(numbers)
  #初回出力
  bingo.display(sheet)


  bingo.create_random_numbers.each do |judge|
    names = gets
    if names == "\n"

      p "現在の当選結果は#{judge}です"
      result_sheet = bingo.judgement(sheet)

      result_sheet.each do |row|
        row.each_with_index do |field, i|
          if field == judge
            row[i] = nil
          end
        end
      end

      #判定
      bingo.judgement(result_sheet)
      #出力
      bingo.display(result_sheet)

      if @@bingo
        print "ビンゴです"
        break
      elsif @@last_one
        print "リーチです"
      end
    end
  end
end
