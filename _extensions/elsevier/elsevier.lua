local function setBibStyle(meta, style) 
  meta['biblio-style'] = style
  quarto.doc.addFormatResource('bib/' .. style .. '.bst')
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
        if journal ~= nil then         
          local citestyle = journal['cite-style']
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


        return meta
      end
    }
  }
  



  