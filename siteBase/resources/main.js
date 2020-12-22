// from the right
// 1 - dark mode
// 2 - compatability mode
var brightnether = "BRIGHT NETHER"
var compatabilitymode = "COMPATABILITY MODE [ALPHA]"
var id = window.location.href.split('/').slice(-2)[0]
document.write('<div class="content">')
document.write('<div class="right">')
document.write('<a href="https://github.com/jebbyk/OSBES-minecraft-bedrock-edition-shader" style="color: cyan;font-size: 15px;">GitHub Page</a>')
document.write('</div>')
document.write('<img src="../resources/logo.png"></img>')
document.write('<br>')
document.write('<br>')
document.write('<div class="checkboxes">')
function info(option) {
  output = "<span title='"
  switch (option) {
    case "brightnether":
      output += "Brightens the nether"
      break
    case "compatabilitymode":
      output += "Disables normal and specular maps. This allows the use of other resource packs at the expense of the textures having less depth and no shine.\n\n!!!WARNING!!!\nThis feature is currently incredibly buggy, and many parts of the game don&#39;t look right."
      break
  }
  output += "'><img src='../resources/info.png'></img></span>"
  return output
}
  switch (id) {
    case "00":
      document.write(brightnether + ' <a href="../01"><img src="../resources/uncheck.png"></img></a>'+info("brightnether")+'<br>')
      document.write(compatabilitymode + ' <a href="../10"><img src="../resources/uncheck.png"></img></a>' + info("compatabilitymode") + '<br>')
      break
    case "01":
      document.write(brightnether + ' <a href="../00"><img src="../resources/check.png"></img></a>' + info("brightnether") + '<br>')
      document.write(compatabilitymode + ' <a href="../11"><img src="../resources/uncheck.png"></img></a>' + info("compatabilitymode") + '<br>')
      break
    case "10":
      document.write(brightnether + ' <a href="../11"><img src="../resources/uncheck.png"></img></a>' + info("brightnether") + '<br>')
      document.write(compatabilitymode + ' <a href="../00"><img src="../resources/check.png"></img></a>' + info("compatabilitymode") + '<br>')
      break
    case "11":
      document.write(brightnether + ' <a href="../10"><img src="../resources/check.png"></img></a>' + info("brightnether") + '<br>')
      document.write(compatabilitymode + ' <a href="../01"><img src="../resources/check.png"></img></a>' + info("compatabilitymode") + '<br>')
      break
}
document.write('</div>')
document.write('<br>')
document.write('<a href="../packs/' + id + '.mcpack"  style="color: lime">download</a>')
document.write("</div>")