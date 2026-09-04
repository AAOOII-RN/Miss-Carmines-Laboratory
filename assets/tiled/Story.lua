return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 800,
  height = 450,
  tilewidth = 1,
  tileheight = 1,
  nextlayerid = 9,
  nextobjectid = 11,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "group",
      id = 4,
      name = "Dining Room",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      layers = {
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 5,
          name = "Scene 1",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["Background"] = "Laboratory",
            ["Bg offset"] = {
              0,
              0
            },
            ["Bg scale"] = {
              0,
              0
            }
          },
          objects = {
            {
              id = 1,
              name = "Speaker",
              type = "",
              shape = "text",
              x = 280,
              y = 304,
              width = 240,
              height = 24,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Miss Carmine",
              fontfamily = "Yeseva One",
              pixelsize = 21,
              wrap = true,
              color = { 255, 87, 87 },
              halign = "center",
              properties = {}
            },
            {
              id = 6,
              name = "Dialogue",
              type = "",
              shape = "text",
              x = 67,
              y = 338,
              width = 664,
              height = 86,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "\"If you lived long enough, stayed steady long enough, and honestly answered my check-ups, I'll say your name, my love.\"",
              fontfamily = "Yeseva One",
              pixelsize = 12,
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 7,
              name = "Line",
              type = "",
              shape = "point",
              x = 400,
              y = 332,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            }
          }
        }
      }
    },
    {
      type = "group",
      id = 7,
      name = "Introduction",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      layers = {
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 8,
          name = "Scene 1",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["Background"] = "Laboratory",
            ["Bg offset"] = {
              0,
              0
            },
            ["Bg scale"] = {
              0,
              0
            }
          },
          objects = {
            {
              id = 8,
              name = "Speaker",
              type = "",
              shape = "text",
              x = 280,
              y = 304,
              width = 240,
              height = 24,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Miss Carmine",
              fontfamily = "Yeseva One",
              pixelsize = 21,
              wrap = true,
              color = { 255, 87, 87 },
              halign = "center",
              properties = {}
            },
            {
              id = 9,
              name = "Dialogue",
              type = "",
              shape = "text",
              x = 67,
              y = 338,
              width = 664,
              height = 86,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "\"If you lived long enough, stayed steady long enough, and honestly answered my check-ups, I'll say your name, my love.\"",
              fontfamily = "Yeseva One",
              pixelsize = 12,
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 10,
              name = "Line",
              type = "",
              shape = "point",
              x = 400,
              y = 332,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            }
          }
        }
      }
    },
    {
      type = "group",
      id = 6,
      name = "Main Menu",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      layers = {
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 2,
          name = "Main Menu",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["Background"] = "",
            ["Bg offset"] = {
              0,
              0
            },
            ["Bg scale"] = {
              0,
              0
            }
          },
          objects = {
            {
              id = 2,
              name = "Test Button",
              type = "ButtonGoto",
              shape = "rectangle",
              x = 305,
              y = 167,
              width = 190,
              height = 116,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["color"] = "red",
                ["goto"] = "game",
                ["icon"] = "",
                ["roundness"] = 16
              }
            },
            {
              id = 3,
              name = "",
              type = "",
              shape = "text",
              x = 305,
              y = 167,
              width = 190,
              height = 55,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "00000000000000000",
              fontfamily = "Yeseva One",
              pixelsize = 18,
              wrap = true,
              halign = "center",
              properties = {}
            }
          }
        }
      }
    }
  }
}
