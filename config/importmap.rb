# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# not default
pin "flowbite", to: "https://cdn.jsdelivr.net/npm/flowbite@2.5.1/dist/flowbite.turbo.min.js"

# node-html-markdown
pin "node-html-markdown", to: "https://ga.jspm.io/npm:node-html-markdown@1.3.0/dist/index.js"
pin "boolbase", to: "https://ga.jspm.io/npm:boolbase@1.0.0/index.js"
pin "css-select", to: "https://ga.jspm.io/npm:css-select@5.1.0/lib/index.js"
pin "css-what", to: "https://ga.jspm.io/npm:css-what@6.1.0/lib/es/index.js"
pin "dom-serializer", to: "https://ga.jspm.io/npm:dom-serializer@2.0.0/lib/index.js"
pin "domelementtype", to: "https://ga.jspm.io/npm:domelementtype@2.3.0/lib/index.js"
pin "domhandler", to: "https://ga.jspm.io/npm:domhandler@5.0.3/lib/index.js"
pin "domutils", to: "https://ga.jspm.io/npm:domutils@3.1.0/lib/index.js"
pin "entities", to: "https://ga.jspm.io/npm:entities@4.5.0/lib/index.js"
pin "he", to: "https://ga.jspm.io/npm:he@1.2.0/he.js"
pin "node-html-parser", to: "https://ga.jspm.io/npm:node-html-parser@6.1.5/dist/index.js"
pin "nth-check", to: "https://ga.jspm.io/npm:nth-check@2.1.1/lib/index.js"
pin "process", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/process-production.js"
