// http://stackoverflow.com/questions/20197471/how-to-display-line-numbers-in-ipython-notebook-code-cell-by-default
IPython.Cell.options_default.cm_config.lineNumbers = true;

// http://stackoverflow.com/questions/23540870/ipython-notebook-how-to-toggle-header-invisible-by-default
$([IPython.events]).on("app_initialized.NotebookApp", function () {
    $('div#header-container').hide();
});
