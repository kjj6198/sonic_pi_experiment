# Chord Inversions

# Coded by Adrian Cheater
# Adjust by Kalan

# (in a single tweet)
# https://twitter.com/wpgFactoid/status/666692596605976576

live_loop :drum do
  ##| sync :chorus
  with_fx :sound_out do
    sample :loop_breakbeat, beat_stretch: 4, amp: 2
  end
  sleep 4
end

live_loop :chorus do
  [6, 4, 1, 5].each do |d|
    (range -3, 3).each do |i|
      
      use_synth :blade
      play_chord (chord_degree d, :c, :major, 3, invert: i)
      
      sleep 0.25
    end
  end
end

