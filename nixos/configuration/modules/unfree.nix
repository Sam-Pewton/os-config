{ config, lib, pkgs, ... }:

{
  imports = [];

  # Unfree
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # CUDA
      "cuda-merged"
      "cuda_cuobjdump"
      "cuda_gdb"
      "cuda_nvcc"
      "cuda_nvdisasm"
      "cuda_nvprune"
      "cuda_cccl"
      "cuda_cudart"
      "cuda_cupti"
      "cuda_cuxxfilt"
      "cuda_nvml_dev"
      "cuda_nvrtc"
      "cuda_nvtx"
      "cuda_profiler_api"
      "cuda_sanitizer_api"
      "libcublas"
      "libcufft"
      "libcurand"
      "libcusolver"
      "libnvjitlink"
      "libcusparse"
      "libnpp"
      # Discord
      "discord"
      # Nvidia Drivers
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      # Obsidian
      "obsidian"
      # Postman
      "postman"
      # Spotify
      "spotify"
      # Steam
      "steam"
      "steam-original"
    ];
}
