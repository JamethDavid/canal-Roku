sub calculateTranslation(node as object) as object
    r = getUIResolution()
    b = node.boundingRect()

    x = r.width * 0.7
    y = (r.height - b.height) * 0.9

    translation = [x, y]

    return translation
end sub

function getUIResolution() as object
    di = createObject("roDeviceInfo")
    return di.getUIResolution()
end function
