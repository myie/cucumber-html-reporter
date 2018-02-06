var nodeenvconfiguration = require('node-env-configuration');
var reporter = require('cucumber-html-reporter');

var defaults = {
    theme: 'bootstrap',
    jsonFile: 'in/report.json',
    output: 'out/report.html',
    reportSuiteAsScenarios: true,
    launchReport: true,
    metadata: {
        "platform": "Linux"
   }
};

// see https://github.com/whynotsoluciones/node-env-configuration 
var options = nodeenvconfiguration({
    defaults: defaults,
    prefix: 'chrApp' // Read only env vars starting with CHR_APP prefix
});    

reporter.generate(options);
