defmodule Boggle do
  def boggle({}, _legalWords) do
  IO.puts("empty")
    %{}
  end
   #convert 2d tuple to 2d list
  def boggle(tuple2d, legalWords) when is_tuple(tuple2d) do
    list2d = Tuple.to_list(tuple2d)
    final = Enum.map(list2d, &Tuple.to_list/1)
	res =
 	boggle(final, legalWords)
   res
  end
    
    
  def boggle(board, [head | legalWords]) do
    map = %{}
    cords = findWord(board, head, :nil, [], board)

   newmap = 
    if cords != nil do
        Map.put(map, head, cords)
    else
        map
    end
    
    boggle(board, legalWords, newmap)
  end
  
  def boggle(board, [head | legalWords], map) do
    cords = findWord(board, head, :nil, [], board)
    
    newmap = 
    if cords != nil do
        Map.put(map, head, cords)
    else
        map
    end
    
    boggle(board, legalWords, newmap)
  end
  
  def boggle(_, [], map) do
    map
  end
  
 def findWord(_board, "", _word2, result) do
    result
 end

 
 def findWord(board, word, word2, result, orig) do
    letter = String.at(word, 0)
    length_n = length(board)
    cord = searchBoard(board, letter, 0, 0, length_n)
    if cord == nil do
        nil
    else
        rest_of_word = String.slice(word, 1, String.length(word) - 1)
        row_index = elem(cord, 0)
        col_index = elem(cord, 1)
        newboard = remove_element_at(orig, row_index, col_index)
        found = findWord(newboard, rest_of_word, word2, row_index, col_index, result ++ [cord], true, length_n)
        final =
        if (found == nil) do
            newboard2 = remove_element_at(board, row_index, col_index)
            findWord(newboard2, word, word2, result, orig)
        else
            found
        end
        final
    end
 end
 
  def findWord(_board, "", _word2, _prevRow, _prevCol, result, _bool, _n) do
    result
 end
 
  def findWord(board, word, word2, prevRow, prevCol, result, firsttime, n) do
    if firsttime do
                res1 = findWord(board, word, word2, prevRow+1, prevCol, result, false, n)
                if res1 == nil do
                     res2 = findWord(board, word, word2, prevRow-1, prevCol, result, false, n)
                     if res2 == nil do
                        res3 = findWord(board, word, word2, prevRow, prevCol+1, result, false, n)
                        if res3 == nil do
                         res4 = findWord(board, word, word2, prevRow, prevCol-1, result, false, n)
                            if res4 == nil do
                             res5 = findWord(board, word, word2, prevRow+1, prevCol+1, result, false, n) #down right
                              if res5 == nil do
                                 res6 = findWord(board, word, word2, prevRow+1, prevCol-1, result, false, n)   #down left
                                 if res6 == nil do
                                    res7 = findWord(board, word, word2, prevRow-1, prevCol+1, result, false, n)    # up right
                                    if res7 == nil do
                                        res8 = findWord(board, word, word2, prevRow-1, prevCol-1, result, false, n)   #up left
                                        if res8 == nil do
                                            nil
                                        else
                                        res8
                                        end
                                    else
                                    res7
                                    end
                                 else
                                 res6
                                 end
                                else
                                res5
                                end
                            else
                            res4
                            end
                        else
                        res3
                        end
                    else
                    res2
                    end
                else
                res1
                end
    else
        row = Enum.at(board, prevRow)
        if row == nil || prevCol < 0 || prevCol > (n - 1) || prevRow < 0 || prevRow > (n - 1) do
            nil
        else
            nowLetter = Enum.at(row, prevCol)
            if nowLetter == nil do 
                nil
            else
                letter = String.at(word, 0)
                if nowLetter != letter do
                    nil
                else
                    rest_of_word = String.slice(word, 1, String.length(word))
                    newboard = remove_element_at(board, prevRow, prevCol)
                    res1 = findWord(newboard, rest_of_word, word2, prevRow+1, prevCol, result ++ [{prevRow, prevCol}], false, n)
                    if res1 == nil do
                         res2 = findWord(newboard, rest_of_word, word2, prevRow-1, prevCol, result ++ [{prevRow, prevCol}], false, n)
                         if res2 == nil do
                            res3 = findWord(newboard, rest_of_word, word2, prevRow, prevCol+1, result ++ [{prevRow, prevCol}], false, n)
                            if res3 == nil do
                             res4 = findWord(newboard, rest_of_word, word2, prevRow, prevCol-1, result ++ [{prevRow, prevCol}], false, n)
                                if res4 == nil do
                                 res5 = findWord(newboard, rest_of_word, word2, prevRow+1, prevCol+1, result ++ [{prevRow, prevCol}], false, n) #down right
                                  if res5 == nil do
                                     res6 = findWord(newboard, rest_of_word, word2, prevRow+1, prevCol-1, result ++ [{prevRow, prevCol}], false, n)   #down left
                                     if res6 == nil do
                                        res7 = findWord(newboard, rest_of_word, word2, prevRow-1, prevCol+1, result ++ [{prevRow, prevCol}], false, n)    # up right
                                        if res7 == nil do
                                            res8 = findWord(newboard, rest_of_word, word2, prevRow-1, prevCol-1, result ++ [{prevRow, prevCol}], false, n)   #up left
                                            if res8 == nil do
                                                nil
                                            else
                                            res8
                                            end
                                        else
                                        res7
                                        end
                                     else
                                     res6
                                     end
                                    else
                                    res5
                                    end
                                else
                                res4
                                end
                            else
                            res3
                            end
                        else
                        res2
                        end
                    else
                    res1
                    end
                end
            end
        end
    end
    
    
    
    
 end
 

def searchBoard([], _letter, _col_index, _row_index, _n) do
    nil
end

def searchBoard([head | board], letter, col_index, row_index, n) do
    check = searchRow(head, letter, col_index, row_index, n)
    if check == nil do
        searchBoard(board, letter, col_index, row_index+1, n)
    else
        check
    end
end

def searchRow([], _letter, _col_index, _row_index, _n) do
    nil
end

def searchRow([head | row], letter, col_index, row_index, n) do
    if letter == head do
    {row_index, col_index}
    else
    searchRow(row, letter, col_index+1, row_index, n)
    end
end
 
 #remove an element and replaces with "-1"
  def remove_element_at(list, row_index, col_index, new_value \\ "-1") do
    Enum.with_index(list, fn (row, i) ->
      case i do
        ^row_index ->
          new_row = List.replace_at(row, col_index, new_value)
          {new_row, true}
        _ ->
          {row, false}
      end
    end) |> Enum.map(&elem(&1, 0))
  end
  
  
end