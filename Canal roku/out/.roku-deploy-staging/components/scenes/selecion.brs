sub init()
    m.jsonParser = createObject("roSGNode", "JsonParser")
    m.jsonParser.functionName = "getJsonFile"
    m.jsonParser.observeField("content", "setContent")
    m.jsonParser.jsonFilePath = "pkg:/source/json/profiles.json"
    m.jsonParser.control = "run"

    m.profiles = m.top.findNode("profiles")
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.top.observeField("focusedChild", "onFocusChanged")
    'm.poster.observeField("pressed", "onPosterPressed")
end sub

sub setContent(event as object)
    content = event.getData()
    for i = 0 to content.count() - 1
        profileItem = content[i]
        profile = createObject("roSGNode", "customItem")
        profile.id = profileItem.id
        profile.labelText = profileItem.name
        profile.posterUri = profileItem.imagePath
       m.profiles.appendChild(profile)
    end for

    print profileItem.name

    m.top.index = 0
    m.top.maxIndex = m.profiles.getChildCount() - 1
    m.layoutGroup.translation = calculateTranslation(m.layoutGroup)
end sub

sub onFocusChanged()
    if m.top.isInFocusChain() and m.lastFocused <> invalid then
        m.profiles.getChild(m.top.index).setFocus(true)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handle = false
    if press
        if key = "right"
            if m.top.index < m.top.maxIndex
                m.top.index++
                print "index++ ", m.top.index
            end if
        else if key = "left"
            if m.top.index > 0
                m.top.index--
                print "index-- ", m.top.index
            end if
        else if key = "OK"
            if m.profiles.getChild(m.top.index).hasFocus()
                m.top.event = {
                    type: "PROFILE_SELECTED",
                    data: { }
                }
            end if
        end if
       
     end if
    return handle
end function

sub onIndexChange(event as object)
    index = event.getData()
    m.profiles.getChild(index).setFocus(true)
end sub


