live_loop :drum do
  with_fx :sound_out do
    sample :loop_breakbeat, beat_stretch: 4, amp: 2
  end
  sleep 4
end

live_loop :random_sample do
  sync :drum
  sample :ambi_choir, beat_stretch: 2
end


chords = ring(
  chord(:d3, :m9),
  chord(:g3, '7+5-9'),
  chord(:c3, :maj9),
  chord(:a2, '7-13')
)

random_lead = ring(
  chord(:d5, :m9),
  chord(:g5, '7+5-9'),
  chord(:c5, :maj9),
  chord(:a4, '7-13')
)

define :create_my_beat do |tempo|
  return ring(*tempo.split("").map { |beat| beat == "*" })
end

bass = ring(:d2, :g2, :c2, :a2)
my_tempo = create_my_beat("*---*-*-")
live_loop :bassline do
  sync :drum
  curr = bass.tick(:name)
  8.times do
    if my_tempo.tick
      use_synth :chipbass
      play curr, amp: 0.4, release: rrand(0.5, 1), pan: rrand(-1, 1)
    end
    sleep 0.25
  end
end

live_loop :hi_lead do
  sync :drum
  notes = random_lead.tick
  8.times do
    use_synth :saw
    play notes.choose(), amp: 0.3, pan: rrand(-1, 1) if spread(6, 8).tick
    sleep 0.25
  end
end


live_loop :chord do
  sync :drum
  with_fx :reverb, room: 1 do
    use_synth :beep
    play_pattern_timed chords.tick, 0.25
  end
end
