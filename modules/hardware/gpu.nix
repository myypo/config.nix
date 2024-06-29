{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.myypo.hardware.gpu;
in {
  options.myypo.hardware.gpu = {
    enable = mkEnableOption "enable custom gpu module";

    optimus = {
      enable = mkEnableOption "whether the machine is an optimus laptop";
    };

    dedicatedBrand = mkOption {
      type = types.nullOr (types.enum ["nvidia"]);
      default = null;
    };
    integratedBrand = mkOption {
      type = types.nullOr (types.enum ["intel" "amd"]);
      default = null;
    };

    integratedBusId = mkOption {
      type = types.nullOr types.str;
      default = null;
    };
    dedicatedBusId = mkOption {
      type = types.nullOr types.str;
      default = null;
    };

    integratedDriNum = mkOption {
      type = types.nullOr types.int;
      default = null;
    };
    dedicatedDriNum = mkOption {
      type = types.nullOr types.int;
      default = null;
    };
  };

  config = let
    dedicatedBrand = cfg.dedicatedBrand or "none";
    integratedBrand = cfg.integratedBrand or "none";
  in
    mkIf cfg.enable
    {
      boot = {
        initrd.kernelModules = let
          intelModules =
            if integratedBrand == "intel"
            then ["i915"]
            else [];
        in
          builtins.concatLists [intelModules];

        kernelParams = let
          nvidiaParams =
            if dedicatedBrand == "nvidia"
            then ["nvidia-drm.modeset=1" "nvidia.NVreg_PreserveVideoMemoryAllocations=1"]
            else [];
        in
          builtins.concatLists [nvidiaParams];

        extraModprobeConfig = let
          intelModConfig =
            if integratedBrand == "intel"
            then "options i915"
            else null;

          concat = modConfigs: builtins.concatStringsSep "\n" (builtins.filter (s: s != null) modConfigs);
        in
          concat [intelModConfig];

        # To prevent the audio driver conflicts
        blacklistedKernelModules = ["nouveau" "snd_hda_intel" "snd_soc_skl"];
      };

      hardware = with cfg; {
        nvidia = mkIf (dedicatedBrand == "nvidia") {
          open = false;

          package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

          nvidiaPersistenced = true;

          modesetting.enable = true;

          ### Optimus laptop config ###

          # Requires at least RTX 30xx GPU and Intel 10th gen/AMD Rembrandt
          dynamicBoost.enable = true;

          prime = mkIf optimus.enable {
            sync.enable = true;

            nvidiaBusId = dedicatedBusId;

            # Values here depend on the laptop's model, run:
            # lspci | grep -E 'VGA|3D'
            intelBusId = mkIf (integratedBrand == "intel") integratedBusId;
            amdgpuBusId = mkIf (integratedBrand == "amd") integratedBusId;
          };
        };

        graphics = {
          enable = true;

          extraPackages = with pkgs; let
            intelPkgs =
              if integratedBrand == "intel"
              then [intel-compute-runtime intel-media-driver]
              else [];
          in (builtins.concatLists [intelPkgs]);
        };
      };

      environment = with cfg; let
        combinedVariables = let
          wlrDevices =
            if optimus.enable
            then {
              # Prioritize using integrated graphics for a WM, the values depend on the laptop's model
              WLR_DRM_DEVICES = let
                prior = builtins.toString integratedDriNum;
                backup = builtins.toString dedicatedDriNum;
              in "/dev/dri/card${prior}:/dev/dri/card${backup}";
            }
            else {WLR_DRM_DEVICES = "/dev/dri/card0";};
          nvidiaVariables =
            if dedicatedBrand == "nvidia"
            then {NVD_BACKEND = "direct";}
            else {};
        in
          wlrDevices // nvidiaVariables;
      in {
        variables = combinedVariables;
        sessionVariables = combinedVariables;

        systemPackages = with pkgs; [
          libva
          libva-utils
          glxinfo

          ffmpeg-full
          libva
          libva-utils
          glxinfo
          mesa
          pciutils
          v4l-utils
          vulkan-tools
          vulkan-loader
          vulkan-validation-layers
          vulkan-extension-layer
        ];
      };
    };
}
