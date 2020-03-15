notes = [:c4, :c4, :g4, :g4, :a4, :a4, :g4, :f4, :f4, :e4, :e4, :d4, :d4, :c4]
sleeps = [0.25, 0.25, 0.25, 0.25, 0.25,0.25, 0.5, 0.25, 0.25, 0.25, 0.25, 0.25,0.25, 0.5]

live_loop :melody do
  notes.each_with_index do |n, i|
    use_synth :beep
    play n, amp: 0.7, release: 0.4
  end
end

live_loop :drum do
  sample :drum_heavy_kick, amp: 2
  sleep 0.5
end

live_loop :hihat do
  sample :drum_cymbal_closed
  sleep 0.25
end

live_loop :hihat2 do
  sample :drum_cowbell
  sleep 1
end

live_loop :chord do
  play_chord chord(:c3, :major)
  sleep 1
  play_chord chord(:f3, :major)
  sleep 0.5
  play_chord chord(:c3, :major)
  sleep 0.5
  play_chord chord(:g3, :major)
  sleep 0.5
  play_chord chord(:c3, :major)
  sleep 0.5
  play_chord chord(:g3, :major)
  sleep 0.5
  play_chord chord(:c3, :major)
  sleep 0.5
end