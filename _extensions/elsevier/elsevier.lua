local function setBibStyle(meta, style) 
  meta['biblio-style'] = style
  quarto.doc.addFormatResource('bib/' .. style .. '.bst')
end

local function addClassOption(meta, option)
  if meta['classoption'] == nil then
    meta['classoption'] = pandoc.List({})
  end

  if not meta['classoption']:includes(option) then
    meta['classoption']:insert(option)
  end
end

local function printList(list) 
  local result = ''
  local sep = ''
  for i,v in ipairs(list) do
    result = result .. sep .. v
    sep = ', '
  end
  return result
end

-- cite style constants
local kBibStyleAuthYr = 'elsarticle-harv'
local kBibStyleNumber = 'elsarticle-num'
local kBibStyleNumberName = 'elsarticle-num-names'
local kBibStyleUnknown = kBibStyleNumberName

local kBibStyleDefault = 'numberednames'
local kBibStyles = {'numbered','numberednames','authoryear'}

local kLayouts = pandoc.List({'preprint', 'review', 'doubleblind'})
local kTypes = pandoc.List({'1p', '3p', '5p'})

return {
    {
      Meta = function(meta)
        -- If citeproc is being used, switch to the proper
        -- CSL file
        if quarto.doc.citeMethod() == 'citeproc' and meta['csl'] == nil then
            meta['csl'] = quarto.path.resolve('elsevier-harvard.csl')
        end


        if quarto.doc.isFormat("pdf") then
          -- read the journal settings
          local journal = meta['journal']
          local citestyle = nil
          local layout = nil 
          local jType = nil
          local longtitle = false
          local endfloat = false

          if journal ~= nil then         
            citestyle = journal['cite-style']
            layout = journal['layout']
            jType = journal['type']

            longtitle = journal['longtitle'] ~= nil and journal['longtitle']
            endfloat = journal['endfloat'] ~= nil and journal['endfloat']
          end

          -- process the site style
          if citestyle ~= nil then
            citestyle = pandoc.utils.stringify(citestyle)
          else 
            citestyle = kBibStyleDefault
          end

          if citestyle == 'authoryear' then
            setBibStyle(meta, kBibStyleAuthYr)
          elseif citestyle == 'numbered' then
            setBibStyle(meta, kBibStyleNumber)
          elseif citestyle == 'numberednames' then
            setBibStyle(meta, kBibStyleNumberName)
          else 
            error("Unknown journal cite-style " .. citestyle .. "\nPlease use one of " .. printList(kBibStyles))
            setBibStyle(meta, kBibStyleUnknown)
          end

          -- process the layout
          if layout ~= nil then
            layout = pandoc.utils.stringify(layout)
            if kLayouts:includes(layout) then
              addClassOption(meta, layout)
            else
              error("Unknown journal layout " .. layout .. "\nPlease use one of " .. printList(kLayouts))
            end
          end

          -- process the type
          if jType ~= nil then
            jType = pandoc.utils.stringify(jType)
            if kTypes:includes(jType) then
              addClassOption(meta, jType)
            else
              error("Unknown journal type " .. jType .. "\nPlease use one of " .. printList(kTypes))
            end
          end

          -- allow long titles
          if longtitle then
            addClassOption(meta, 'longtitle')
          end

          -- allow endfloat
          if endfloat then
            quarto.doc.useLatexPackage('endfloat')
            addClassOption(meta, 'endfloat')
          end

        end

        return meta
      end
    }
  }
  



  