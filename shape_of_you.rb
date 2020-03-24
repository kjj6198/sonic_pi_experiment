use_bpm 50

define :create_my_beat do |tempo|
  return ring(*tempo.split("").map { |beat| beat == "*" })
end

melody = ring([:a5, :f5], [:c6, :f5], [:a5, :f5], [:d5, :a5], [:a5, :c6], [:d5, :a5], [:f5, :a5], [:a5, :c6], [:f5, :a5], [:g5,:b5], [:f5, :a5], [:e5, :g5])
chords = ring(
  chord(:a4, :minor),
  chord(:d4, :minor),
  chord(:f4, :major),
  chord(:g4, :major)
)

bassline = ring(
  :a2, :a2, :a2,
  :d2, :d2, :d2,
  :f2, :f2, :f2,
  :g2, :g2, :g2
)


tempo = create_my_beat "*--*--*-"
amps = ring([0.8, 0.2, 0.2, 0.8, 0.2, 0.2, 0.8, 0.2])

snare_tempo = create_my_beat "--**--*--"
live_loop :snare do
  
  sample :drum_cymbal_closed, amp: [0.8, 0.2].choose() if snare_tempo.tick
  sleep 0.125
  
end


live_loop :kick do
  with_fx :sound_out_stereo do
    sample :bd_tek, amp: 1.2 if tempo.tick
    sleep 0.125
  end
end

live_loop :bass do
  use_synth :chipbass
  if tempo.tick
    play bassline.tick(:bass), release: 0.2
  end
  sleep 0.125
end

live_loop :baseline do
  with_fx :reverb, room: 0.5 do
    
    if tempo.tick
      play melody.tick(:melody), release: 0.1
      if look(:melody) % 3 === 0
        play_chord chords.tick(:chord).take(2), release: 0.1
      else
        play_chord chords.look(:chord).take(2), release: 0.1
      end
    end
    sleep 0.125
  end
end