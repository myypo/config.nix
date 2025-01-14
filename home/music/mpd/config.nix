{ }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    extraConfig = ''
      audio_output {
          type            "pipewire"
          name            "PipeWire Sound Server"
      }
    '';
  };
}
