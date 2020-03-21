# 每次執行後會幫你的音符 +1
# 所以他不斷執行 1, 3, 5, 1, 3, 5

live_loop :tick1 do
  play scale(:c4, :major).tick
end

# notes = [1, 3, 5]
# notes.each |note|
#   play note
# end
# sleep 0.25

live_loop :tick1 do
  play scale(:c4, :major).tick
  sleep 0.25
end


notes = ring(:g4, :e4, :e4, :f4, :d4, :d4, :c4, :d4, :e4, :f4, :g4, :g4, :g4)
sleeps = ring(0.25, 0.25, 0.5, 0.25, 0.25, 0.5, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.5)
live_loop :name do
  play notes.tick
  sleep sleeps.look
end


live_loop :melody do
  sample :drum_heavy_kick, amp: 2 if spread(2, 4).tick
  sample :drum_cymbal_open if spread(5, 8).look
  
  play scale(:a4, :major_pentatonic, num_octaves: 2).choose(), release: 0.5 if spread(6, 13).look
  sleep 0.25
end

rand(100)
rrand(100, 1000)
choose()
one_in(4)
use_random_seed 2003
shuffle

define :play_note do |note|
  play note
end

play_note :e5


define :create_my_beat do |tempo|
  return ring(*tempo.split("").map { |beat| beat == "*" })
end

my_tempo = "*--*--*-" # ring (true, false, false, true, false, false, true, flase)


my_tempo = create_my_beat("*--*--*-") # ring (true, false, false, true, false, false, true, flase)
melody = ring(:a5, :c6, :a5, :a5, :c6, :a5, :a5, :c6, :a5, :b5, :a5, :g5)

live_loop :my_beat do
  if my_tempo.tick(:name) then
    sample :drum_heavy_kick
    play melody.tick(:name1), release: 0.25
  end
  sleep 0.125
end

chord(:c4, :major).each do |note|
  play note
  sleep 0.25
end

current_beat = tick
tick += 1
play scale(:c4, :major)[current_beat]
play chord(:c4, :major)[current_beat]
