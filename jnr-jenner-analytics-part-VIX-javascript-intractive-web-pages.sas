/*---
c:/utl/jnr-jenner-analytics-part-VIX-javascript-intractive-web-pages.sas;
---*/

Jenner Analytics part VIX javascript intractive web pages

To long to post,see
https://github.com/rogerjdeangelis/jnr-jenner-analytics-part-VIX-javascript-intractive-web-pages.sas

Problem Create Javascript Web pages to display any binary logic

 PAGE 1
                 ---
   Enter M or F  |M|
                 ---
   Result Male

 PAGE 2
                ---
  Enter C or P  |P|
                ---
  Result Parent

 USAGE

  %javascript_binary(fro1=M,to1=Male,fro2=F,to2=Female);
  %sysfunc(sleep(5)); /*-- pause 5 seconds ---*/
  %javascript_binary(fro1=C,to1=Child,fro2=P,to2=Parent);

  Contents
      1 Javascript create interactive web pages
      2 Related repositories

 Note SAS and the SLC do not support macro triggers in proc python or R.
      Also note you may need to esacpe triggers if the triggers are neeed for R or python.

 Other inline languages
https://github.com/rogerjdeangelis/jnr-jenner-analytics-part-I-inline-drop-down-to-duckdb-sql
https://github.com/rogerjdeangelis/jnr-jenner-analytics-part-II-drop-down-to-open-source-spss-run-regression
https://github.com/rogerjdeangelis/jnr-jenner-analytics-part-III-inline-drop-down-to-open-source-matlab-summarize-data
https://github.com/rogerjdeangelis/jnr-jenner-analytics-part-IV-inline-drop-down-to-poweshell-add-column-to-excell-sheet
https://github.com/rogerjdeangelis/nr-jenner-analytics-part-V-proc-R-macro-wrapper-and-resolving-macro-triggers-within-R
https://github.com/rogerjdeangelis/jnr-jenner-analytics-part-VI-proc-R-macro-wrapper-and-resolving-macro-triggers-within-R
https://github.com/rogerjdeangelis/jnr-jenner-analytics-part-VII-inline-drop-down-to-perl
https://github.com/rogerjdeangelis/jnr-jenner-analytics-part-VIII-excel-update-sheet-in-place-using-sql-keeping-all-formatting
https://github.com/rogerjdeangelis/jnr-jenner-analytics-part-VIX-javascript-intractive-web-pages.sas














/******************************************************************************************************************/
/* 1 JAVASCRIPT CREATE INTERACTIVE WEB PAGES                                                                      */
/******************************************************************************************************************/

%macro javascript_binary(fro1=M,to1=Male,fro2=F,to2=Female);

options set=PROC_PYPATH "D:\py314\python.exe";
proc python;
submit;
from pathlib import Path
import subprocess
import tempfile

html = """<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Binary Lookup</title>
</head>
<body>

  <label for="gender">Enter &fro1 or &fro2:</label>
  <input type="text" id="gender" autocomplete="off" autofocus>

  <p>Result: <span id="result" aria-live="polite"></span></p>

  <script>
    const input = document.getElementById("gender");
    const result = document.getElementById("result");

    let closing = false;

    input.addEventListener("input", function () {
      if (closing) return;

      const value = input.value.trim().toUpperCase();

      if (value === "&fro1".toUpperCase()) {
        result.textContent = "&to1";
      } else if (value === "&fro2".toUpperCase()) {
        result.textContent = "&to2";
      } else {
        result.textContent = "";
        return;
      }

      closing = true;
      input.disabled = true;

      setTimeout(function () {
        window.close();

        // Fallback if Chrome blocks the close request.
        result.textContent += " - Finished. You can close this window.";
      }, 1000);
    });
  </script>

</body>
</html>
"""

chrome = Path(r"C:\Program Files\Google\Chrome\Application\chrome.exe")

with tempfile.NamedTemporaryFile(
    mode="w",
    suffix=".html",
    encoding="utf-8",
    delete=False
) as temp:
    temp.write(html)
    page = Path(temp.name)

if not chrome.is_file():
    raise FileNotFoundError(f"Chrome not found: {chrome}")

if not page.is_file():
    raise FileNotFoundError(f"HTML file not found: {page}")

subprocess.Popen([
    str(chrome),
    "--new-window",
    page.resolve().as_uri()
])
endsubmit;
run;

%mend javascript_binary;

%javascript_binary(fro1=M,to1=Male,fro2=F,to2=Female);
%javascript_binary;
%sysfunc(sleep(5)); /*-- pause 5 seconds ---*/
%javascript_binary(fro1=C,to1=Child,fro2=P,to2=Parent);

/******************************************************************************************************************/
/* 2 RELATED REPOSITORIES                                                                                         */
/******************************************************************************************************************/

Related Pepositories
---------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-creating-a-web-server-dashboad-app-using-r-shiny
https://github.com/rogerjdeangelis/utl-running-a-wep-app-on-a-local-web-server-using-python-flask
https://github.com/rogerjdeangelis/utl_scraping_javascript_generated_html_web_pages
https://github.com/rogerjdeangelis/utl_javascript_and_classic_map_graphics_with_mouseovers_and_multiple_drilldowns
https://github.com/rogerjdeangelis/utl_scrape_javascript_converting_table_to_sas_dataset_no_browser
https://github.com/rogerjdeangelis/utl_scraping_javascript_generated_html_web_pages
https://github.com/rogerjdeangelis/utl-dygraph-javascript-library-from-MIT
https://github.com/rogerjdeangelis/utl_javascript_dygraph_graphics_multipanel_time_series
https://github.com/rogerjdeangelis/utl-chapter-III-ultraedit-macros-javascript-for-sas-compatible-systems

/*--- END ---*/
