defmodule Username do
  def sanitize([first_letter | other_letters]) do
    first_letter = case first_letter do
      first_letter when first_letter in ?a..?z -> [first_letter]
      ?_ -> [first_letter]
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> ''
    end
    first_letter ++ sanitize(other_letters)
  end
  def sanitize([]) do
    ''
  end
end
