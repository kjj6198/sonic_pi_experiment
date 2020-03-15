# https://twitter.com/Kos1mo/status/984799396456906753

[1, 2, 1, 3, 2, 4, 3, 2, 1].each do |x|
  [1, 3, 6, 4].each do |d|
    (range -x, x).each do |i|
      play_chord (chord_degree d, :c, :minor, x, invert: i)
      sleep 0.25
      play_chord (chord_degree d, :c, :minor, x, invert: -i)
      sleep 0.25
    end
  end
end