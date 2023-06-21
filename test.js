const getFormatId = function (ext) {
  // Sheets
  if (ext === 'xlsx') { return 257; }
  if (ext === 'xls') { return 258; }
  if (ext === 'ods') { return 259; }
  if (ext === 'csv') { return 260; }
  if (ext === 'pdf') { return 513; }
  // Docs
  if (ext === 'docx') { return 65; }
  if (ext === 'doc') { return 66; }
  if (ext === 'odt') { return 67; }
  if (ext === 'txt') { return 69; }
  if (ext === 'html') { return 70; }

  // Slides
  if (ext === 'pptx') { return 129; }
  if (ext === 'ppt') { return 130; }
  if (ext === 'odp') { return 131; }

  return;
};

const getFromId = function (ext) {
  var id = getFormatId(ext);
  if (!id) { return ''; }
  return '<m_nFormatFrom>'+id+'</m_nFormatFrom>';
};

const getToId = function (ext) {
  var id = getFormatId(ext);
  if (!id) { return ''; }
  return '<m_nFormatTo>'+id+'</m_nFormatTo>';
};

const x2t = require('./x2t');

x2t.onRuntimeInitialized = function() {
  console.log("on init");
  x2t.FS.mkdir('/working');
  x2t.FS.mkdir('/working/media');
  x2t.FS.mkdir('/working/fonts');
  x2t.FS.mkdir('/working/themes');
  const fileName = "testsheet.bin";
  const outputFormat = "xlsx";
  const pdfData = "";
  const inputFormat = "bin";
  const params =  "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
    + "<TaskQueueDataConvert xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">"
    + "<m_sFileFrom>/working/" + fileName + "</m_sFileFrom>"
    + "<m_sThemeDir>/working/themes</m_sThemeDir>"
    + "<m_sFileTo>/working/" + fileName + "." + outputFormat + "</m_sFileTo>"
    + pdfData
    + getFromId(inputFormat)
    + getToId(outputFormat)
    + "<m_bIsNoBase64>false</m_bIsNoBase64>"
    + "</TaskQueueDataConvert>";

  console.log("params: ", params);
  x2t.FS.writeFile('/working/params.xml', params);
  x2t.FS.createLazyFile('/working/', fileName, fileName, true, false);
  const result = x2t.ccall("main1", "number", ["string"], ["/working/params.xml"]);
  console.log(result);
  console.log(x2t.FS.readdir('/working/'));
};
