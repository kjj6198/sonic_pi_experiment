
live_loop :random_dorian do
  play scale(:c5, :dorian).choose(), release: 0.7
  sleep rrand(0.25, 1)
end

live_loop :chorus do
  [6, 4, 1, 5].each do |d|
    6.times do
      
      use_synth :blade
      play (chord_degree d, :c, :major, 3).shuffle().take(3).choose()
      
      sleep 0.25
    end
  end
end

live_loop :drum do
  sample :drum_heavy_kick if one_in(2)
  sample :drum_cymbal_soft if one_in(6)
  sample :elec_cymbal, amp: 0.25
  sleep 0.25
end

live_loop :drum do
  sample :drum_heavy_kick
  sleep 1
end

live_loop :melody do
  sync :drum
  play :c4, release: 0.25
  sleep 0.25
  play :d4, release: 0.25
  sleep 0.25
  play :e4, release: 0.25
  sleep 0.25
end