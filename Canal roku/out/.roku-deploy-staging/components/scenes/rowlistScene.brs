sub init()
    m.category_list = m.top.findNode("category_list")
    m.rowlist = m.top.findNode("rowlist")
    m.labelName = m.top.findNode("simpleLabelName")
    m.labelDescription = m.top.findNode("LabelDescription")
    m.rowlist.observeField("rowItemFocused" , "onRowItemFocused")
    m.rowlist.observeField("rowItemSelected" , "onrowItemSelected")
    m.httpTask = createObject("roSGNode","httpTask")
    m.httpTask.observeField("response", "onHttpResponse")
    m.top.observeField("focusedChild", "onFocusChanged")



    
    m.httpTask.control = "run"
end sub

    sub onHttpResponse(event as object)
        response = event.getData()
        print "Thread SG: onHttpResponse", response
        setGrid(response.content)
        m.httpTask.control = "stop"
        m.httpTask = invalid
    end sub
    
 function getUIResolution()
        di =createObject("roDeviceInfo")
        return di.getUIResolution()
        end function
    
 sub setGrid(content as object)
            r = getUIResolution()
            rows = 3
            cols = 3
            gridw = r.width * 0.8
            gridh = r.height * 0.8
    
            cellw = gridw / cols
            cellh = gridh / rows
    
            gapx = gridw * 0.02
            gapy = gridh * 0.02
    
            itemw = cellw-gapx
            itemh = cellh-gapy
    
            ix = (r.width - gridw) * 3.0
            iy = (r.height - gridh) * 1.5
    
            print itemw , itemh
            m.labelName.translation = [ix, iy - cellh * 0.5]
            m.labelDescription.translation = [ix, iy - cellh * -3.5]
            m.rowlist.itemComponentName = "baseItem"
            m.rowlist.rowFocusAnimationStyle = "fixedFocus"
            m.rowlist.drawFocusFeedback = "true"
            m.rowlist.translation = [ix,iy]
            m.rowlist.numRows = rows
            m.rowlist.itemSize = [gridw , cellh]
            m.rowlist.rowItemSize = [itemw,itemh]
            m.rowlist.rowItemSpacing = [gapx,0]
            m.rowlist.ItemSpacing = [0,gapy]
            m.rowlist.content = content
            'm.rowlist.setFocus(true)
        end sub

        sub onFocusChanged()
            if m.top.hasFocus()
                m.category_list.setFocus(true)
            end if
        end sub
    
sub onRowItemFocused(event as object)
            rowItemIndex = event.getData()
            content = m.rowlist.content
            rowContent = content.getChild(rowItemIndex[0])
            itemContent = rowContent.getChild(rowItemIndex[1])
            m.labelName.text = itemContent.TEXTOVERLAYUL
            m.labelDescription.text = itemContent.description
           print "onRowItemSelected" , formatJson(rowItemIndex) , itemContent
        end sub
    
sub onRowItemSelected(event as object)
    rowItemIndex = event.getData()
    content = m.rowlist.content
    rowContent = content.getChild(rowItemIndex[1])
    itemContent = rowContent.getChild(rowItemIndex[0])
    m.labelName.text = itemContent.TEXTOVERLAYUL
    m.labelDescription.text = itemContent.description
   'print "onRowItemSelected" , formatJson(rowItemIndex) , itemContent
 
    m.top.event = {
        type: "SELECT",
        data: { imagen:"pkg:/images/profiles/usuario.jpg"
                text:"PRUEBA"
    }
    }

end sub

function OnkeyEvent(key as string, press as boolean) as boolean
    handle = true
    if press
        if key ="right"
            if m.category_list.hasFocus() then m.rowlist.setFocus(true)
            handle = true
        else if  key ="left"
            if m.rowlist.hasFocus() then m.category_list.setFocus(true)
            handle = true
        end if 
    end if         
    return handle    

end function


