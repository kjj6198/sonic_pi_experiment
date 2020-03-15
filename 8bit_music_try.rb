use_bpm 50

define :gen_ring do |ring_str|
  return ring(*ring_str.split("").map{|s| s == '*'})
end

ring1 = gen_ring("--**-*-**-*-*---")
ring2 = gen_ring("--**-*-**-*-*-**")
ring3 = gen_ring("--*-*---*-**-**-")
ring4 = gen_ring("-*-*-*-**---*---")
ring5 = ring1
ring6 = gen_ring("--**-*-**-*-*-*-")
ring7 = gen_ring("--*-*---*-**-**-")
ring8 = gen_ring("--*-*-**--------")

melody1 = ring(:e5, :e5, :e5, :e5, :f5, :d5, :e5)
melody2 = ring(:e5, :e5, :e5, :e5, :f5, :g5, :eb5, :d5, :c5)
melody3 = ring(:c5, :c6, :ab5, :c6, :ab5, :g5, :f5)
melody4 = ring(:e5, :d5, :b4, :d5, :c5, :g4)
melody5 = melody1
melody6 = ring(:e5, :e5, :e5, :e5, :f5, :g5, :c6, :ab5)
melody7 = ring(:g5, :eb6, :d6, :e6, :d6, :c6, :g5)
melody8 = ring(:g5, :a5, :g5, :c6)

ring3 = ring(
  false, false, true, false,
  true, false, false, false,
  true, false, true, true,
  false, true, true, false
)

define :play_melody do |ring, melody|
  if ring.tick then
    use_synth :pulse
    play melody.tick("melody" + get[:my_run].to_s), release: 0.23
  end
end

define :run_melody do |run|
  if (run == 1) then
    play_melody ring1, melody1
  end
  
  if (run == 2) then
    play_melody ring2, melody2
  end
  
  if (run == 3) then
    play_melody ring3, melody3
  end
  
  if (run == 4) then
    play_melody ring4, melody4
  end
  
  if (run == 5) then
    play_melody ring5, melody5
  end
  
  if (run == 6) then
    play_melody ring6, melody6
  end
  
  if (run == 7) then
    play_melody ring7, melody7
  end
  
  if (run == 8) then
    play_melody ring8, melody8
  end
end

live_loop :melody do
  puts get[:my_run]
  run_melody get[:my_run]
  sleep 0.125
end


my_run = 1

live_loop :runner do
  set :my_run, my_run
  my_run += 1
  my_run = my_run > 8 ? 1 : my_run
  sleep 2
end

live_loop :drum do
  
  if get[:my_run] == 4 || get[:my_run] == 8 then
    use_synth :noise
    play release: 0.25, amp: 0.2 if spread(6, 16).tick
    sleep 0.125
  else
    if spread(8, 16).tick
      sample :drum_heavy_kick
    else
      sample :drum_heavy_kick
      use_synth :noise
      play release: 0.25, amp: 0.2
    end
    sleep 0.25
  end
end

live_loop :pattern do
  use_synth :pulse
  
  if get[:my_run] == 1 || get[:my_run] == 2  || get[:my_run] == 5 || get[:my_run] == 6
    play chord(:c3, :major).tick, release: 0.25, amp: 0.3
    sleep 0.5 / 4
  end
  
  if get[:my_run] == 3
    8.times do
      play chord(:f3, :major).tick, release: 0.25, amp: 0.3
      sleep 0.5 / 4
    end
    
    8.times do
      play chord(:bb3, :sus4).tick, release: 0.25, amp: 0.3
      sleep 0.5 / 4
    end
  end
  
  if get[:my_run] == 4
    play chord(:g3, '7'), release: 0.35, amp: 0.3
    sleep 1
    play chord(:c3, :major), release: 0.35, amp: 0.3
    sleep 1
  end
  
  if get[:my_run] >= 7 then
    sleep 4
  end
  
end
