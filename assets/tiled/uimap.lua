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
  nextlayerid = 3,
  nextobjectid = 3,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Blank",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["base_color"] = "peach1",
        ["design_color"] = "brown1"
      },
      objects = {
        {
          id = 1,
          name = "Button",
          type = "ButtonGoto",
          shape = "rectangle",
          x = 278,
          y = 182,
          width = 202,
          height = 121,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["color"] = "",
            ["goto"] = "Blank",
            ["icon"] = "",
            ["roundness"] = 16
          }
        },
        {
          id = 2,
          name = "Display",
          type = "Placeholder",
          shape = "rectangle",
          x = 40,
          y = 40,
          width = 121,
          height = 121,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["color"] = "",
            ["icon"] = "",
            ["roundness"] = 16
          }
        }
      }
    }
  }
}
