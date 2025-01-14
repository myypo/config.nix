{ ... }:
{
  boot = {
    consoleLogLevel = 0;

    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    kernelParams = [
      "quiet"
      # Disable success messages
      "systemd.show_status=auto"
    ];

    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      timeout = 3;
    };
  };
}
