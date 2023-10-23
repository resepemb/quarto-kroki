-- Default Kroki service URL
local krokiServiceUrl = "https://kroki.io"
local metadata

local function makeUrl(diagramText, diagramType, diagramFormat)

  local LibDeflate = require("LibDeflate")

  local compressed = LibDeflate:CompressZlib(diagramText, {level = 9})

  if compressed ~= nil then
      local encoded = quarto.base64.encode(compressed)
      encoded = string.gsub(encoded,'/', '_').gsub(encoded,'+','-')

      local url = krokiServiceUrl.."/"..diagramType.."/"..diagramFormat.."/"..encoded

      return url
  end  
  
  return ""
end    

return {
  {
    Meta =function(meta)
      metadata = meta
    end
  },
  {
    CodeBlock = function(el)
      if el.attr == nil then
        return el
      end
      
      if metadata.kroki ~= nil and metadata.kroki.serviceUrl ~= nil and metadata.kroki.serviceUrl[1] ~= nil then
        krokiServiceUrl = metadata.kroki.serviceUrl[1]['text']
      end
      
      local arg =el.attr.classes[1]
      local args = pandoc.List()
    
      for i in string.gmatch(arg, "%a+") do
         pandoc.List.insert(args,i)
      end
    
      if (not args[1] == "kroki") or (args[2] == nil) then
        return el
      end
    
      local diagramType = args[2]
    
      local diagramFormat = "svg"
    
      if(args[3] ~= nil) then
        diagramFormat = args[3]
      end
      
      el =  pandoc.Image('Diagram',makeUrl(el.text, diagramType, diagramFormat))
      
      return el
    end
  },
  
}


