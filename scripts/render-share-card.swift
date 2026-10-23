import AppKit
import CoreText

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let width = 1200, height = 630
let canvas = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: width, pixelsHigh: height, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: canvas)
let context = NSGraphicsContext.current!.cgContext
context.interpolationQuality = .high
func color(_ hex: UInt32, _ alpha: CGFloat = 1) -> NSColor {
    NSColor(srgbRed: CGFloat((hex >> 16) & 255)/255, green: CGFloat((hex >> 8) & 255)/255, blue: CGFloat(hex & 255)/255, alpha: alpha)
}
func rect(_ x: CGFloat, _ top: CGFloat, _ w: CGFloat, _ h: CGFloat) -> NSRect { NSRect(x:x, y:CGFloat(height)-top-h, width:w, height:h) }
func text(_ value: String, x: CGFloat, top: CGFloat, size: CGFloat, font: String, tint: NSColor, w: CGFloat = 700) {
    let face = NSFont(name: font, size: size) ?? NSFont.systemFont(ofSize:size, weight:.bold)
    let style = NSMutableParagraphStyle(); style.lineBreakMode = .byClipping
    (value as NSString).draw(in:rect(x, top, w, size*1.4), withAttributes:[.font:face, .foregroundColor:tint, .paragraphStyle:style])
}
let bg = color(0x030714), red = color(0xFA303B), white = color(0xF5F4F1)
bg.setFill(); NSRect(x:0,y:0,width:width,height:height).fill()
let image = NSImage(contentsOf:root.appendingPathComponent("assets/hero-amanda-original.png"))!
let scaledWidth = image.size.width * CGFloat(height) / image.size.height
image.draw(in:NSRect(x:-(scaledWidth-CGFloat(width))*0.78,y:0,width:scaledWidth,height:CGFloat(height)))
let overlay = NSGradient(colorsAndLocations:(bg,0),(bg.withAlphaComponent(0.98),0.27),(bg.withAlphaComponent(0.7),0.48),(bg.withAlphaComponent(0),0.73))!
overlay.draw(in:NSBezierPath(rect:NSRect(x:0,y:0,width:width,height:height)),angle:0)
let bottom = NSGradient(starting:bg.withAlphaComponent(0.9),ending:bg.withAlphaComponent(0))!
bottom.draw(in:NSBezierPath(rect:NSRect(x:0,y:0,width:width,height:240)),angle:90)
CTFontManagerRegisterFontsForURL(root.appendingPathComponent("assets/fonts/figtree-variable.ttf") as CFURL,.process,nil)
text("BLACK",x:60,top:42,size:57,font:"EtnaXCondensed-Bold",tint:white)
text("FRIDAY",x:201,top:42,size:57,font:"EtnaXCondensed-Bold",tint:red)
text("A MAIOR OPORTUNIDADE DO ANO",x:62,top:123,size:18,font:"Figtree-SemiBold",tint:color(0xBEC5D3))
text("PÓS-GRADUAÇÃO EM",x:60,top:177,size:76,font:"EtnaXCondensed-Bold",tint:white)
text("DIREITO",x:60,top:267,size:88,font:"EtnaXCondensed-Bold",tint:red)
text("CONCORRENCIAL",x:60,top:365,size:88,font:"EtnaXCondensed-Bold",tint:red)
let pill = NSBezierPath(roundedRect:rect(62,506,390,62),xRadius:31,yRadius:31)
NSGradient(starting:color(0x004723),ending:color(0x00E871))!.draw(in:pill,angle:0)
white.withAlphaComponent(0.68).setStroke(); pill.lineWidth = 1; pill.stroke()
text("17 DE NOVEMBRO · 20H",x:88,top:520,size:23,font:"Figtree-Bold",tint:white,w:360)
let caption = NSBezierPath(roundedRect:rect(844,514,298,73),xRadius:8,yRadius:8)
color(0x080E1B,0.88).setFill();caption.fill();white.withAlphaComponent(0.16).setStroke();caption.lineWidth=1;caption.stroke()
text("Amanda Athayde",x:864,top:526,size:23,font:"Figtree-SemiBold",tint:white,w:260)
text("Direito Concorrencial",x:864,top:557,size:17,font:"Figtree-Regular",tint:color(0xC6CBD5),w:260)
red.setFill();NSRect(x:0,y:0,width:width,height:5).fill()
NSGraphicsContext.restoreGraphicsState()
let output = root.appendingPathComponent("assets/compartilhamento-black-friday-v1.jpg")
try canvas.representation(using:.jpeg, properties:[.compressionFactor:0.92])!.write(to:output)
print(output.path)
