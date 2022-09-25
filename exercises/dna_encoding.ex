defmodule DNA do
  def encode_nucleotide(code_point) do

    case code_point do
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
      _ -> 0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      0b0000 -> ?\s
    end
  end

  def encode(dna) do
    case dna do
      [head | tail] -> <<encode_nucleotide(head)::4, encode(tail)::bitstring>>
      [] -> <<>>
    end
  end

  def decode(dna) do
    case dna do
      <<value::4, tail::bitstring>> -> [decode_nucleotide(value) | decode(tail)]
      <<>> -> ''
    end
  end

end
