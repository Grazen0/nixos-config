{
  config,
  lib,
  pkgs,
  ...
}: let
  /*
   *
  * Given a list of `options`, concats the result of mapping each options
  * to a menuentry for use in grub.
  *
  *  * defaults: {name, image, params, initrd}
  *  * options: [ option... ]
  *  * option: {name, params, class}
  */
  menuBuilderGrub2 = defaults: options:
    lib.concatStrings
    (
      map
      (option: ''
        menuentry '${defaults.name} ${
          # Name appended to menuentry defaults to params if no specific name given.
          option.name or (lib.optionalString (option ? params) "(${option.params})")
        }' ${lib.optionalString (option ? class) " --class ${option.class}"} {
          # Fallback to UEFI console for boot, efifb sometimes has difficulties.
          terminal_output console

          linux ${defaults.image} ${defaults.params} ${option.params or ""} \''${isoboot}
          initrd ${defaults.initrd}
        }
      '')
      options
    );

  buildMenuGrub2 = buildMenuAdditionalParamsGrub2 "";

  targetArch =
    if config.boot.loader.grub.forcei686
    then "ia32"
    else pkgs.stdenv.hostPlatform.efiArch;

  buildMenuAdditionalParamsGrub2 = additional: let
    finalCfg = {
      name = "${config.isoImage.prependToMenuLabel}${config.system.nixos.distroName} ${config.system.nixos.label}${config.isoImage.appendToMenuLabel}";
      params = "init=${config.system.build.toplevel}/init ${additional} ${toString config.boot.kernelParams}";
      image = "/boot/${config.system.boot.loader.kernelFile}";
      initrd = "/boot/initrd";
    };
  in
    menuBuilderGrub2
    finalCfg
    [
      {class = "installer";}
      {
        class = "nomodeset";
        params = "nomodeset";
      }
      {
        class = "copytoram";
        params = "copytoram";
      }
      {
        class = "debug";
        params = "debug";
      }
    ];

  syslinuxTimeout =
    if config.boot.loader.timeout == null
    then 35996
    else config.boot.loader.timeout * 10;

  grubEfiTimeout =
    if config.boot.loader.timeout == null
    then -1
    else config.boot.loader.timeout;

  baseIsolinuxCfg = ''
    SERIAL 0 115200
    TIMEOUT ${builtins.toString syslinuxTimeout}
    UI vesamenu.c32
    MENU BACKGROUND /isolinux/background.png

    ${config.isoImage.syslinuxTheme}

    DEFAULT boot

    LABEL boot
    MENU LABEL ${config.isoImage.prependToMenuLabel}${config.system.nixos.distroName} ${config.system.nixos.label}${config.isoImage.appendToMenuLabel}
    LINUX /boot/${config.system.boot.loader.kernelFile}
    APPEND init=${config.system.build.toplevel}/init ${toString config.boot.kernelParams}
    INITRD /boot/${config.system.boot.loader.initrdFile}

    # A variant to boot with 'nomodeset'
    LABEL boot-nomodeset
    MENU LABEL ${config.isoImage.prependToMenuLabel}${config.system.nixos.distroName} ${config.system.nixos.label}${config.isoImage.appendToMenuLabel} (nomodeset)
    LINUX /boot/${config.system.boot.loader.kernelFile}
    APPEND init=${config.system.build.toplevel}/init ${toString config.boot.kernelParams} nomodeset
    INITRD /boot/${config.system.boot.loader.initrdFile}

    # A variant to boot with 'copytoram'
    LABEL boot-copytoram
    MENU LABEL ${config.isoImage.prependToMenuLabel}${config.system.nixos.distroName} ${config.system.nixos.label}${config.isoImage.appendToMenuLabel} (copytoram)
    LINUX /boot/${config.system.boot.loader.kernelFile}
    APPEND init=${config.system.build.toplevel}/init ${toString config.boot.kernelParams} copytoram
    INITRD /boot/${config.system.boot.loader.initrdFile}

    # A variant to boot with verbose logging to the console
    LABEL boot-debug
    MENU LABEL ${config.isoImage.prependToMenuLabel}${config.system.nixos.distroName} ${config.system.nixos.label}${config.isoImage.appendToMenuLabel} (debug)
    LINUX /boot/${config.system.boot.loader.kernelFile}
    APPEND init=${config.system.build.toplevel}/init ${toString config.boot.kernelParams} loglevel=7
    INITRD /boot/${config.system.boot.loader.initrdFile}

    # A variant to boot with a serial console enabled
    LABEL boot-serial
    MENU LABEL ${config.isoImage.prependToMenuLabel}${config.system.nixos.distroName} ${config.system.nixos.label}${config.isoImage.appendToMenuLabel} (serial console=ttyS0,115200n8)
    LINUX /boot/${config.system.boot.loader.kernelFile}
    APPEND init=${config.system.build.toplevel}/init ${toString config.boot.kernelParams} console=ttyS0,115200n8
    INITRD /boot/${config.system.boot.loader.initrdFile}
  '';

  isolinuxMemtest86Entry = ''
    LABEL memtest
    MENU LABEL Memtest86+
    LINUX /boot/memtest.bin
    APPEND ${toString config.boot.loader.grub.memtest86.params}
  '';

  isolinuxCfg =
    lib.concatStringsSep "\n"
    ([baseIsolinuxCfg] ++ lib.optional config.boot.loader.grub.memtest86.enable isolinuxMemtest86Entry);

  refindBinary =
    if targetArch == "x64" || targetArch == "aa64"
    then "refind_${targetArch}.efi"
    else null;

  # Setup instructions for rEFInd.
  refind =
    if refindBinary != null
    then ''
      # Adds rEFInd to the ISO.
      cp -v ${pkgs.refind}/share/refind/${refindBinary} $out/EFI/BOOT/
    ''
    else "# No refind for ${targetArch}";

  grubPkgs =
    if config.boot.loader.grub.forcei686
    then pkgs.pkgsi686Linux
    else pkgs;

  grubMenuCfg = ''
    #
    # Menu configuration
    #

    # Search using a "marker file"
    search --set=root --file /EFI/nixos-installer-image

    insmod gfxterm
    insmod png
    set gfxpayload=keep
    set gfxmode=${lib.concatStringsSep "," [
      #"3840x2160"
      #"2560x1440"
      "1920x1200"
      "1920x1080"
      "1366x768"
      "1280x800"
      "1280x720"
      "1200x1920"
      "1024x768"
      "800x1280"
      "800x600"
      "auto"
    ]}

    if [ "\$textmode" == "false" ]; then
      terminal_output gfxterm
      terminal_input  console
    else
      terminal_output console
      terminal_input  console
      # Sets colors for console term.
      set menu_color_normal=cyan/blue
      set menu_color_highlight=white/blue
    fi

    ${
      if config.isoImage.grubTheme != null
      then ''
        # Sets theme.
        set theme=(\$root)/EFI/BOOT/grub-theme/theme.txt
        # Load theme fonts
        $(find ${config.isoImage.grubTheme} -iname '*.pf2' -printf "loadfont (\$root)/EFI/BOOT/grub-theme/%P\n")
      ''
      else ''
        if background_image (\$root)/EFI/BOOT/efi-background.png; then
          # Black background means transparent background when there
          # is a background image set... This seems undocumented :(
          set color_normal=black/black
          set color_highlight=white/blue
        else
          # Falls back again to proper colors.
          set menu_color_normal=cyan/blue
          set menu_color_highlight=white/blue
        fi
      ''
    }
  '';

  efiDir =
    pkgs.runCommand "efi-directory" {
      nativeBuildInputs = [pkgs.buildPackages.grub2_efi];
      strictDeps = true;
    } ''
      mkdir -p $out/EFI/BOOT

      touch $out/EFI/nixos-installer-image

      MODULES=(
        # Basic modules for filesystems and partition schemes
        "fat"
        "iso9660"
        "part_gpt"
        "part_msdos"

        # Basic stuff
        "normal"
        "boot"
        "linux"
        "configfile"
        "loopback"
        "chain"
        "halt"

        # Allows rebooting into firmware setup interface
        "efifwsetup"

        # EFI Graphics Output Protocol
        "efi_gop"

        # User commands
        "ls"

        # System commands
        "search"
        "search_label"
        "search_fs_uuid"
        "search_fs_file"
        "echo"

        # We're not using it anymore, but we'll leave it in so it can be used
        # by user, with the console using "C"
        "serial"

        # Graphical mode stuff
        "gfxmenu"
        "gfxterm"
        "gfxterm_background"
        "gfxterm_menu"
        "test"
        "loadenv"
        "all_video"
        "videoinfo"

        # File types for graphical mode
        "png"
      )

      echo "Building GRUB with modules:"
      for mod in ''${MODULES[@]}; do
        echo " - $mod"
      done

      # Modules that may or may not be available per-platform.
      echo "Adding additional modules:"
      for mod in efi_uga; do
        if [ -f ${grubPkgs.grub2_efi}/lib/grub/${grubPkgs.grub2_efi.grubTarget}/$mod.mod ]; then
          echo " - $mod"
          MODULES+=("$mod")
        fi
      done

      # Make our own efi program, we can't rely on "grub-install" since it seems to
      # probe for devices, even with --skip-fs-probe.
      grub-mkimage \
        --directory=${grubPkgs.grub2_efi}/lib/grub/${grubPkgs.grub2_efi.grubTarget} \
        -o $out/EFI/BOOT/BOOT${lib.toUpper targetArch}.EFI \
        -p /EFI/BOOT \
        -O ${grubPkgs.grub2_efi.grubTarget} \
        ''${MODULES[@]}
      cp ${grubPkgs.grub2_efi}/share/grub/unicode.pf2 $out/EFI/BOOT/

      cat <<EOF > $out/EFI/BOOT/grub.cfg

      set textmode=${lib.boolToString (config.isoImage.forceTextMode)}
      set timeout=${toString grubEfiTimeout}

      clear
      # This message will only be viewable on the default (UEFI) console.
      echo ""
      echo "Loading graphical boot menu..."
      echo ""
      echo "Press 't' to use the text boot menu on this console..."
      echo ""

      ${grubMenuCfg}

      hiddenentry 'Text mode' --hotkey 't' {
        loadfont (\$root)/EFI/BOOT/unicode.pf2
        set textmode=true
        terminal_output console
      }

      ${lib.optionalString (config.isoImage.grubTheme != null) ''
        hiddenentry 'GUI mode' --hotkey 'g' {
          $(find ${config.isoImage.grubTheme} -iname '*.pf2' -printf "loadfont (\$root)/EFI/BOOT/grub-theme/%P\n")
          set textmode=false
          terminal_output gfxterm
        }
      ''}

      # If the parameter iso_path is set, append the findiso parameter to the kernel
      # line. We need this to allow the nixos iso to be booted from grub directly.
      if [ \''${iso_path} ] ; then
        set isoboot="findiso=\''${iso_path}"
      fi

      #
      # Menu entries
      #

      ${buildMenuGrub2}
      submenu "HiDPI, Quirks and Accessibility" --class hidpi --class submenu {
        ${grubMenuCfg}
        submenu "Suggests resolution @720p" --class hidpi-720p {
          ${grubMenuCfg}
          ${buildMenuAdditionalParamsGrub2 "video=1280x720@60"}
        }
        submenu "Suggests resolution @1080p" --class hidpi-1080p {
          ${grubMenuCfg}
          ${buildMenuAdditionalParamsGrub2 "video=1920x1080@60"}
        }

        # If we boot into a graphical environment where X is autoran
        # and always crashes, it makes the media unusable. Allow the user
        # to disable this.
        submenu "Disable display-manager" --class quirk-disable-displaymanager {
          ${grubMenuCfg}
          ${buildMenuAdditionalParamsGrub2 "systemd.mask=display-manager.service"}
        }

        # Some laptop and convertibles have the panel installed in an
        # inconvenient way, rotated away from the keyboard.
        # Those entries makes it easier to use the installer.
        submenu "" {return}
        submenu "Rotate framebuffer Clockwise" --class rotate-90cw {
          ${grubMenuCfg}
          ${buildMenuAdditionalParamsGrub2 "fbcon=rotate:1"}
        }
        submenu "Rotate framebuffer Upside-Down" --class rotate-180 {
          ${grubMenuCfg}
          ${buildMenuAdditionalParamsGrub2 "fbcon=rotate:2"}
        }
        submenu "Rotate framebuffer Counter-Clockwise" --class rotate-90ccw {
          ${grubMenuCfg}
          ${buildMenuAdditionalParamsGrub2 "fbcon=rotate:3"}
        }

        # As a proof of concept, mainly. (Not sure it has accessibility merits.)
        submenu "" {return}
        submenu "Use black on white" --class accessibility-blakconwhite {
          ${grubMenuCfg}
          ${buildMenuAdditionalParamsGrub2 "vt.default_red=0xFF,0xBC,0x4F,0xB4,0x56,0xBC,0x4F,0x00,0xA1,0xCF,0x84,0xCA,0x8D,0xB4,0x84,0x68 vt.default_grn=0xFF,0x55,0xBA,0xBA,0x4D,0x4D,0xB3,0x00,0xA0,0x8F,0xB3,0xCA,0x88,0x93,0xA4,0x68 vt.default_blu=0xFF,0x58,0x5F,0x58,0xC5,0xBD,0xC5,0x00,0xA8,0xBB,0xAB,0x97,0xBD,0xC7,0xC5,0x68"}
        }

        # Serial access is a must!
        submenu "" {return}
        submenu "Serial console=ttyS0,115200n8" --class serial {
          ${grubMenuCfg}
          ${buildMenuAdditionalParamsGrub2 "console=ttyS0,115200n8"}
        }
      }

      ${lib.optionalString (refindBinary != null) ''
        # GRUB apparently cannot do "chainloader" operations on "CD".
        if [ "\$root" != "cd0" ]; then
          menuentry 'rEFInd' --class refind {
            # Force root to be the FAT partition
            # Otherwise it breaks rEFInd's boot
            search --set=root --no-floppy --fs-uuid 1234-5678
            chainloader (\$root)/EFI/BOOT/${refindBinary}
          }
        fi
      ''}
      menuentry 'Firmware Setup' --class settings {
        fwsetup
        clear
        echo ""
        echo "If you see this message, your EFI system doesn't support this feature."
        echo ""
      }
      menuentry 'Shutdown' --class shutdown {
        halt
      }
      EOF

      grub-script-check $out/EFI/BOOT/grub.cfg

      ${refind}
    '';

  efiImg =
    pkgs.runCommand "efi-image_eltorito" {
      nativeBuildInputs = [pkgs.buildPackages.mtools pkgs.buildPackages.libfaketime pkgs.buildPackages.dosfstools];
      strictDeps = true;
    }
    # Be careful about determinism: du --apparent-size,
    #   dates (cp -p, touch, mcopy -m, faketime for label), IDs (mkfs.vfat -i)
    ''
      mkdir ./contents && cd ./contents
      mkdir -p ./EFI/BOOT
      cp -rp "${efiDir}"/EFI/BOOT/{grub.cfg,*.EFI,*.efi} ./EFI/BOOT

      # Rewrite dates for everything in the FS
      find . -exec touch --date=2000-01-01 {} +

      # Round up to the nearest multiple of 1MB, for more deterministic du output
      usage_size=$(( $(du -s --block-size=1M --apparent-size . | tr -cd '[:digit:]') * 1024 * 1024 ))
      # Make the image 110% as big as the files need to make up for FAT overhead
      image_size=$(( ($usage_size * 110) / 100 ))
      # Make the image fit blocks of 1M
      block_size=$((1024*1024))
      image_size=$(( ($image_size / $block_size + 1) * $block_size ))
      echo "Usage size: $usage_size"
      echo "Image size: $image_size"
      truncate --size=$image_size "$out"
      mkfs.vfat --invariant -i 12345678 -n EFIBOOT "$out"

      # Force a fixed order in mcopy for better determinism, and avoid file globbing
      for d in $(find EFI -type d | sort); do
        faketime "2000-01-01 00:00:00" mmd -i "$out" "::/$d"
      done

      for f in $(find EFI -type f | sort); do
        mcopy -pvm -i "$out" "$f" "::/$f"
      done

      # Verify the FAT partition.
      fsck.vfat -vn "$out"
    ''; # */
in {
  isoImage.contents =
    [
      {
        source = config.boot.kernelPackages.kernel + "/" + config.system.boot.loader.kernelFile;
        target = "/boot/" + config.system.boot.loader.kernelFile;
      }
      {
        source = config.system.build.initialRamdisk + "/" + config.system.boot.loader.initrdFile;
        target = "/boot/" + config.system.boot.loader.initrdFile;
      }
      {
        source = pkgs.writeText "version" config.system.nixos.label;
        target = "/version.txt";
      }
    ]
    ++ lib.optionals (config.isoImage.makeBiosBootable) [
      {
        source = config.isoImage.splashImage;
        target = "/isolinux/background.png";
      }
      {
        source = pkgs.writeText "isolinux.cfg" isolinuxCfg;
        target = "/isolinux/isolinux.cfg";
      }
      {
        source = "${pkgs.syslinux}/share/syslinux";
        target = "/isolinux";
      }
    ]
    ++ lib.optionals config.isoImage.makeEfiBootable [
      {
        source = efiImg;
        target = "/boot/efi.img";
      }
      {
        source = "${efiDir}/EFI";
        target = "/EFI";
      }
      {
        source = (pkgs.writeTextDir "grub/loopback.cfg" "source /EFI/BOOT/grub.cfg") + "/grub";
        target = "/boot/grub";
      }
      {
        source = config.isoImage.efiSplashImage;
        target = "/EFI/BOOT/efi-background.png";
      }
    ]
    ++ lib.optionals (config.boot.loader.grub.memtest86.enable && config.isoImage.makeBiosBootable) [
      {
        source = "${pkgs.memtest86plus}/memtest.bin";
        target = "/boot/memtest.bin";
      }
    ]
    ++ lib.optionals (config.isoImage.grubTheme != null) [
      {
        source = config.isoImage.grubTheme;
        target = "/EFI/BOOT/grub-theme";
      }
    ];
}
