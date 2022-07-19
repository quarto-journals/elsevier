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

-- cite style constants
local kBibStyleAuthYr = 'elsarticle-harv'
local kBibStyleNumber = 'elsarticle-num'
local kBibStyleNumberName = 'elsarticle-num-names'
local kBibStyleUnknown = kBibStyleNumberName

local kBibStyleDefault = 'numberednames'

return {
    {
      Meta = function(meta)
        -- If citeproc is being used, switch to the proper
        -- CSL file
        if quarto.doc.citeMethod() == 'citeproc' and meta['csl'] == nil then
            meta['csl'] = quarto.path.resolve('elsevier-harvard.csl')
        end

        -- read the journal settings
        local journal = meta['journal']
        local citestyle = nil
        local layout = nil 
        if journal ~= nil then         
          citestyle = journal['cite-style']
          layout = journal['layout']
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
          setBibStyle(meta, kBibStyleUnknown)
        end

        -- process the layout
        if layout ~= nil then
          layout = pandoc.utils.stringify(layout)
          addClassOption(layout)
        end

        return meta
      end
    }
  }
  



  