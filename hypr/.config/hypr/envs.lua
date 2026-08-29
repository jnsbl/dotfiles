-- Extra environment variables (loaded from hyprland.lua, after Omarchy's
-- defaults). Relaunch Hyprland after changing these.

-- Force the Intel iHD VAAPI driver for video acceleration. Omarchy's
-- default/hypr/nvidia.lua only sets LIBVA_DRIVER_NAME on NVIDIA GSP GPUs, and
-- this is a hybrid-graphics laptop where the iGPU should do decode.
hl.env("LIBVA_DRIVER_NAME", "iHD")
