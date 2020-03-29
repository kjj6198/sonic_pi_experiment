use_bpm 65

define :create_my_beat do |tempo|
  return ring(*tempo.split("").map { |beat| beat == "*" })
end

loop1 = ring :a5, :c6, :d6
loop2 = ring :g5, :c6, :d6
end1 = ring :a6, :g6, :a6
ending = ring :a5, :c6, :d6, :g6, :f6, :e6

my_loop = ring loop1, loop2, loop2, ending

tempo = create_my_beat "*--*--*---*-*-*-"

tempo2 = spread(5, 16)


in_thread do
  sleep 8
  live_loop :melody do
    use_synth :fm
    with_fx :echo, phase: 0.1, decay: 0.6 do
      tick(:melody1) if tick % 16 == 0
      play my_loop.look(:melody1).tick(:melody2), release: 0.54, amp: 1 if tempo.tick(:tempo)
      sleep 0.125
    end
  end
end

live_loop :drum_kick do
  with_fx :compressor do
    sample :drum_heavy_kick, amp: 2
  end
  sleep 0.5
end

open1 = chord(:f4, :major)
open2 = chord(:c4, :sus2, invert: 1)
open3 = chord(:c4, :major, invert: 1)


opening = ring open1, open2, open3, open1
opening2 = ring :a5, :c6, :c6, :a5

fadein = (ramp *range(0.5, 1.5, 0.02))

live_loop :open do
  opening.tick(:next)
  with_fx :reverb, room: 0.5 do
    16.times do
      use_synth :piano
      play_chord opening.look(:next), release: 1.5, amp: 2 if spread(5, 16).tick
      use_synth :saw
      play opening2.look(:next), release: 0.25, amp: range(0.3, 2, step: 0.05).look if spread(5, 16).look
      sleep 0.125
    end
  end
end




live_loop :bong do
  sleep 6.5
  sample :drum_splash_soft, rate: -1, amp: 2.2, beat_stretch: 2
end

live_loop :bong2 do
  sleep 8
  sample :ambi_lunar_land, beat_stretch: 4, rate: 0.5, amp: 2.2
end
bass = ring :f2, :g2, :e2, :f2
live_loop :bassline do
  tick(:bass)
  16.times do
    use_synth :chipbass
    play bass.look(:bass), amp: 0.35, release: 0.8 if spread(6, 16).tick
    sleep 0.125
  end
end


in_thread do
  sleep 8
  
  live_loop :tom do
    sample :drum_snare_soft, amp: 2
    sleep 1
  end
  
  live_loop :clap do
    sync :drum
    sample :perc_snap2
    sleep 0.5
  end
  
  live_loop :hihat do
    2.times do
      sample :drum_cymbal_pedal, amp: 2
      sleep 0.25
      sample :drum_cymbal_closed, amp: 2
      sleep 0.25
    end
  end
  
  sleep 8
  live_loop :heavy_kick do
    sample :bd_haus, amp: 2
    sleep 0.5
  end
end


