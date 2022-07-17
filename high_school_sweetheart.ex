defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name
    |> String.trim_leading()
    |> String.first()
  end
  def initial(name) do
    String.upcase(first_letter(name)) <> "."
  end
  def initials(full_name) do
    split_names = String.split(full_name, " ")
    [first_name, last_name] = split_names
    first_initial = initial(first_name)
    last_initial = initial(last_name)
    "#{first_initial} #{last_initial}"
  end
  def pair(full_name1, full_name2) do
    initials_1 = initials(full_name1)
    initials_2 = initials(full_name2)
    heart = """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{initials_1}  +  #{initials_2}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
    heart
  end
end
