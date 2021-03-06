exports.nodemain = function() {
    var dst = "/usr/share/nginx/www/";
    var src = "/home/rasmuserik/solsort/sites/";
    console.log("copying sites to " + dst);
    var fs = require("fs");
    var util = require("./util");
    var rstat = function(root) {
        var acc = acc || [];
        var recurse = function(path) {
            var stat = fs.lstatSync(path);
            if(stat.isDirectory()) {
                fs.readdirSync(path).map(function(name) {
                    return path + "/" + name;
                }).forEach(recurse);
            } else  {
                var fobj = {name : path.replace(root, "")};
                fobj.type = path.replace(RegExp("^[^.]*\\."), "");
                if(stat.isSymbolicLink()) {
                    fobj.symlink = true;
                };
                acc.push(fobj);
            };
        };
        recurse(root);
        return acc;
    };
    var sitemaps = {};
    var includeFiles = {};
    var replacer = function(str, obj) {
        return str.replace(RegExp("\\{\\{([^{}]*)\\}\\}", "g"), function(_, s) {
            s = s.split(" ");
            if(obj[s[0]]) {
                return obj[s[0]];
            };
        });
    };
    var savehtml = function(filename, html, replace) {
        replace = replace || {};
        html.replace(RegExp("<title>([\\s\\S]*)</title>"), function(_, title) {
            replace.title = replace.title || title;
        });
        html = replacer(html, replace);
        var site = filename.split("/")[1];
        var path = filename.split("/").slice(2).join("/");
        var sitemap = sitemaps[site] = sitemaps[site] || {};
        sitemap[path] = {};
        sitemap[path].title = replace.title;
        //console.log(sitemaps);
        filename = dst + filename;
        fs.writeFile(filename, html.replace(RegExp("=\"http(s?):/(/[^\"]*\")", "g"), function(_, s, url) {
            return "=\"/redirect" + (s && "/s") + url;
        }));
    };
    (function() {
        var files = rstat(process.env.HOME + "/solsort/sites");
        util.mkdir(dst + "/common/js/");
        util.cp("./build/webjs/solsort.js", dst + "/common/js/solsort.js", function(err) {
            if(err) {
                console.log("Error:", err, "solsort.js");
            };
        });
        files.map(function(file) {
            util.mkdir(dst + file.name.split("/").slice(0, - 1).join("/"));
            if(file.symlink) {
                require("child_process").spawn("cp", [
                    "-a",
                    src + file.name,
                    dst + file.name,
                ]);
            } else  {
                if(file.type === "html") {
                    fs.readFile(src + file.name, "utf8", function(err, html) {
                        savehtml(file.name, html);
                    });
                } else if(file.type === "md") {
                    fs.readFile(src + file.name, "utf8", function(err, markdown) {
                        if(file.name.split("/").slice(- 1)[0] === "README.md") {
                            return undefined;
                        };
                        var doc = {title : file.name.split("/").slice(- 1)[0].slice(0, - 3)};
                        markdown = markdown.split("\n");
                        if(markdown[0][0] === "%") {
                            doc.title = markdown[0].slice(1).trim();
                            markdown.shift();
                            if(markdown[0][0] === "%") {
                                doc.author = markdown[0].slice(1).trim();
                                markdown.shift();
                                if(markdown[0][0] === "%") {
                                    doc.date = markdown[0].slice(1).trim();
                                    markdown.shift();
                                };
                            };
                        };
                        markdown = markdown.join("\n").replace(RegExp("<!--.*?-->", "g"), "");
                        doc.content = require("markdown").markdown.toHTML(markdown);
                        var templatename = src + file.name.split("/").slice(0, - 1).join("/") + "/markdown.template.html";
                        fs.readFile(templatename, "utf8", function(err, html) {
                            if(err) {
                                console.log(file.name);
                                return console.log("could not access:", templatename);
                            };
                            savehtml(file.name.slice(0, - 2) + "html", html, doc);
                        });
                    });
                } else if(file.type === "less") {
                    fs.readFile(src + file.name, "utf8", function(err, less) {
                        util.trycatch(function() {
                        require("less").render(less, function (err, css) {
                            if(err) {
                                console.log(file.name, err, file);
                            }
                            fs.writeFile(dst + file.name.replace(".less", ".css"), css);
                        });
                        }, function(err) {
                            console.log(err);
                        });
                    });
                } else  {
                    util.cp(src + file.name, dst + file.name, function(err) {
                        //console.log('Error:', err, file);
                    });
                };
            };
        });
        require("child_process").exec("cp -a ~/lightscript/build/apps/* /usr/share/nginx/www/solsort/apps/");
        require("child_process").exec("cp -a ~/solsort/sites/* /usr/share/nginx/www/", function(err, stdout, stderr) {
            console.log("done");
            if(err) {
                console.log("Error:", err);
            };
        });
    })();
};
