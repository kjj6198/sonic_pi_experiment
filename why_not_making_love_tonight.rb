live_loop :drum do
  with_fx :sound_out do
    sample :loop_breakbeat, beat_stretch: 4, amp: 2
  end
  sleep 4
end


chords = ring(
  chord(:d3, :m9),
  chord(:g3, '7+5-9'),
  chord(:c3, :maj9),
  chord(:a2, '7-13')
)

live_loop :chord do
  sync :drum
  with_fx :reverb, room: 1 do
    play_pattern_timed chords.tick, 0.25
  end
end
