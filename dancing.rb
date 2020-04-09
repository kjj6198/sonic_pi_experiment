a1 = ring :g4, :g4, :e4, :g4, :a4, :b4, :a4
a2 = ring :g4, :e4, :g4
a3 = ring :a4, :d4, :b4, :a4
a4 = ring :g4
a5 = ring :g4, :g4, :e4, :g4, :a4, :b4, :a4
a6 = ring :d5, :b4, :a4, :g4, :g4, :d5, :a4
a7 = ring :g4, :d5, :a4, :g4

b1 = ring :a4, :g4, :a4, :b4, :a4, :g4

melody = ring a1, a2, a3, a4, a1, a1, a6, a7

define :create_tempo do |tempo|
  return ring(*tempo.split("").map { |beat| beat == "*" })
end

tempo = create_tempo "-*******"
tempo2 = create_tempo "-----***"
tempo3 = create_tempo "-*---***"
tempo4 = create_tempo "*-------"

tempos = tempo, tempo2, tempo3, tempo4

live_loop :go do
  use_synth :beep
  play a1.tick(:melody), release: 0.25 if tempo.tick
  sleep 0.25
end