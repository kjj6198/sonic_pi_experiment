use_bpm 50

melody = ring([:a5, :c6, :a5, :a5, :c6, :a5, :a5, :c6, :a5, :b5, :a5, :g5])
##| chord_for_melody = ring [:e5, ]

tempo = ring([true, false, false, true, false, false, true, false, true, false, false, true, false, false, true, false,true, false, false, true, false, false, true, false, true, false, false, true, false, false, true, false])
amps = ring([0.8, 0.2, 0.2, 0.8, 0.2, 0.2, 0.8, 0.2])

live_loop :snare do
  if spread(8,8) then
    sample :drum_cymbal_closed, amp: [0.8, 0.2].choose()
    sleep 0.125
  end
end



live_loop :kick do
  with_fx :sound_out_stereo do
    sample :bd_tek
    sleep 0.5
  end
end

live_loop :baseline do
  with_fx :reverb do
    current_index = 0
    tempo.tick.each_with_index do |t, i|
      if (t) then
        puts current_index
        play melody.tick[current_index], release: 0.1
        current_index += 1
      end
      sleep 0.125
    end
  end
end