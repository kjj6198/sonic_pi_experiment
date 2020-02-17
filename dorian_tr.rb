
use_bpm 100
temple = spread 5, 8


live_loop :bass_drum do
  if (spread 1, 4).tick then
    with_fx :sound_out do
      sample :bd_tek, attack: 0, release: 1, amp: 1.5, cutoff: 80
    end
  end
  sleep 0.25
end

live_loop :kick do
  if (spread 2, 16).tick then
    sample :bd_fat, amp: 1
  end
  sleep 0.25
end

live_loop :pattern1 do
  use_synth :tri
  if (spread 5, 8).tick then
    with_fx :reverb do
      play scale(:a, :dorian).choose, amp: 0.45, release: 0.4
    end
  end
  sleep 0.25
end

live_loop :bassline do
  sync :kick
  if (spread 1, 8).tick then
    use_synth :subpulse
    play :a3
    sleep 0.25
    play :a3
  end
  sleep 0.5
end

