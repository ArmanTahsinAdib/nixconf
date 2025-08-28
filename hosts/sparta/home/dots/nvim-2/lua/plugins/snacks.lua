return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      prompt = "   ",
      cwd = true,
      layout = {
        preset = "telescope",
      },
    },
    dashboard = {
      preset = {
        header = [[

                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████

]],
      },
      styles = {
        dashboard = {
          wo = {
            winhighlight = "Normal:SnacksDashBoardHeader",
          },
        },
      },
    },
    image = {
      formats = {
        "svg",
        "png",
        "jpg",
        "jpeg",
        "gif",
        "bmp",
        "webp",
        "tiff",
        "heic",
        "avif",
        "mp4",
        "mov",
        "avi",
        "mkv",
        "webm",
        "pdf",
      },
      doc = {
        lang = { "markdown", "norg", "tsx", "javascript", "css", "vue", "angular", "html", "svg" },
        inline = false,
        max_width = 40,
        max_height = 10,
      },
    },
  },
}
