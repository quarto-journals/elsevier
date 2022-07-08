return {
    {
      Meta = function(meta)
        -- If citeproc is being used, switch to the proper
        -- CSL file
        if quarto.doc.citeMethod() == 'citeproc' and meta['csl'] == nil then
            meta['csl'] = quarto.path.resolve('elsevier-harvard.csl')
        end
        return meta
      end
    }
  }
  
  